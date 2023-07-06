//TODO(MAX): FIX
// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:streamed_carousel/ballistic_settings.dart';

/// A scroll physics that always lands on specific points.
class MagnetToExtendedCenterScrollPhysics extends ScrollPhysics {
  /// Creates a new magnet scroll physics instance.

  /// ballistic parameters for scroll animation
  final BallisticSettings ballistic;

  final double itemSize;
  final int childCount;

  const MagnetToExtendedCenterScrollPhysics({
    super.parent,
    required this.ballistic,
    required this.itemSize,
    required this.childCount,
  });

  @override
  MagnetToExtendedCenterScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return MagnetToExtendedCenterScrollPhysics(
        parent: buildParent(ancestor), ballistic: ballistic, itemSize: itemSize, childCount: childCount);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final resultVelocity = velocity * ballistic.velocityFactor;

    /// If we're out of range and not headed back in range, defer to the parent
    /// ballistics, which should put us back in range at the scrollable boundary.
    if ((resultVelocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (resultVelocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, resultVelocity);
    }

    /// Create a test simulation to see where it would have ballistic-ally fallen
    /// naturally without settling onto items.
    final testFrictionSimulation = super.createBallisticSimulation(position, resultVelocity);

    final offset = testFrictionSimulation?.x(double.infinity) ?? position.pixels;
    final simulatePosition = _clipOffsetToScrollableRange(offset, position.minScrollExtent, position.maxScrollExtent);
    final index = _getSettlingIndex(simulatePosition);
    final settlingPixels = index * itemSize;

    /// If there's no velocity and we're already at where we intend to land, do nothing.
    final controlDistance = settlingPixels - position.pixels;
    if (resultVelocity.abs() < tolerance.velocity && controlDistance.abs() < tolerance.distance) {
      return null;
    }

    /// Create a new friction simulation except the drag will be tweaked to land
    /// exactly on the item closest to the natural stopping point.
    return SpringSimulation(
      SpringDescription(mass: ballistic.mass, damping: ballistic.damping, stiffness: ballistic.stiffness),
      simulatePosition,
      settlingPixels,
      resultVelocity,
      tolerance: tolerance,
    );
  }

  int _getSettlingIndex(double pos) {
    if (pos <= tolerance.distance) {
      return 0;
    }
    if (pos >= childCount * itemSize - tolerance.distance) {
      return childCount - 1;
    }
    return (pos + itemSize / 2) ~/ itemSize;
  }

  /// Clips the specified offset to the scrollable range.
  double _clipOffsetToScrollableRange(double offset, double minScrollExtent, double maxScrollExtent) {
    return min(max(offset, minScrollExtent), maxScrollExtent);
  }
}
