import 'package:carswift_driver/models/mission.dart';

class MissionRequirements {
  final bool requiresWGarage;
  final bool requiresClientHandover;
  final bool requiresLavage;
  final bool requiresElectricVehicle;
  final bool requiresDocumentManagement;

  const MissionRequirements({
    required this.requiresWGarage,
    required this.requiresClientHandover,
    required this.requiresLavage,
    required this.requiresElectricVehicle,
    required this.requiresDocumentManagement,
  });
}

class MissionRestriction {
  final bool isRestricted;
  final bool isWGarageRestricted;
  final bool isCertificationRestricted;
  final List<String> missingCertifications;

  const MissionRestriction({
    required this.isRestricted,
    required this.isWGarageRestricted,
    required this.isCertificationRestricted,
    required this.missingCertifications,
  });

  static const MissionRestriction none = MissionRestriction(
    isRestricted: false,
    isWGarageRestricted: false,
    isCertificationRestricted: false,
    missingCertifications: const [],
  );
}

class MissionRestrictionChecker {
  /// Analyse les options d’une mission pour déterminer ce qu’elle exige
  static MissionRequirements getRequirements(Mission mission) {
    final requiresClientHandover =
        (mission.basicHandover == true) || (mission.comfortHandover == true);

    final requiresLavage = (mission.basicWashing == true) ||
        (mission.standardWashing == true) ||
        (mission.premiumWashing == true);

    final requiresElectricVehicle = mission.electricVehicle == true;
    final requiresDocumentManagement = mission.documentManagement == true;
    final requiresWGarage = mission.wGarage == true;

    return MissionRequirements(
      requiresWGarage: requiresWGarage,
      requiresClientHandover: requiresClientHandover,
      requiresLavage: requiresLavage,
      requiresElectricVehicle: requiresElectricVehicle,
      requiresDocumentManagement: requiresDocumentManagement,
    );
  }

  /// Vérifie ce qui manque au driver pour cette mission
  ///
  /// [certMap] map des certifs validées, ex:
  /// {
  ///   'client_handover': true/false,
  ///   'LAVAGE': true/false,
  ///   'electric_vehicle': true/false,
  ///   'document_management': true/false,
  /// }
  static MissionRestriction check(
    Mission mission,
    Map<String, bool> certMap,
    bool hasWGarage,
  ) {
    final req = getRequirements(mission);
    final missing = <String>[];

    final wGarageRestricted = req.requiresWGarage && !hasWGarage;

    if (req.requiresClientHandover &&
        (certMap['client_handover'] != true)) {
      missing.add('Mise en main à un client');
    }

    if (req.requiresLavage && (certMap['LAVAGE'] != true)) {
      missing.add('Lavage');
    }

    if (req.requiresElectricVehicle &&
        (certMap['electric_vehicle'] != true)) {
      missing.add('Véhicule électrique');
    }

    if (req.requiresDocumentManagement &&
        (certMap['document_management'] != true)) {
      missing.add('Gestion documentaire');
    }

    final certRestricted = missing.isNotEmpty;
    final isRestricted = wGarageRestricted || certRestricted;

    if (!isRestricted) {
      return MissionRestriction.none;
    }

    return MissionRestriction(
      isRestricted: isRestricted,
      isWGarageRestricted: wGarageRestricted,
      isCertificationRestricted: certRestricted,
      missingCertifications: missing,
    );
  }
}
