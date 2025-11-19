class DriverAlert {
  final String id;
  final String driverId;
  final String? departureCity;
  final int? departureRadius;
  final String? arrivalCity;
  final int? arrivalRadius;
  final bool includeReturnTrip;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  DriverAlert({
    required this.id,
    required this.driverId,
    this.departureCity,
    this.departureRadius,
    this.arrivalCity,
    this.arrivalRadius,
    required this.includeReturnTrip,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverAlert.fromJson(Map<String, dynamic> json) {
    return DriverAlert(
      id: json['id'],
      driverId: json['driver_id'],
      departureCity: json['departure_city'],
      departureRadius: json['departure_radius'],
      arrivalCity: json['arrival_city'],
      arrivalRadius: json['arrival_radius'],
      includeReturnTrip: json['include_return_trip'] ?? false,
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_id': driverId,
      'departure_city': departureCity,
      'departure_radius': departureRadius,
      'arrival_city': arrivalCity,
      'arrival_radius': arrivalRadius,
      'include_return_trip': includeReturnTrip,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

