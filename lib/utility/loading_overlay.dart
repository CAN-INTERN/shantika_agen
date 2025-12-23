import 'package:flutter/material.dart';

class LoadingOverlay {
  OverlayEntry? _overlayEntry;
  bool _isShowing = false;

  void show(BuildContext context) {
    if (_isShowing) return;

    try {
      _overlayEntry = OverlayEntry(
        builder: (context) => Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
      _isShowing = true;
    } catch (e) {
      debugPrint('Error showing loading overlay: $e');
      _isShowing = false;
    }
  }

  void hide() {
    if (!_isShowing) return;

    try {
      _overlayEntry?.remove();
    } catch (e) {
      debugPrint('Error hiding loading overlay: $e');
    } finally {
      _overlayEntry = null;
      _isShowing = false;
    }
  }

  void dispose() {
    hide();
  }

  bool get isShowing => _isShowing;
}