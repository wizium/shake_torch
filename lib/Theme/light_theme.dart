import 'package:flutter/material.dart';

lightTheme(lightDynamic, context) {
  return ThemeData(
    dialogTheme: DialogTheme(
      titleTextStyle: Theme.of(context).textTheme.headlineSmall!.merge(
            const TextStyle(
              fontFamily: "caveat",
            ),
          ),
      contentTextStyle: Theme.of(context).textTheme.headlineSmall!.merge(
            const TextStyle(
              fontFamily: "caveat",
            ),
          ),
    ),
    colorScheme: lightDynamic,
    useMaterial3: true, 
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: "caveat",
      ),
      labelLarge: TextStyle(
        fontFamily: "caveat",
      ),
      labelMedium: TextStyle(
        fontFamily: "caveat",
      ),
      labelSmall: TextStyle(
        fontFamily: "caveat",
      ),
      bodyMedium: TextStyle(
        fontFamily: "caveat",
      ),
      bodySmall: TextStyle(
        fontFamily: "caveat",
      ),
      titleLarge: TextStyle(
        fontFamily: "caveat",
      ),
      titleMedium: TextStyle(
        fontFamily: "caveat",
      ),
      titleSmall: TextStyle(
        fontFamily: "caveat",
      ),
      headlineMedium: TextStyle(
        fontFamily: "caveat",
      ),
      headlineSmall: TextStyle(
        fontFamily: "caveat",
      ),
      displayLarge: TextStyle(
        fontFamily: "caveat",
      ),
      displayMedium: TextStyle(
        fontFamily: "caveat",
      ),
      displaySmall: TextStyle(
        fontFamily: "caveat",
      ),
      headlineLarge: TextStyle(
        fontFamily: "caveat",
      ),
    ),
  );
}
