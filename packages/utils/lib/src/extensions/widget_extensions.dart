import 'package:flutter/material.dart';

extension AppWidgetSpacingExtensions on Widget {
  Widget padding(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget paddingInsets(EdgeInsetsGeometry insets) {
    return Padding(
      padding: insets,
      child: this,
    );
  }

  Widget paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Widget margin(double value) {
    return Container(
      margin: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget marginSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  Widget marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }
}

extension AppWidgetLayoutExtensions on Widget {
  Widget center({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Center(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  Widget align(AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget flexible({
    int flex = 1,
    FlexFit fit = FlexFit.loose,
  }) {
    return Flexible(
      flex: flex,
      fit: fit,
      child: this,
    );
  }

  Widget sized({
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  Widget constrained({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: this,
    );
  }
}

extension AppWidgetDecorationExtensions on Widget {
  Widget rounded(
    double radius, {
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return _decorate(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: clipBehavior,
    );
  }

  Widget background(
    Color color, {
    double? radius,
    Clip? clipBehavior,
  }) {
    return _decorate(
      color: color,
      borderRadius: radius == null ? null : BorderRadius.circular(radius),
      clipBehavior: clipBehavior,
    );
  }

  Widget border({
    required Color color,
    double width = 1,
    double? radius,
    Clip? clipBehavior,
  }) {
    return _decorate(
      border: Border.all(
        color: color,
        width: width,
      ),
      borderRadius: radius == null ? null : BorderRadius.circular(radius),
      clipBehavior: clipBehavior,
    );
  }

  Widget shadow({
    Color color = const Color(0x1A000000),
    double blurRadius = 16,
    Offset offset = const Offset(0, 8),
    double spreadRadius = 0,
  }) {
    return _decorate(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color,
          blurRadius: blurRadius,
          offset: offset,
          spreadRadius: spreadRadius,
        ),
      ],
    );
  }

  Widget decorated({
    Color? color,
    Gradient? gradient,
    Border? border,
    List<BoxShadow>? boxShadow,
    BorderRadiusGeometry? borderRadius,
    Clip? clipBehavior,
  }) {
    return _decorate(
      color: color,
      gradient: gradient,
      border: border,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
    );
  }

  Widget _decorate({
    Color? color,
    Gradient? gradient,
    Border? border,
    List<BoxShadow>? boxShadow,
    BorderRadiusGeometry? borderRadius,
    Clip? clipBehavior,
  }) {
    final current =
        this is _AppDecorationBox ? this as _AppDecorationBox : null;

    return _AppDecorationBox(
      child: current?.child ?? this,
      color: color ?? current?.color,
      gradient: gradient ?? current?.gradient,
      border: border ?? current?.border,
      boxShadow: boxShadow ?? current?.boxShadow,
      borderRadius: borderRadius ?? current?.borderRadius,
      clipBehavior: clipBehavior ?? current?.clipBehavior ?? Clip.none,
    );
  }
}

class _AppDecorationBox extends StatelessWidget {
  const _AppDecorationBox({
    required this.child,
    this.color,
    this.gradient,
    this.border,
    this.boxShadow,
    this.borderRadius,
    this.clipBehavior = Clip.none,
  });

  final Widget child;
  final Color? color;
  final Gradient? gradient;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry? borderRadius;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final clippedChild = borderRadius != null && clipBehavior != Clip.none
        ? ClipRRect(
            borderRadius: borderRadius!,
            clipBehavior: clipBehavior,
            child: child,
          )
        : child;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        border: border,
        boxShadow: boxShadow,
        borderRadius: borderRadius,
      ),
      child: clippedChild,
    );
  }
}
