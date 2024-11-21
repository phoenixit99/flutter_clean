import 'package:flutter/material.dart';
import 'presentation/screen/login_screen.dart';
import 'router/router_utils.dart';
import 'themes/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: AppTheme.appTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: RouteUtils.getRoute(AppRoute.login),
      routes: {
        RouteUtils.getRoute(AppRoute.login): (context) =>
            LoginScreen(),

      },
    );
  } 
}