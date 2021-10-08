import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentalku/commons/colors.dart';

class AppStyle {
  static TextStyle heading1Text = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    height: 1.25,
  );

  static TextStyle heading2Text = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1,
  );

  static TextStyle title1Text = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.1,
  );

  static TextStyle title2Text = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.1,
  );

  static TextStyle labelText = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static TextStyle regularText = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.black,
  );
}
