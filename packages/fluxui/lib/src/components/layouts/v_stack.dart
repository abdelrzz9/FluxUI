import 'package:flutter/widgets.dart';

import 'gap.dart';

class VStack extends StatelessWidget {
  const VStack({
    super.key,
    required this.children,
    this.spacing = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
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
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: _withGaps(children, spacing),
    );
  }

  List<Widget> _withGaps(List<Widget> children, double spacing) {
    if (children.length < 2 || spacing <= 0) {
      return children;
    }

    return List<Widget>.generate(
      children.length * 2 - 1,
      (index) {
        if (index.isEven) {
          return children[index ~/ 2];
        }

        return Gap.vertical(spacing);
      },
    );
  }
}
