import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/mission.dart';
import '../../services/driver_price_calculator.dart';
import '../../services/mission_reservation_service.dart';

class MissionReservationScreen extends StatefulWidget {
  final Mission mission;

  const MissionReservationScreen({
    super.key,
    required this.mission,
  });

  @override
  State<MissionReservationScreen> createState() =>
      _MissionReservationScreenState();
}

class _MissionReservationScreenState extends State<MissionReservationScreen> {
  final MissionReservationService _reservationService =
      MissionReservationService();
  final DriverPriceCalculator _priceCalculator = DriverPriceCalculator();

  bool _isLoadingPickup = true;
  bool _isLoadingDelivery = false;
  bool _isSaving = false;

  List<PickupSlot> _pickupSlots = [];
  PickupSlot? _selectedPickup;

  List<DeliverySlot> _deliverySlots = [];
  DeliverySlot? _selectedDelivery;

  String? _errorMessage;

  final DateFormat _slotFormatter =
      DateFormat("EEEE d MMMM yyyy 'à' HH:mm", 'fr_FR');

  @override
  void initState() {
    super.initState();
    _loadPickupSlots();
  }

  Future<void> _loadPickupSlots() async {
    setState(() {
      _isLoadingPickup = true;
      _errorMessage = null;
      _pickupSlots = [];
      _selectedPickup = null;
      _deliverySlots = [];
      _selectedDelivery = null;
    });

    try {
      final mission = widget.mission;

      // On se base sur availability_start / delivery_deadline pour la fourchette
      final DateTime start =
          (mission.availabilityStart ?? DateTime.now()).toLocal();
      final DateTime end =
          (mission.deliveryDeadline ?? start).toLocal();

      final slots = await _reservationService.getAvailablePickupSlots(
        missionId: mission.id,
        startDate: start,
        endDate: end,
      );

      setState(() {
        _pickupSlots = slots;
        _isLoadingPickup = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            "Erreur lors du chargement des créneaux de départ : $e";
        _isLoadingPickup = false;
      });
    }
  }

  Future<void> _loadDeliverySlotsForPickup(PickupSlot pickup) async {
    setState(() {
      _isLoadingDelivery = true;
      _errorMessage = null;
      _deliverySlots = [];
      _selectedDelivery = null;
    });

    try {
      final slots = await _reservationService.getAvailableDeliverySlots(
        missionId: widget.mission.id,
        pickupDatetimeLocal: pickup.pickupDatetime,
      );

      setState(() {
        _deliverySlots = slots;
        _isLoadingDelivery = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            "Erreur lors du chargement des créneaux d'arrivée : $e";
        _isLoadingDelivery = false;
      });
    }
  }

  Future<void> _confirmReservation() async {
    if (_selectedPickup == null || _selectedDelivery == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Merci de choisir un horaire de départ et un horaire d'arrivée."),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final pickup = _selectedPickup!.pickupDatetime;
      final delivery = _selectedDelivery!.deliveryDatetime;

      // 1) Validation côté backend (mêmes règles que sur le site)
      final validation = await _reservationService.validateReservationTimes(
        missionId: widget.mission.id,
        pickupDatetimeLocal: pickup,
        deliveryDatetimeLocal: delivery,
      );

      if (!validation.isValid) {
        setState(() {
          _isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              validation.errorMessage ??
                  "Créneau invalide (${validation.errorCode ?? 'erreur inconnue'})",
            ),
            backgroundColor: AppTheme.errorColor,
          ),
        );
        return;
      }

      // 2) Calcul du prix driver (même logique que dans MissionDetailScreen._bookMission)
      final options = {
        'document_management': widget.mission.documentManagement ?? false,
        'basic_handover': widget.mission.basicHandover ?? false,
        'comfort_handover': widget.mission.comfortHandover ?? false,
        'basic_washing': widget.mission.basicWashing ?? false,
        'standard_washing': widget.mission.standardWashing ?? false,
        'premium_washing': widget.mission.premiumWashing ?? false,
        'w_garage': widget.mission.wGarage ?? false,
        'electric_vehicle': widget.mission.electricVehicle ?? false,
      };

      final isReturn = (widget.mission.isReturnMission ?? false) ||
          (widget.mission.missionType == 'livraison_reprise');

      final driverStatus =
          await _priceCalculator.getCurrentDriverStatus() ??
              'active_beginner';

      final reservedPrice = await _priceCalculator.calculateFinalDriverPrice(
        distanceKm: (widget.mission.distanceMission ?? 0).toDouble(),
        driverStatus: driverStatus,
        options: options,
        isReturnMission: isReturn,
      );

      // 3) Réservation en base (driver_id + status + horaires + prix)
      await _reservationService.reserveMission(
        missionId: widget.mission.id,
        pickupDatetimeLocal: pickup,
        deliveryDatetimeLocal: delivery,
        reservedDriverPrice: reservedPrice,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mission réservée avec succès !'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      // On remonte "true" au parent pour qu'il rafraîchisse la mission
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la réservation : $e'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mission = widget.mission;

    return Scaffold(
      appBar: AppBar(
        title: Text('Réserver la mission ${mission.missionNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_errorMessage != null) ...[
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- STEP 1 : PICKUP ---
                    Text(
                      '1. Choisissez votre horaire de départ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_isLoadingPickup)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_pickupSlots.isEmpty)
                      const Text(
                        "Aucun créneau de départ disponible pour cette mission.",
                        style: TextStyle(color: Colors.red),
                      )
                    else
                      Column(
                        children: _pickupSlots.map((slot) {
                          final isSelected = _selectedPickup == slot;
                          return RadioListTile<PickupSlot>(
                            value: slot,
                            groupValue: _selectedPickup,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedPickup = value;
                                _selectedDelivery = null;
                                _deliverySlots = [];
                              });
                              _loadDeliverySlotsForPickup(value);
                            },
                            title: Text(
                              _slotFormatter.format(slot.pickupDatetime),
                            ),
                            activeColor: AppTheme.primaryColor,
                            selected: isSelected,
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 24),

                    // --- STEP 2 : DELIVERY ---
                    Text(
                      '2. Choisissez votre horaire d’arrivée',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_selectedPickup == null)
                      const Text(
                        "Sélectionnez d'abord un horaire de départ.",
                        style: TextStyle(color: Colors.grey),
                      )
                    else if (_isLoadingDelivery)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_deliverySlots.isEmpty)
                      const Text(
                        "Aucun créneau d'arrivée disponible pour cet horaire de départ.",
                        style: TextStyle(color: Colors.red),
                      )
                    else
                      Column(
                        children: _deliverySlots.map((slot) {
                          final isSelected = _selectedDelivery == slot;
                          final isSameDay = slot.isSameDay;

                          return RadioListTile<DeliverySlot>(
                            value: slot,
                            groupValue: _selectedDelivery,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedDelivery = value;
                              });
                            },
                            title: Text(
                              _slotFormatter.format(slot.deliveryDatetime),
                            ),
                            subtitle: isSameDay
                                ? const Text(
                                    "Même jour",
                                    style: TextStyle(fontSize: 12),
                                  )
                                : const Text(
                                    "J+1",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            activeColor: AppTheme.primaryColor,
                            selected: isSelected,
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _confirmReservation,
              child: _isSaving
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Confirmer la réservation',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
