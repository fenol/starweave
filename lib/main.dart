import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('uk'),
        // Locale('en'), ← розкоментуєш коли будеш готова додати англійську
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('uk'),
      child: const StarweaveApp(),
    ),
  );
}

class StarweaveApp extends StatelessWidget {
  const StarweaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starweave',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // На вебі обгортаємо все в мобільну оболонку (430px, по центру)
      builder: kIsWeb
          ? (context, child) => _MobileWebShell(child: child!)
          : null,
      home: const SplashScreen(),
    );
  }
}

/// Веб-оболонка: центрує додаток у мобільному форматі (max 430px).
/// На телефоні у браузері — контент займає весь екран (< 430px).
/// На десктопі — «телефон» по центру темного фону.
class _MobileWebShell extends StatelessWidget {
  final Widget child;
  const _MobileWebShell({required this.child});

  // Найбільш поширені Android / iOS розміри (portrait):
  //   iPhone SE:      375 × 667
  //   iPhone 14:      390 × 844
  //   iPhone 14 Plus: 428 × 926
  //   Pixel 7:        412 × 915
  //   Samsung S23:    360 × 780
  // → обираємо 430px як верхню межу ширини (покриває 98% реальних телефонів)
  static const double _maxWidth = 430;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Темний фон за межами «телефону» на десктопі
      backgroundColor: const Color(0xFF04060F),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxWidth),
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}
