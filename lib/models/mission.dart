class Mission {
  final String id;
  final String missionNumber;
  final String customerId;
  final String? driverId;
  final String status;
  final String? missionStatusDriver;

  final String departureAddress;
  final String? departureCity;
  final String? departurePostalCode;
  final double? departureLatitude;
  final double? departureLongitude;
  final String? departureCityDisplay;

  final String arrivalAddress;
  final String? arrivalCity;
  final String? arrivalPostalCode;
  final double? arrivalLatitude;
  final double? arrivalLongitude;
  final String? arrivalCityDisplay;

  final DateTime? pickupDatetime;
  final DateTime? deliveryDatetime;
  final DateTime? deliveryDeadline;
  final DateTime? availabilityStart;

  final String vehicleType;
  final double? baseDriverPrice;
  final double? distanceMission;

  /// ✅ prix réservé enregistré lors de la réservation
  final double? reservedDriverPrice;

  final String? vehicleImageUrl;
  final bool? basicHandover;
  final bool? comfortHandover;
  final bool? documentManagement;
  final bool? wGarage;
  final bool? basicWashing;
  final bool? standardWashing;
  final bool? premiumWashing;

  final String? fuelManagement;
  final String? companyLogoUrl;
  final String? customerType;
  final String? estimatedTravelTime;

  /// Pour le calcul de prix
  final bool? electricVehicle;
  final bool? isReturnMission;
  final String? missionType;

  final String? departureInspectionId;
  final String? arrivalInspectionId;

  // ✅ Nouveaux champs pour Contacts
  final String? departureContactName;
  final String? departureContactPhone;
  final String? arrivalContactName;
  final String? arrivalContactPhone;

  // ✅ Nouveaux champs pour Véhicule
  final String? vehicleRegistration;
  final String? vehicleChassisNumber;
  final String? vehicleTransmission;
  final int? vehicleSeats;

  // ✅ Nouveaux champs pour Itinéraire
  final String? departureLocationType;
  final String? departurePlaceName;
  final String? arrivalLocationType;
  final String? arrivalPlaceName;

  // ✅ Nouveau champ : Notes pour le convoyeur
  final String? vehicleNotes;

  final DateTime createdAt;
  final DateTime updatedAt;

  Mission({
    required this.id,
    required this.missionNumber,
    required this.customerId,
    this.driverId,
    required this.status,
    this.missionStatusDriver,
    required this.departureAddress,
    this.departureCity,
    this.departurePostalCode,
    this.departureLatitude,
    this.departureLongitude,
    this.departureCityDisplay,
    required this.arrivalAddress,
    this.arrivalCity,
    this.arrivalPostalCode,
    this.arrivalLatitude,
    this.arrivalLongitude,
    this.arrivalCityDisplay,
    this.pickupDatetime,
    this.deliveryDatetime,
    this.deliveryDeadline,
    this.availabilityStart,
    required this.vehicleType,
    this.baseDriverPrice,
    this.distanceMission,
    this.reservedDriverPrice,
    this.vehicleImageUrl,
    this.basicHandover,
    this.comfortHandover,
    this.documentManagement,
    this.wGarage,
    this.basicWashing,
    this.standardWashing,
    this.premiumWashing,
    this.fuelManagement,
    this.companyLogoUrl,
    this.customerType,
    this.estimatedTravelTime,
    this.electricVehicle,
    this.isReturnMission,
    this.missionType,
    this.departureInspectionId,
    this.arrivalInspectionId,
    this.departureContactName,
    this.departureContactPhone,
    this.arrivalContactName,
    this.arrivalContactPhone,
    this.vehicleRegistration,
    this.vehicleChassisNumber,
    this.vehicleTransmission,
    this.vehicleSeats,
    this.departureLocationType,
    this.departurePlaceName,
    this.arrivalLocationType,
    this.arrivalPlaceName,
    this.vehicleNotes, // ✅ ajouté ici
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    final logo = json['company_logo_url']?.toString();

    return Mission(
      id: json['id'].toString(),
      missionNumber: json['mission_number']?.toString() ?? "",
      customerId: json['customer_id']?.toString() ?? "",
      driverId: json['driver_id']?.toString(),
      status: json['status'].toString(),
      missionStatusDriver: json['missionstatusdriver']?.toString(),
      departureAddress: json['departure_address'].toString(),
      departureCity: json['departure_city']?.toString(),
      departurePostalCode: json['departure_postal_code']?.toString(),
      departureLatitude: json['departure_latitude'] != null
          ? (json['departure_latitude'] as num).toDouble()
          : null,
      departureLongitude: json['departure_longitude'] != null
          ? (json['departure_longitude'] as num).toDouble()
          : null,
      departureCityDisplay: json['departure_city_display']?.toString(),
      arrivalAddress: json['arrival_address'].toString(),
      arrivalCity: json['arrival_city']?.toString(),
      arrivalPostalCode: json['arrival_postal_code']?.toString(),
      arrivalLatitude: json['arrival_latitude'] != null
          ? (json['arrival_latitude'] as num).toDouble()
          : null,
      arrivalLongitude: json['arrival_longitude'] != null
          ? (json['arrival_longitude'] as num).toDouble()
          : null,
      arrivalCityDisplay: json['arrival_city_display']?.toString(),
      pickupDatetime: json['pickup_datetime'] != null
          ? DateTime.parse(json['pickup_datetime'].toString())
          : null,
      deliveryDatetime: json['delivery_datetime'] != null
          ? DateTime.parse(json['delivery_datetime'].toString())
          : null,
      deliveryDeadline: json['delivery_deadline'] != null
          ? DateTime.parse(json['delivery_deadline'].toString())
          : null,
      availabilityStart: json['availability_start'] != null
          ? DateTime.parse(json['availability_start'].toString())
          : null,
      vehicleType: json['vehicle_type'].toString(),
      baseDriverPrice: json['base_driver_price'] != null
          ? (json['base_driver_price'] as num).toDouble()
          : null,
      distanceMission: json['distance_mission'] != null
          ? (json['distance_mission'] as num).toDouble()
          : null,
      reservedDriverPrice: json['reserved_driver_price'] != null
          ? (json['reserved_driver_price'] as num).toDouble()
          : null,
      vehicleImageUrl: json['vehicle_image_url']?.toString(),
      basicHandover: json['basic_handover'] as bool?,
      comfortHandover: json['comfort_handover'] as bool?,
      documentManagement: json['document_management'] as bool?,
      wGarage: json['w_garage'] as bool?,
      basicWashing: json['basic_washing'] as bool?,
      standardWashing: json['standard_washing'] as bool?,
      premiumWashing: json['premium_washing'] as bool?,
      fuelManagement: json['fuel_management']?.toString(),
      companyLogoUrl: logo,
      customerType: json['customer_type']?.toString(),
      estimatedTravelTime: json['estimated_travel_time']?.toString(),
      electricVehicle: json['electric_vehicle'] as bool?,
      isReturnMission: json['is_return_mission'] as bool?,
      missionType: json['mission_type']?.toString(),
      departureInspectionId: json['departure_inspection_id']?.toString(),
      arrivalInspectionId: json['arrival_inspection_id']?.toString(),
      departureContactName: json['departure_contact_name']?.toString(),
      departureContactPhone: json['departure_contact_phone']?.toString(),
      arrivalContactName: json['arrival_contact_name']?.toString(),
      arrivalContactPhone: json['arrival_contact_phone']?.toString(),
      vehicleRegistration: json['vehicle_registration']?.toString(),
      vehicleChassisNumber: json['vehicle_chassis_number']?.toString(),
      vehicleTransmission: json['vehicle_transmission']?.toString(),
      vehicleSeats: json['vehicle_seats'] != null
          ? int.tryParse(json['vehicle_seats'].toString())
          : null,
      departureLocationType: json['departure_location_type']?.toString(),
      departurePlaceName: json['departure_place_name']?.toString(),
      arrivalLocationType: json['arrival_location_type']?.toString(),
      arrivalPlaceName: json['arrival_place_name']?.toString(),
      vehicleNotes: json['vehicle_notes']?.toString(), // ✅ ajouté ici
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mission_number': missionNumber,
      'customer_id': customerId,
      'driver_id': driverId,
      'status': status,
      'missionstatusdriver': missionStatusDriver,
      'departure_address': departureAddress,
      'departure_city': departureCity,
      'departure_postal_code': departurePostalCode,
      'departure_latitude': departureLatitude,
      'departure_longitude': departureLongitude,
      'departure_city_display': departureCityDisplay,
      'arrival_address': arrivalAddress,
      'arrival_city': arrivalCity,
      'arrival_postal_code': arrivalPostalCode,
      'arrival_latitude': arrivalLatitude,
      'arrival_longitude': arrivalLongitude,
      'arrival_city_display': arrivalCityDisplay,
      'pickup_datetime': pickupDatetime?.toIso8601String(),
      'delivery_datetime': deliveryDatetime?.toIso8601String(),
      'delivery_deadline': deliveryDeadline?.toIso8601String(),
      'availability_start': availabilityStart?.toIso8601String(),
      'vehicle_type': vehicleType,
      'base_driver_price': baseDriverPrice,
      'distance_mission': distanceMission,
      'reserved_driver_price': reservedDriverPrice,
      'vehicle_image_url': vehicleImageUrl,
      'basic_handover': basicHandover,
      'comfort_handover': comfortHandover,
      'document_management': documentManagement,
      'w_garage': wGarage,
      'basic_washing': basicWashing,
      'standard_washing': standardWashing,
      'premium_washing': premiumWashing,
      'fuel_management': fuelManagement,
      'company_logo_url': companyLogoUrl,
      'customer_type': customerType,
      'estimated_travel_time': estimatedTravelTime,
      'electric_vehicle': electricVehicle,
      'is_return_mission': isReturnMission,
      'mission_type': missionType,
      'departure_inspection_id': departureInspectionId,
      'arrival_inspection_id': arrivalInspectionId,
      'departure_contact_name': departureContactName,
      'departure_contact_phone': departureContactPhone,
      'arrival_contact_name': arrivalContactName,
      'arrival_contact_phone': arrivalContactPhone,
      'vehicle_registration': vehicleRegistration,
      'vehicle_chassis_number': vehicleChassisNumber,
      'vehicle_transmission': vehicleTransmission,
      'vehicle_seats': vehicleSeats,
      'departure_location_type': departureLocationType,
      'departure_place_name': departurePlaceName,
      'arrival_location_type': arrivalLocationType,
      'arrival_place_name': arrivalPlaceName,
      'vehicle_notes': vehicleNotes, // ✅ ajouté ici
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // =====================================================
  // MÉTHODES D’AIDE
  // =====================================================
  String get displayDeparture =>
      departureCityDisplay?.isNotEmpty == true ? departureCityDisplay! : departureAddress;

  String get displayArrival =>
      arrivalCityDisplay?.isNotEmpty == true ? arrivalCityDisplay! : arrivalAddress;

  bool canStartDepartureInspection() {
    if (pickupDatetime == null) return false;
    final now = DateTime.now();
    final oneHourBefore = pickupDatetime!.subtract(const Duration(hours: 1));
    return now.isAfter(oneHourBefore) && departureInspectionId == null;
  }

  bool canStartArrivalInspection() {
    if (deliveryDatetime == null) return false;
    final now = DateTime.now();
    return now.isAfter(deliveryDatetime!) &&
        departureInspectionId != null &&
        arrivalInspectionId == null;
  }
}
