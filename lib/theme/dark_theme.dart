import 'package:flutter/material.dart';

final darkTheme = ThemeData(
        useMaterial3: false,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 238, 198, 113),
        ),

        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),

        dividerColor: const Color.fromARGB(255, 238, 198, 113),

        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          titleTextStyle: TextStyle(
            fontSize: 26,
            color: const Color.fromARGB(255, 238, 198, 113),
            fontWeight: FontWeight.w700
          ),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color.fromARGB(255, 238, 198, 113),
          foregroundColor: const Color.fromARGB(255, 0, 0, 0)
        ),

        listTileTheme: ListTileThemeData(
          iconColor: const Color.fromARGB(255, 238, 198, 113)
          ),

        textTheme: TextTheme(
          bodyMedium: const TextStyle(
            color: Color.fromARGB(255, 255, 249, 131),
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),

          labelSmall: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w400,
            fontSize: 16),
            
          labelMedium: const TextStyle(
            fontSize: 28,
            color: Color.fromARGB(255, 255, 249, 131),
            fontWeight: FontWeight.w600),
        )
      );