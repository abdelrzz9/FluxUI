import 'package:flutter/foundation.dart';

@immutable
final class AppMotionTokens {
  const AppMotionTokens({
    required this.instant,
    required this.fast,
    required this.moderate,
    required this.slow,
    required this.emphasized,
  });

  static const AppMotionTokens regular = AppMotionTokens(
    instant: Duration(milliseconds: 75),
    fast: Duration(milliseconds: 150),
    moderate: Duration(milliseconds: 250),
    slow: Duration(milliseconds: 400),
    emphasized: Duration(milliseconds: 600),
  );

  final Duration instant;
  final Duration fast;
  final Duration moderate;
  final Duration slow;
  final Duration emphasized;

  AppMotionTokens copyWith({
    Duration? instant,
    Duration? fast,
    Duration? moderate,
    Duration? slow,
    Duration? emphasized,
  }) {
    return AppMotionTokens(
      instant: instant ?? this.instant,
      fast: fast ?? this.fast,
      moderate: moderate ?? this.moderate,
      slow: slow ?? this.slow,
      emphasized: emphasized ?? this.emphasized,
    );
  }

  static AppMotionTokens lerp(AppMotionTokens a, AppMotionTokens b, double t) {
    return AppMotionTokens(
      instant: lerpDuration(a.instant, b.instant, t),
      fast: lerpDuration(a.fast, b.fast, t),
      moderate: lerpDuration(a.moderate, b.moderate, t),
      slow: lerpDuration(a.slow, b.slow, t),
      emphasized: lerpDuration(a.emphasized, b.emphasized, t),
    );
  }

  static Duration lerpDuration(Duration a, Duration b, double t) {
    final microseconds =
        a.inMicroseconds + ((b.inMicroseconds - a.inMicroseconds) * t).round();
    return Duration(microseconds: microseconds);
  }
}
