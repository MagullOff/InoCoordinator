import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/app_navigator.dart';
import 'package:ino_coordinator/cubit/session_cubit.dart';
import 'auth/auth_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) =>
              SessionCubit(authRepo: context.read<AuthRepository>()),
          child: const AppNavigator(),
        ),
      ),
      theme: _appTheme(),
    );
  }

  ThemeData _appTheme() {
    return ThemeData(
        primaryColor: const Color.fromARGB(255, 104, 159, 56),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: const TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700]),
          headline3: TextStyle(fontSize: 16.0, color: Colors.lightGreen[700]),
        ));
  }
}
