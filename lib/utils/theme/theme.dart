import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme
{
  CustomTheme._(); // Will not allow instance of this class
  static var mainPalletBlack = const Color.fromRGBO(12, 19, 26, 1);
  static var mainPalletDarkBlue =const Color.fromRGBO(16, 25, 35, 1);
  static var mainPalletBlue =const Color.fromRGBO(27, 42, 57, 1);
  static var mainPalletDarkRed =const Color.fromRGBO(166, 15, 48, 1);
  static var mainPalletRed =const Color.fromRGBO(227, 45, 86, 1);
  static var mainPalletOffWhite =const Color.fromRGBO(226, 209, 209, 1);
  static var mainPalletWhite =const Color.fromRGBO(255, 255, 255, 1);

  // Light Mode Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    );
  
  
  // Dark Mode Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    
    navigationBarTheme: NavigationBarThemeData(backgroundColor: mainPalletDarkBlue),
    
    iconTheme: IconThemeData(color:mainPalletRed ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: mainPalletRed,
    ),
    scaffoldBackgroundColor: mainPalletDarkBlue,

    cardTheme: CardTheme(
      surfaceTintColor: CustomTheme.mainPalletBlack,
      color: CustomTheme.mainPalletBlack,
    ),

    textTheme: TextTheme(
    
      // displayLarge: 
      displayMedium: GoogleFonts.raleway(
        color: mainPalletWhite,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        
      ),
      // displaySmall:
      headlineLarge: GoogleFonts.cantarell(
        color: mainPalletOffWhite,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: GoogleFonts.cantarell(
        color: mainPalletRed,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),

      // headlineSmall:
      titleLarge: GoogleFonts.raleway(
        color: mainPalletRed,
        fontSize: 15,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
      
      // Dates and Stars
      titleMedium: GoogleFonts.raleway(
        color: mainPalletWhite,
        fontSize: 14,
        fontWeight: FontWeight.w900,
      ),

      // titleSmall;

      // for form place holder Text
      labelLarge: GoogleFonts.cantarell(
                                      textStyle: TextStyle(
                                        color: CustomTheme.mainPalletOffWhite,
                                        fontSize: 16.0,
                                        )),
      labelMedium: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: CustomTheme.mainPalletOffWhite,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,

                      )),
      
      labelSmall:GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: CustomTheme.mainPalletWhite,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,

                      )),

      bodyLarge:GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: CustomTheme.mainPalletRed,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,

                      )),
      bodyMedium: GoogleFonts.cantarell(
                    textStyle: TextStyle(
                      color: CustomTheme.mainPalletOffWhite,
                      fontSize: 16.0,
                      )),
      
      // for subscript test
      bodySmall: GoogleFonts.cantarell(
                    textStyle: TextStyle(
                      color: CustomTheme.mainPalletOffWhite,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600
                      )),
    )

  );
}