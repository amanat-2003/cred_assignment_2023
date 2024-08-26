import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
