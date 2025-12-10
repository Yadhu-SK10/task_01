import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_api_app/providers/user_provider.dart';
import 'package:user_api_app/screens/user_fetch_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // 1. Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Window Manager
  await windowManager.ensureInitialized();

  // 3. Define Window Constraints
  // Default launch size
  const Size windowSize = Size(1024, 768);
  // Minimum allowed size (prevents shrinking too much)
  const Size minWindowSize = Size(800, 600);
  // Maximum allowed size (prevents stretching too much)
  const Size maxWindowSize = Size(1280, 800);

  WindowOptions windowOptions = const WindowOptions(
    size: windowSize,
    minimumSize: minWindowSize,
    maximumSize: maxWindowSize, // <--- Added this line to limit stretch
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: 'User API App',
  );

  // 4. Apply options
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'User API App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const UserFetchScreen(),
      ),
    );
  }
}