class DriverProfile {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String userType;
  final String? driverStatus;
  final String? phone;
  final String? address;
  final String? postalCode;
  final String? city;
  final String? profileImageUrl;

  DriverProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
    this.driverStatus,
    this.phone,
    this.address,
    this.postalCode,
    this.city,
    this.profileImageUrl,
  });

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    return DriverProfile(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userType: json['user_type'],
      driverStatus: json['driver_status'],
      phone: json['phone'],
      address: json['address'],
      postalCode: json['postal_code'],
      city: json['city'],
      profileImageUrl: json['profile_image_url'],
    );
  }

  String get fullName => '$firstName $lastName';

  bool get isActiveDriver {
    return driverStatus != null &&
        [
          'active_beginner',
          'active_intermediate',
          'active_expert',
          'active_elite'
        ].contains(driverStatus);
  }
}

