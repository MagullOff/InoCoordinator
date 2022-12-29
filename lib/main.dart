import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ino_coordinator/auth/auth_repository.dart';
import 'package:ino_coordinator/auth/views/login.dart';
import 'package:ino_coordinator/auth/views/register.dart';

void main() {
  runApp(InoCoordinator());
}

class InoCoordinator extends StatelessWidget {
  const InoCoordinator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RepositoryProvider(
          create: (context) => AuthRepository(),
          child: Login(),
        ),
        theme: ThemeData(
            primaryColor: Colors.lightGreen[700],
            backgroundColor: Colors.grey[200],
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              headline2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
              headline3:
                  TextStyle(fontSize: 16.0, color: Colors.lightGreen[700]),
            )),
        routes: {
          '/login': (context) => RepositoryProvider(
                create: (context) => AuthRepository(),
                child: Login(),
              ),
          '/register': (context) => RepositoryProvider(
                create: (context) => AuthRepository(),
                child: Register(),
              ),
        });
  }
}
