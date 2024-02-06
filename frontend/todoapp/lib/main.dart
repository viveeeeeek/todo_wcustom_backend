import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/screens/home.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoapp/providers/todo.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoProvider())],
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            darkTheme: ThemeData(useMaterial3: true, colorScheme: darkDynamic),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
