import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String googleApiKey = "${dotenv.env['GOOGLE_API_KEY']}";
}
