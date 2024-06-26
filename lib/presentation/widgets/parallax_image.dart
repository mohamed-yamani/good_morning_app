import 'package:flutter/material.dart';
import 'package:good_morning_app1/parallax_flow_delegate.dart';

class ParallaxImage extends StatelessWidget {
  final String imagePath;
  ParallaxImage({super.key, required this.imagePath});

  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Flow(
          delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context),
            listItemContext: context,
            backgroundImageKey: _backgroundImageKey,
          ),
          clipBehavior: Clip.antiAlias,
          children: [
            Hero(
              tag: imagePath,
              child: Image.network(
                imagePath,
                key: _backgroundImageKey,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('Error loading image'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
