import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Color Theme
const Color primaryColor = Color(0xFF007FFE);
const Color blackColor = Color(0xFF212121);
const Color secondaryColor = Color(0xFFFF8C7B);

/// Text Theme
TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.merriweather(
      fontSize: 91,
      fontWeight: FontWeight.w300,
      color: blackColor,
      letterSpacing: -1.5),
  displayMedium: GoogleFonts.merriweather(
      fontSize: 57,
      fontWeight: FontWeight.w300,
      color: blackColor,
      letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.merriweather(fontSize: 45, fontWeight: FontWeight.w400),
  headlineLarge: GoogleFonts.merriweather(
    fontSize: 40,
    fontWeight: FontWeight.w400,
    color: blackColor,
    letterSpacing: 0.25,
  ),
  headlineMedium: GoogleFonts.merriweather(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: blackColor,
    letterSpacing: 0.25,
  ),
  headlineSmall:
      GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.merriweather(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      color: blackColor,
      letterSpacing: 0.15),
  titleMedium: GoogleFonts.merriweather(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: blackColor,
      letterSpacing: 0.15),
  titleSmall: GoogleFonts.merriweather(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: blackColor,
      letterSpacing: 0.1),
  bodyLarge: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: blackColor,
      letterSpacing: 0.5),
  bodyMedium: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: blackColor,
      letterSpacing: 0.25),
  labelLarge: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: blackColor,
      letterSpacing: 1.25),
  bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: blackColor,
      letterSpacing: 0.4),
  labelSmall: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: blackColor,
      letterSpacing: 1.5),
);
