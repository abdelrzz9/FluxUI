import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

class AppSkeleton extends StatefulWidget {
  const AppSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  const AppSkeleton.text({
    super.key,
    this.width,
    this.borderRadius,
  }) : height = 14;

  const AppSkeleton.circular({
    super.key,
    double? size,
    this.borderRadius,
  })  : width = size,
        height = size ?? 44;

  final double? width;
  final double height;
  final double? borderRadius;

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _animation = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final baseColor = colors.surfaceMuted;
    final highlightColor =
        Color.lerp(baseColor, colors.surface, 0.6) ?? baseColor;
    final resolvedRadius = BorderRadius.circular(
      widget.borderRadius ?? context.appRadius.sm,
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: resolvedRadius,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: <Color>[baseColor, highlightColor, baseColor],
              stops: const <double>[0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}
