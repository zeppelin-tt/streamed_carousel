import 'package:flutter/material.dart';


const beautySubEffectItemSize = 52.0;
const beautyCurrentSubEffectItemSize = 66.0;

class CarouselItem extends StatelessWidget {
  final bool isCurrent;
  final Widget child;
  final VoidCallback onTap;
  final Color color;

  const CarouselItem({
    super.key,
    required this.color,
    required this.isCurrent,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isCurrent ? beautyCurrentSubEffectItemSize : beautySubEffectItemSize,
      height: beautySubEffectItemSize,
      duration: const Duration(milliseconds: 500),
      color: color,
      child: Center(
        child: SizedBox.square(
          dimension: 40,
          child: child,
        ),
      ),
    );
  }
}
