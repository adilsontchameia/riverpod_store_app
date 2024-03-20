import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static initEnvironments() async => await dotenv.load(fileName: '.env');

  static String apiUrl = dotenv.env['API_URL'] ?? 'API URL is not available';
}
