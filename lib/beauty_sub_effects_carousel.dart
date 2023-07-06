import 'package:flutter/material.dart';
import 'package:streamed_carousel/ballistic_settings.dart';
import 'package:streamed_carousel/carousel_item.dart';
import 'package:streamed_carousel/magnet_to_extended_center_scroll_physics.dart';
import 'package:streamed_carousel/vibration_service.dart';

class BeautySubEffectsCarousel extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int> onTap;
  final int? childCount;
  final NullableIndexedWidgetBuilder builder;

  const BeautySubEffectsCarousel({
    super.key,
    required this.initialIndex,
    required this.onTap,
    required this.childCount,
    required this.builder,
  });

  @override
  State<BeautySubEffectsCarousel> createState() => _BeautySubEffectsCarouselState();
}

class _BeautySubEffectsCarouselState extends State<BeautySubEffectsCarousel> {
  late int currentIndex;
  late bool _isScrolledByCommand = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _scrollController = ScrollController(initialScrollOffset: currentIndex * beautySubEffectItemSize);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return NotificationListener(
      onNotification: (notice) {
        if (notice is ScrollUpdateNotification) {
          final pixels = notice.metrics.pixels;
          print(pixels);
          final posIndex = (pixels + beautySubEffectItemSize / 2) ~/ beautySubEffectItemSize;
          if (currentIndex != posIndex && (widget.childCount == null || posIndex < widget.childCount!)) {
            if (!_isScrolledByCommand) {
              VibrationService.selectionClick();
              widget.onTap(posIndex);
            }
            setState(() => currentIndex = posIndex);
          }
        } else if (notice is ScrollEndNotification) {
          final pixels = notice.metrics.pixels;
          final posIndex = (pixels + beautySubEffectItemSize / 2) ~/ beautySubEffectItemSize;
          setState(() => currentIndex = posIndex);
          widget.onTap(posIndex);
          _isScrolledByCommand = false;
        }
        return true;
      },
      child: SizedBox(
        width: width,
        height: 98,
        child: CustomScrollView(
          physics: MagnetToExtendedCenterScrollPhysics(
            parent: const BouncingScrollPhysics(),
            ballistic: const BallisticSettings(mass: 0.8, damping: 90),
            itemSize: beautySubEffectItemSize,
            childCount: widget.childCount ?? 0,
          ),
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: (width - beautyCurrentSubEffectItemSize) / 2),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        VibrationService.mediumImpact();
                        _isScrolledByCommand = true;
                        _scrollController.animateTo(
                          index * beautySubEffectItemSize,
                          duration: Duration(seconds: 2),
                          curve: Curves.easeIn,
                        );
                      },
                      child: widget.builder(context, index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
