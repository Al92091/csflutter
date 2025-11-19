class AppConstants {
  // Supabase Configuration
  static const String supabaseUrl = 'https://yksbhynmpcpcvaysatui.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrc2JoeW5tcGNwY3ZheXNhdHVpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxNTE0MjcsImV4cCI6MjA1MTcyNzQyN30.LvEg0ghZ4Yvc6pnoe6wKA3AXO8yomOiGTZq9LmjFUMM';

  // App Info
  static const String appVersion = '0.1 beta';
  static const String appName = 'CarSwiift Driver';

  // API Endpoints
  static const String edgeFunctionUrl = '$supabaseUrl/functions/v1';
  static const String submitInspectionEndpoint = '$edgeFunctionUrl/submit-inspection-report';

  // Driver Status
  static const List<String> activeDriverStatuses = [
    'active_beginner',
    'active_intermediate',
    'active_expert',
    'active_elite',
  ];

  // Mission Status
  static const String statusRechercheDriver = 'recherche_driver';
  static const String statusAcceptee = 'acceptee';
  static const String statusEnCours = 'en_cours';
  static const String statusTerminee = 'terminee';

  // Mission Status Driver
  static const String missionAcceptee = 'mission_acceptee';
  static const String enCoursDriver = 'en_coursdriver';
  static const String termineeDriver = 'termineedriver';
  static const String clotureeDriver = 'clotureedriver';

  // Inspection Types
  static const String inspectionDeparture = 'departure';
  static const String inspectionArrival = 'arrival';

  // Photo Requirements
  static const int maxPhotoSizeMB = 5;
  static const int maxTotalSizeMB = 50;
  static const int imageQuality = 85;
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1080;

  // Timing
  static const int edlAvailableHoursBeforePickup = 1;
}

