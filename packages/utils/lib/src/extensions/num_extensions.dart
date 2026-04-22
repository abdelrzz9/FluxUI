import 'package:flutter/widgets.dart';

extension AppNumExtensions on num {
  double get dp => toDouble();

  EdgeInsets get inset => EdgeInsets.all(toDouble());

  SizedBox get hGap => SizedBox(width: toDouble());

  SizedBox get vGap => SizedBox(height: toDouble());

  BorderRadius get radius => BorderRadius.circular(toDouble());

  Duration get ms => Duration(milliseconds: round());
}
