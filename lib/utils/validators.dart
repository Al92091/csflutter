class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email requis';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mot de passe requis';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Téléphone requis';
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) {
      return 'Numéro de téléphone invalide (10 chiffres)';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName requis';
    }
    return null;
  }

  static String? validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName requis';
    }
    if (int.tryParse(value) == null) {
      return '$fieldName doit être un nombre';
    }
    return null;
  }

  static String? validateDecimal(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName requis';
    }
    if (double.tryParse(value) == null) {
      return '$fieldName doit être un nombre';
    }
    return null;
  }
}
