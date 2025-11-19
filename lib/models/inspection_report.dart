class InspectionReport {
  final String missionId;
  final String driverId;
  final String inspectionType;

  // Driver & Contact
  final String? driverPhoto; // base64
  final String? contactFirstName;
  final String? contactLastName;
  final String? contactPhone;

  // Vehicle Info
  final int? mileage;
  final int? fuelLevel;
  final String? dashboardPhoto; // base64

  // Photos (déjà transformées en Map)
  // Chaque élément pourra maintenant contenir en plus :
  // - damages (json-like Map / List)
  // - optional_type ("degats" / "elements_additionnels" ou null)
  final List<dynamic> photos;

  // Signatures
  final String? driverSignature; // base64
  final String? contactSignature; // base64

  // Photo état des lieux (nouvelle colonne dans inspection_reports)
  // Image globale de l'état du véhicule / mission
  final String? etatDesLieuxPhoto; // base64

  // Location
  final double? latitude;
  final double? longitude;

  // Expenses
  final double? fuelExpense;
  final String? fuelExpensePhoto; // base64
  final double? tollExpense;
  final String? tollExpensePhoto; // base64

  InspectionReport({
    required this.missionId,
    required this.driverId,
    required this.inspectionType,
    this.driverPhoto,
    this.contactFirstName,
    this.contactLastName,
    this.contactPhone,
    this.mileage,
    this.fuelLevel,
    this.dashboardPhoto,
    required this.photos,
    this.driverSignature,
    this.contactSignature,
    this.etatDesLieuxPhoto,
    this.latitude,
    this.longitude,
    this.fuelExpense,
    this.fuelExpensePhoto,
    this.tollExpense,
    this.tollExpensePhoto,
  });

  Map<String, dynamic> toJson() {
    return {
      'mission_id': missionId,
      'driver_id': driverId,
      'inspection_type': inspectionType,
      'contact_first_name': contactFirstName,
      'contact_last_name': contactLastName,
      'contact_phone': contactPhone,
      'vehicle_mileage': mileage,
      'vehicle_fuel_level': fuelLevel,
      'driver_photo': driverPhoto,
      'dashboard_photo': dashboardPhoto,
      'driver_signature': driverSignature,
      'contact_signature': contactSignature,
      'etat_des_lieux_photo': etatDesLieuxPhoto,
      'photos': photos,
      'latitude': latitude,
      'longitude': longitude,
      'fuel_expense_amount': fuelExpense,
      'fuel_expense_photo': fuelExpensePhoto,
      'toll_expense_amount': tollExpense,
      'toll_expense_photo': tollExpensePhoto,
    };
  }
}
