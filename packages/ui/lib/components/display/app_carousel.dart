import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../cards/app_card.dart';

class AppCarousel extends StatefulWidget {
  const AppCarousel({
    super.key,
    required this.children,
    this.height = 280,
    this.initialIndex = 0,
    this.onChanged,
    this.showControls = true,
    this.showIndicators = true,
    this.viewportFraction = 1,
  })  : assert(children.length > 0, 'children must not be empty.'),
        assert(
          initialIndex >= 0 && initialIndex < children.length,
          'initialIndex must stay within the child range.',
        ),
        assert(viewportFraction > 0,
            'viewportFraction must be greater than zero.');

  final List<Widget> children;
  final double height;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final bool showControls;
  final bool showIndicators;
  final double viewportFraction;

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: widget.viewportFraction,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return AppCard.outlined(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              itemCount: widget.children.length,
              onPageChanged: _handlePageChanged,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(
                      widget.viewportFraction < 1 ? spacing.xs : 0),
                  child: widget.children[index],
                );
              },
            ),
            if (widget.showControls && widget.children.length > 1) ...[
              Positioned(
                left: spacing.sm,
                top: 0,
                bottom: 0,
                child: _AppCarouselControl(
                  icon: Icons.chevron_left_rounded,
                  semanticLabel: 'Previous slide',
                  enabled: _currentIndex > 0,
                  onTap: _currentIndex > 0
                      ? () => _animateTo(_currentIndex - 1)
                      : null,
                ),
              ),
              Positioned(
                right: spacing.sm,
                top: 0,
                bottom: 0,
                child: _AppCarouselControl(
                  icon: Icons.chevron_right_rounded,
                  semanticLabel: 'Next slide',
                  enabled: _currentIndex < widget.children.length - 1,
                  onTap: _currentIndex < widget.children.length - 1
                      ? () => _animateTo(_currentIndex + 1)
                      : null,
                ),
              ),
            ],
            if (widget.showIndicators && widget.children.length > 1)
              Positioned(
                left: spacing.md,
                right: spacing.md,
                bottom: spacing.sm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List<Widget>.generate(widget.children.length, (index) {
                    final isActive = index == _currentIndex;
                    final colors = context.appColors;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: EdgeInsets.symmetric(horizontal: spacing.xxxs),
                      width: isActive ? spacing.lg : spacing.xs,
                      height: spacing.xs,
                      decoration: BoxDecoration(
                        color: isActive ? colors.primary : colors.surface,
                        borderRadius:
                            BorderRadius.circular(context.appRadius.pill),
                        border: Border.all(
                          color:
                              isActive ? colors.primary : colors.borderStrong,
                          width: spacing.xxxs / 2,
                        ),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _animateTo(int index) {
    return _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  void _handlePageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onChanged?.call(index);
  }
}

class _AppCarouselControl extends StatelessWidget {
  const _AppCarouselControl({
    required this.icon,
    required this.semanticLabel,
    required this.enabled,
    this.onTap,
  });

  final IconData icon;
  final String semanticLabel;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;

    return Center(
      child: Semantics(
        button: true,
        enabled: enabled,
        label: semanticLabel,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            width: context.appSizes.controlSm,
            height: context.appSizes.controlSm,
            decoration: BoxDecoration(
              color: enabled ? colors.surface : colors.surfaceMuted,
              shape: BoxShape.circle,
              border: Border.all(
                color: enabled ? colors.borderStrong : colors.disabled,
                width: spacing.xxxs / 2,
              ),
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: enabled ? onTap : null,
              child: Icon(
                icon,
                size: context.appSizes.iconMd,
                color: enabled ? colors.onSurface : colors.disabledForeground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
