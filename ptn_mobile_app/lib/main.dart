import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ptn_mobile_app/pages/tutorialPage.dart';
import '../viewmodel/song_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Telefon için sadece dikey, tablet için hem dikey hem yatay yönlendirme ayarı
  if (isTablet()) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => SongViewModel(),
      child: const MyApp(),
    ),
  );
}

// Cihazın tablet olup olmadığını kontrol eden fonksiyon
bool isTablet() {
  final data = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
  final shortestSide = data.shortestSide / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
  return shortestSide >= 600; // 600dp ve üzeri genişlik tablet olarak kabul edilir
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TutorialPage(),
    );
  }
}
