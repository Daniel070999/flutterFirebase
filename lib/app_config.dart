import 'package:practiacflutter/screens/screens.dart';

class AppConfig {
  static String initialRoute = 'login';

  static routes() {
    return {
      'login': ((context) => const LoginScreen()),
      'register': ((context) => const RegisterScreen()),
      'home': ((context) => const HomeScreen()),
      'acerca': ((context) => const AcercaScreen()),
      'mapa': ((context) => const MapaScreen()),
    };
  }
}
