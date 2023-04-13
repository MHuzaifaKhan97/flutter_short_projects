import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'keys.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY')
  static const apiKEY = _Env.apiKEY;
  @EnviedField(varName: 'STRIPE_KEY', obfuscate: true)
  static final stripeKey = _Env.stripeKey;
  @EnviedField(defaultValue: 'test_')
  static const key3 = _Env.key3;
}
