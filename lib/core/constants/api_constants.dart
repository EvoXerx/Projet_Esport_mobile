/// Constantes de l'API PandaScore. Le token est injecté au lancement via
/// `--dart-define-from-file` (clé `API_PANDA_SCORE`) et n'est jamais commité.
class ApiConstants {
  static const baseUrl = 'https://api.pandascore.co';
  static const token = String.fromEnvironment('API_PANDA_SCORE');
}
