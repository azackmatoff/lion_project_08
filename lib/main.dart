import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lion_project_08/presentation/flutter_bloc/bloc/bloc/home_screen_bloc.dart';
import 'package:lion_project_08/presentation/flutter_bloc/bloc/ui/screens/bloc_home_screen.dart';
import 'package:lion_project_08/presentation/flutter_bloc/cubit/cubit/home_screen_cubit.dart';
import 'package:lion_project_08/presentation/flutter_bloc/cubit/ui/screens/cubit_home_screen.dart';
import 'package:lion_project_08/presentation/flutter_way/ui/screens/home_screen.dart';
import 'package:lion_project_08/presentation/getx/ui/screens/getx_home_screen.dart';

void main() {
  runBlocApp();
}

void runFlutterApp() {
  runApp(const MyApp());
}

void runGetxApp() {
  runApp(const GetxMyApp());
}

void runCubitApp() {
  runApp(const CubitMyApp());
}

void runBlocApp() {
  runApp(const BlocMyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class GetxMyApp extends StatelessWidget {
  const GetxMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GetxHomeScreen(),
    );
  }
}

class CubitMyApp extends StatelessWidget {
  const CubitMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => HomeScreenCubit(),
        child: const CubitHomeScreen(),
      ),
    );
  }
}

class BlocMyApp extends StatelessWidget {
  const BlocMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => HomeScreenBloc(),
        child: const BlocHomeScreen(),
      ),
    );
  }
}
