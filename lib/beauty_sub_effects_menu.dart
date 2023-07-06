import 'package:flutter/material.dart';
import 'package:streamed_carousel/beauty_sub_effects_carousel.dart';
import 'package:streamed_carousel/carousel_item.dart';
import 'package:streamed_carousel/hoop.dart';

final beautySubEffectsMenuKey = GlobalKey<BeautySubEffectsMenuState>();

class BeautySubEffectsMenu extends StatefulWidget {
  const BeautySubEffectsMenu({
    super.key,
  });

  @override
  State<BeautySubEffectsMenu> createState() => BeautySubEffectsMenuState();
}

class BeautySubEffectsMenuState extends State<BeautySubEffectsMenu> {
  Stream<String> get availableLashes => Stream.fromIterable(List.generate(10, (index) => '$index'));

  String? currentLashes = '2';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: beautySubEffectItemSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder<int>(
            future: availableLashes.length,
            builder: (context, length) {
              if (length.hasData) {
                return BeautySubEffectsCarousel(
                  key: const Key('lenses'),
                  childCount: length.requireData + 1,
                  onTap: (index) async {
                    currentLashes = index == 0 ? null : await availableLashes.elementAt(index - 1);
                    setState(()  {});
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
                    return FutureBuilder<String>(
                      future: availableLashes.elementAt(index- 1),
                      builder: (context, lashes) {
                        if (lashes.hasData) {
                          return CarouselItem(
                            color: index.isEven ? Colors.blue : Colors.red,
                            onTap: () => setState(() => currentLashes = lashes.requireData),
                            isCurrent: currentLashes == lashes.requireData,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  lashes.requireData,
                                  style: const TextStyle(color: Colors.blue, fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.square(dimension: 40);
                      },
                    );
                  },
                  initialIndex: 3, //currentLashes != null ? availableLashes.indexOf(currentLashes) : 1,
                );
              }
              return const SizedBox.shrink();
            },
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
