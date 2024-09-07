import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  final String message;

  const FullScreenLoader({super.key, this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black.withOpacity(0.5), // Background color with transparency
        child: Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoaderManager {
  LoaderManager._privateConstructor();

  static final LoaderManager instance = LoaderManager._privateConstructor();

  OverlayEntry? _overlayEntry;

  void showLoader(BuildContext context) {
    final overlay = Overlay.of(context);
    if (_overlayEntry != null) return; // Avoid multiple overlays
    _overlayEntry = OverlayEntry(
      builder: (context) => const FullScreenLoader(),
    );
    overlay.insert(_overlayEntry!);
  }

  void hideLoader() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
