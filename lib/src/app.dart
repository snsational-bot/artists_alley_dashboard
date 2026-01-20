import 'dart:developer';

import 'package:artists_alley_dashboard/src/utils/watchers/watchers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/constants/constants.dart';
import 'presentation/presentation.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Future<void> getLang() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the widget is still mounted after the async operation
    if (!mounted) {
      log('Context not mounted');
      return;
    }

    final localizedApp = LocalizedApp.of(context) as LocalizedApp?;

    if (localizedApp == null) {
      log('LocalizedApp not found in context');
      return;
    }

    final lang = prefs.getString(LocalStorageKeys.lang);

    if (lang != null) {
      // Change locale first
      await localizedApp.delegate.changeLocale(localeFromString(lang));
      log(name: 'App getLang()', ' Language found, set to $lang!');
    } else {
      await prefs.setString(LocalStorageKeys.lang, 'en_US');
      log(name: 'App getLang()', ' Language not found, set to en_US!');
    }
    log(
      name: 'App getLang()',
      ' Current Locale: ${localizedApp.delegate.currentLocale}',
    );
  }

  @override
  void initState() {
    getLang();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return GetMaterialApp.router(
      builder: (context, child) {
        return Obx(() {
          final isInMaintenance = MaintenanceWatcher.to.isInMaintenance;

          if (isInMaintenance) {
            return MaintenanceView();
          }

          return LocalizationProvider(
            state: LocalizationProvider.of(context).state,
            child: child!,
          );
        });
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        localizationDelegate,
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      themeMode: ThemeMode.dark,
      locale: const Locale('en_US'),
      title: "Artists Alley Dashboard",
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialBinding: CustomBindings(),
      fallbackLocale: const Locale('pt_pt'),
      getPages: Pages.pages,
      theme: ThemeData(
        bottomAppBarTheme: const BottomAppBarThemeData(
          surfaceTintColor: Colors.transparent,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: CustomColors.primary.withValues(alpha: 0.2),
          cursorColor: CustomColors.primary.withValues(alpha: 0.8),
          selectionHandleColor: CustomColors.primary.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
