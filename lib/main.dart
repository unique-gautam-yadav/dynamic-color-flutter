import 'package:flutter/material.dart';
import 'package:node_crud/src/app_provider.dart';
import 'package:node_crud/src/backend/api.dart';
import 'package:node_crud/src/views/product_list.dart';
import 'package:provider/provider.dart';

import 'src/views/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool toHome = await CallApi().verifyToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        )
      ],
      child: MainApp(toHome: toHome),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.toHome});

  final bool toHome;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: widget.toHome
          ? const HomePage()
          : LoginScreen(
              onThemeChanged: () {
                setState(() {
                  isDark = !isDark;
                });
              },
            ),
    );
  }
}
