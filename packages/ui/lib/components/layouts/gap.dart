import 'package:flutter/widgets.dart';

class Gap extends StatelessWidget {
  const Gap(
    this.size, {
    super.key,
    this.axis = Axis.vertical,
  });

  const Gap.horizontal(
    this.size, {
    super.key,
  }) : axis = Axis.horizontal;

  const Gap.vertical(
    this.size, {
    super.key,
  }) : axis = Axis.vertical;

  final double size;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.horizontal ? size : null,
      height: axis == Axis.vertical ? size : null,
    );
  }
}
