import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class Formatters {
  static String formatDate(DateTime? date) {
    if (date == null) return '-';
    final paris = tz.getLocation('Europe/Paris');
    final localParis = tz.TZDateTime.from(date.toUtc(), paris);
    return DateFormat('dd/MM/yyyy').format(localParis);
  }

  static String formatDateTime(DateTime? date) {
    if (date == null) return '-';
    final paris = tz.getLocation('Europe/Paris');
    final localParis = tz.TZDateTime.from(date.toUtc(), paris);
    return DateFormat('dd/MM/yyyy HH:mm').format(localParis);
  }

  static String formatShortDateTime(DateTime? date) {
    if (date == null) return '-';
    final paris = tz.getLocation('Europe/Paris');
    final localParis = tz.TZDateTime.from(date.toUtc(), paris);
    return DateFormat('dd/MM HH:mm').format(localParis);
  }

  static String formatTime(DateTime? date) {
    if (date == null) return '-';
    final paris = tz.getLocation('Europe/Paris');
    final localParis = tz.TZDateTime.from(date.toUtc(), paris);
    return DateFormat('HH:mm').format(localParis);
  }

  static String formatDay(DateTime? date) {
    if (date == null) return '-';
    final paris = tz.getLocation('Europe/Paris');
    final localParis = tz.TZDateTime.from(date.toUtc(), paris);
    return DateFormat('dd/MM').format(localParis);
  }

  static String formatTravelTime(int? minutes) {
    if (minutes == null) return '-';
    if (minutes < 60) {
      return '$minutes min';
    } else {
      final h = minutes ~/ 60;
      final m = minutes % 60;
      return m == 0 ? '${h}h' : '${h}h${m.toString().padLeft(2, '0')}';
    }
  }

  static String formatPrice(double? price) {
    if (price == null) return '-';
    return '${price.toStringAsFixed(2)} €';
  }

  static String formatDistance(double? km) {
    if (km == null) return '-';
    return '${km.toStringAsFixed(1)} km';
  }

  /// ✅ Distance entière (sans décimales)
  static String formatDistanceInt(double? km) {
    if (km == null) return '-';
    return '${km.round()} km';
  }

  static String formatPhone(String? phone) {
    if (phone == null || phone.isEmpty) return '-';
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length != 10) return phone;
    return '${cleaned.substring(0, 2)} ${cleaned.substring(2, 4)} ${cleaned.substring(4, 6)} ${cleaned.substring(6, 8)} ${cleaned.substring(8)}';
  }

  static String truncateAddress(String address, {int maxLength = 40}) {
    if (address.length <= maxLength) return address;
    return '${address.substring(0, maxLength)}...';
  }
}
