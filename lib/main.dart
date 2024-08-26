import 'package:cred_amanat/app_constants.dart';
import 'package:cred_amanat/global.dart';
import 'package:cred_amanat/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await Global.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CRED Assignment',
        theme: AppTheme.appThemeData(),
        home: const LoanUI(),
      ),
    );
  }
}
