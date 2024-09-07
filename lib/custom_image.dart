import 'dart:io';
import 'package:flutter/material.dart';
import 'package:responsive_scafold/responsive_size.dart';

class CustomImage extends StatefulWidget {
  final String? imageUrl; // URL for network image
  final String? assetPath; // Asset path for local image
  final String? filePath; // File path for local file image
  final double? width; // Optional width
  final double? height; // Optional height
  final BoxFit fit;

  CustomImage({
    this.imageUrl,
    this.assetPath,
    this.filePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  _CustomImageState createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkImageSource();
  }

  void _checkImageSource() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (widget.imageUrl != null) {
        _preloadNetworkImage();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _preloadNetworkImage() async {
    final image = NetworkImage(widget.imageUrl!);
    final imageConfiguration = ImageConfiguration();
    final ImageStream stream = image.resolve(imageConfiguration);
    stream.addListener(
      ImageStreamListener(
            (imageInfo, synchronousCall) {
          setState(() {
            _isLoading = false;
          });
        },
        onError: (error, stackTrace) {
          setState(() {
            _isLoading = false;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = widget.height ?? ResponsiveUtil.getHeight(context) * 0.3; // Default to 30% of screen height
    final double width = widget.width ?? ResponsiveUtil.getWidth(context) * 0.5; // Default to 50% of screen width

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    ImageProvider imageProvider;

    if (widget.imageUrl != null) {
      imageProvider = NetworkImage(widget.imageUrl!);
    } else if (widget.assetPath != null) {
      imageProvider = AssetImage(widget.assetPath!);
    } else if (widget.filePath != null) {
      imageProvider = FileImage(File(widget.filePath!));
    } else {
      return SizedBox.shrink(); // Return an empty widget if no image source is provided.
    }

    return Image(
      image: imageProvider,
      width: width,
      height: height,
      fit: widget.fit,
    );
  }
}
