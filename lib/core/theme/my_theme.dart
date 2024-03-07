import 'package:flutter/material.dart';
import '../constants/color.dart';

final ThemeData theme = ThemeData(
  useMaterial3: false,
  fontFamily: 'PokemonFontFamily',
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryColor,
    elevation: 10,
  ),
  appBarTheme: const AppBarTheme(
    color: AppColors.primaryColor,
    centerTitle: true,
  ),
);
