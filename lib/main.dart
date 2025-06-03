import 'package:codex_pcs/screens/departure/listPage/service/cubit/departure_cubit.dart';
import 'package:codex_pcs/screens/departure/listPage/service/departureRepository.dart';
import 'package:codex_pcs/screens/login/pages/splash_screen.dart';
import 'package:codex_pcs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) => DepartureCubit(repository: VesselRepositoryImpl())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home:  const SplashScreen(),
    );
  }
}

