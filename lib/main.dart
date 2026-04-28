import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hw_42',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('hw_42 — Release prep')),
      body: const Center(
        child: Text('App ready for release. Follow README to generate keystore and build.'),
      ),
    );
  }
}

/// Release v1.0.0 — кратко (1 страница)
///
/// Сборка:
/// - Формат: Android App Bundle (.aab), подписанный локальным keystore.
/// - Версия: 1.0.0+1 (pubspec.yaml)
///
/// Шаги релиза:
/// 1. Скопировать android/key.properties.template → android/key.properties и заполнить реальные пароли локально.
/// 2. Сгенерировать keystore локально:
///    keytool -genkey -v -keystore android/app/release-keystore.jks -alias release_key -keyalg RSA -keysize 2048 -validity 10000
/// 3. Запустить:
///    flutter pub get
///    flutter pub run flutter_launcher_icons:main
///    flutter pub run flutter_native_splash:create
/// 4. Собрать:
///    flutter build appbundle --release
/// 5. Google Play Console → Internal testing → Create release → загрузить .aab → назначить тестеров.
///
/// Риски:
/// - Неправильный keystore/пароли — загрузка в Play заблокирована.
/// - Критические краши на релизе — пользователи не смогут пользоваться.
/// - Отказ пользователя в permissions (камера/фото/уведомления) — ухудшение UX.
/// - Неправильные privacy-тексты на iOS — возможны жалобы.
///
/// План отката:
/// 1. Остановить распространение релиза в Play Console/internal.
/// 2. Откатиться на последний стабильный tag/commit.
/// 3. Исправить баг, увеличить build number (+1).
/// 4. Собрать и загрузить hotfix в internal → проверить → staged → production.
