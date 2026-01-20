import 'package:artists_alley_dashboard/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: const ['en_US', 'pt_pt'],
    basePath: 'i18n',
  );

  runApp(OverlaySupport.global(child: LocalizedApp(delegate, const App())));
}
