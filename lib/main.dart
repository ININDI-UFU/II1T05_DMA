import 'package:flutter/material.dart';
import 'screens/presentation_screen.dart';

void main() => runApp(const SlidesApp());

class SlidesApp extends StatelessWidget {
  const SlidesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMA na ESP32-S3',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF58A6FF),
          secondary: Color(0xFF3FB950),
          surface: Color(0xFF161B22),
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/1',
      onGenerateRoute: (settings) {
        final name = settings.name ?? '/1';
        final seg = Uri.parse(name).pathSegments;
        int slide = 0;
        if (seg.isNotEmpty) {
          slide = (int.tryParse(seg.first) ?? 1).clamp(1, kTotalSlides) - 1;
        }
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PresentationScreen(initialSlide: slide),
          transitionDuration: Duration.zero,
        );
      },
    );
  }
}
