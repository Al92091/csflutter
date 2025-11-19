import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<bool> _ensureServiceEnabled() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      await Geolocator.openLocationSettings();
      return await Geolocator.isLocationServiceEnabled();
    }
    return true;
  }

  static Future<bool> _ensurePermission() async {
    var status = await Permission.location.status;

    if (status.isGranted) return true;

    if (status.isDenied || status.isRestricted || status.isLimited) {
      // Demande à l’OS d’afficher la popup d’autorisation
      status = await Permission.location.request();
      if (status.isGranted) return true;
    }

    if (status.isPermanentlyDenied) {
      // Si l’utilisateur a coché "Ne plus demander"
      await openAppSettings();
    }
    return false;
  }

  static Future<bool> ensureServiceAndPermission() async {
    if (!await _ensureServiceEnabled()) return false;
    return await _ensurePermission();
  }

  static Future<Position> getCurrentPosition() async {
    final ok = await ensureServiceAndPermission();
    if (!ok) {
      throw const LocationServiceDisabledException();
    }
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
