import 'package:flutter/material.dart';
import 'package:streamed_carousel/beauty_sub_effects_carousel.dart';
import 'package:streamed_carousel/carousel_item.dart';
import 'package:streamed_carousel/hoop.dart';

class IterableBeautySubEffectsMenu extends StatefulWidget {
  const IterableBeautySubEffectsMenu({
    super.key,
  });

  @override
  State<IterableBeautySubEffectsMenu> createState() => IterableBeautySubEffectsMenuState();
}

class IterableBeautySubEffectsMenuState extends State<IterableBeautySubEffectsMenu> {
  List<String> get availableLashes => List.generate(10, (index) => '$index');

  String? currentLashes = '2';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: beautySubEffectItemSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BeautySubEffectsCarousel(
            key: const Key('lenses'),
            childCount: availableLashes.length + 1,
            onTap: (index) async {
              currentLashes = index == 0 ? null : availableLashes.elementAt(index - 1);
              setState(() {});
            },
            builder: (context, index) {
              if (index == 0) {
                return CarouselItem(
                  color: Colors.transparent,
                  onTap: () => setState(() => currentLashes = null),
                  isCurrent: currentLashes == null,
                  child: Container(color: Colors.yellow),
                );
              }
              return CarouselItem(
                color: index.isEven ? Colors.blue : Colors.red,
                onTap: () => setState(() => currentLashes = availableLashes[index - 1]),
                isCurrent: currentLashes == availableLashes[index - 1],
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      availableLashes[index - 1],
                      style: const TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ),
              );
            },
            initialIndex: currentLashes != null ? availableLashes.indexOf(currentLashes!) + 1 : 1,
          ),
          const _CenteredHoop(),
        ],
      ),
    );
  }
}

class _CenteredHoop extends StatelessWidget {
  const _CenteredHoop();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Hoop(
        color: Colors.yellow,
        thickness: 4,
        blockSide: beautySubEffectItemSize,
        innerRadius: 22,
      ),
    );
  }
}
