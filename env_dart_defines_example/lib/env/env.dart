import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static final API_KEY = dotenv.env['API_KEY'];
  static final STRIPE_KEY = dotenv.env['STRIPE_KEY'];
}
