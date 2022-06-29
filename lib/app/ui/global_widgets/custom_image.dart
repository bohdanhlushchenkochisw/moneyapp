import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef NetworkImageBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

enum ImageSource { network, asset }

enum ImageType { regular, svg }

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    required this.imagePath,
    this.builder,
    this.errorBuilder,
    this.fit = BoxFit.cover,
    this.imageSource = ImageSource.asset,
    this.imageType = ImageType.svg,
    this.width,
    this.height,
    this.alignment = AlignmentDirectional.center,
    this.isHandlingError = true,
    this.loadingColor = Colors.blue,
  }) : super(key: key);

  final String imagePath;
  final NetworkImageBuilder? builder;
  final ImageErrorWidgetBuilder? errorBuilder;
  final BoxFit fit;
  final ImageSource imageSource;
  final ImageType imageType;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final bool isHandlingError;
  final Color loadingColor;

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) return _emptyUri(context);
    if (imageType == ImageType.regular) {
      switch (imageSource) {
        case ImageSource.network:
          return Image.network(
            imagePath,
            fit: fit,
            width: width,
            height: height,
            loadingBuilder: _loadingBuilder,
            frameBuilder: _frameBuilder,
            errorBuilder: isHandlingError ? _errorBuilder : null,
          );
        case ImageSource.asset:
          return Image.asset(
            imagePath,
            fit: fit,
            width: width,
            height: height,
            frameBuilder: _frameBuilder,
            errorBuilder: isHandlingError ? _errorBuilder : null,
          );
      }
    } else {
      switch (imageSource) {
        case ImageSource.network:
          return SvgPicture.network(
            imagePath,
            fit: fit,
            width: width,
            height: height,
            placeholderBuilder: (context) => _circularLoaderByValue(0),
          );
        case ImageSource.asset:
          return SvgPicture.asset(
            imagePath,
            fit: fit,
            width: width,
            height: height,
            placeholderBuilder: (context) => _circularLoaderByValue(0),
          );
      }
    }
  }

  Widget _emptyUri(BuildContext context) =>
      errorBuilder?.call(
        context,
        ArgumentError("Empty 'imageUrl' was passed"),
        null,
      ) ??
      _defaultError();

  Widget _loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    final isLoading = (loadingProgress?.expectedTotalBytes ?? 0) != (loadingProgress?.cumulativeBytesLoaded ?? 0);
    final value = (loadingProgress?.cumulativeBytesLoaded ?? 0) / (loadingProgress?.expectedTotalBytes ?? 1);
    return isLoading ? builder?.call(context, _circularLoaderByValue(value)) ?? _circularLoaderByValue(value) : child;
  }

  Container _circularLoaderByValue(double _) {
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(child: CircularProgressIndicator(color: loadingColor)),
      ),
    );
  }

  Container _defaultError() {
    return Container(
      alignment: alignment,
      color: Colors.grey[200],
      height: height,
      width: width,
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          Icons.error_outline,
          size: 34,
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget _frameBuilder(
    BuildContext _,
    Widget child,
    int? frame,
    bool? wasSynchronouslyLoaded,
  ) {
    return (wasSynchronouslyLoaded ?? false)
        ? child
        : AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            child: child,
          );
  }

  Widget _errorBuilder(BuildContext context, Object error, StackTrace? stackTrace) {
    return errorBuilder?.call(context, error, stackTrace) ?? _defaultError();
  }
}
