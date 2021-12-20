import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentalku/commons/colors.dart';

class AppStyle {
  AppStyle._();

  static TextStyle display1Text = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(30),
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.25,
  );

  static TextStyle heading1Text = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(24),
    fontWeight: FontWeight.w700,
    color: Colors.black,
    height: 1.25,
  );

  static TextStyle heading2Text = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(22),
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1,
  );

  static TextStyle title1Text = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(20),
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.1,
  );

  static TextStyle title2Text = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(18),
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.1,
  );

  static TextStyle title3Text = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(16),
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.1,
  );

  static TextStyle labelText = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(12),
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static TextStyle regular1Text = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(14),
    color: Colors.black,
  );

  static TextStyle regular2Text = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(12),
    color: Colors.black,
  );

  static TextStyle smallText = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(10),
    color: Colors.black,
  );

  static TextStyle tinyText = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(8),
    color: Colors.black,
  );

  static TextStyle hargaProduk = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(8),
    color: AppColor.yellow,
  );

  static TextStyle nameProduk = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(7),
    color: Colors.black,
  );

  static TextStyle categoryText = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(6),
    color: Colors.grey,
  );

  static TextStyle lainnyaText = GoogleFonts.poppins(
    fontSize: ScreenUtil().setSp(10),
    color: AppColor.green,
  );
}
