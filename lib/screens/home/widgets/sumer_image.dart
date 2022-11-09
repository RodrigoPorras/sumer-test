import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sumer_test/extensions/string.dart';

class SumerImage extends StatelessWidget {
  final String _url;
  final double? _width;
  final double? _height;
  final BoxFit? _boxFit;
  final bool? _rounded;
  final Color? _colorBackground;

  const SumerImage({
    required String url,
    double? width,
    double? height,
    BoxFit? boxFit,
    bool? rounded,
    Color? colorBackground,
    Key? key,
  })  : _url = url,
        _width = width,
        _height = height,
        _boxFit = boxFit,
        _rounded = rounded,
        _colorBackground = colorBackground,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_url.isEmpty || !_url.isURL()) {
      return _getRoundedIfNeeded(_getDefaultImage());
    }

    return ExtendedImage.network(
      _url,
      width: _width,
      height: _height,
      fit: _boxFit ?? BoxFit.contain,
      maxBytes: 200000,
      loadStateChanged: (imageState) {
        switch (imageState.extendedImageLoadState) {
          case LoadState.failed:
            return _getDefaultImage();
          case LoadState.loading:
            return _getPlaceholderImage();
          case LoadState.completed:
            return imageState.completedWidget;
          default:
            return _getDefaultImage();
        }
      },
    );
  }

  Widget _getRoundedIfNeeded(Widget content) {
    return _rounded != null && _rounded!
        ? CircleAvatar(
            backgroundColor: _colorBackground ?? Colors.white,
            child: ClipOval(child: content),
          )
        : content;
  }

  Widget _getDefaultImage() => Icon(
        Icons.person_off_outlined,
        size: _height,
      );

  Widget _getPlaceholderImage() =>const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        ),
      );
}
