import 'package:flutter/widgets.dart';

import 'gap.dart';

class HStack extends StatelessWidget {
  const HStack({
    super.key,
    required this.children,
    this.spacing = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  });

  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: _withGaps(children, spacing, Axis.horizontal),
    );
  }
}

List<Widget> _withGaps(
  List<Widget> children,
  double spacing,
  Axis axis,
) {
  if (children.length < 2 || spacing <= 0) {
    return children;
  }

  return List<Widget>.generate(
    children.length * 2 - 1,
    (index) {
      if (index.isEven) {
        return children[index ~/ 2];
      }

      return Gap(
        spacing,
        axis: axis,
      );
    },
  );
}
