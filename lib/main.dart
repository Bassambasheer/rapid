import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rapidd_technologies/Utils/navigation_bar.dart';
import 'package:rapidd_technologies/Utils/utils.dart';
import 'package:rapidd_technologies/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool? isLogged = false;
  isLogged = await Utils.getBooleanValue('isLoggedIn');

  runApp(ProviderScope(
      child: MyApp(
    isLogged: isLogged,
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.isLogged, super.key});
  final bool isLogged;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rapidd',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: isLogged ? const CustomNavigationBar() : RegisterScreen(),
    );
  }
}
