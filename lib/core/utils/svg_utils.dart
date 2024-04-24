import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget loadSvgIcon(
  String iconName, {
  double? width,
  double? height,
  Color? color,
}) =>
    SvgPicture.asset(
      'assets/icons/svg/$iconName.svg',
      height: height,
      width: width,
      // ignore: deprecated_member_use
      color: color,
    );

Widget loadSvgImage(
  String iconName, {
  double? width,
  double? height,
  Color? color,
  BoxFit? fit,
}) =>
    SvgPicture.asset(
      'assets/images/svg/$iconName.svg',
      height: height,
      width: width,
      // ignore: deprecated_member_use
      color: color,
    );
