import 'package:flutter/material.dart';

class ShowProgress {
  static OverlayEntry? _overlayEntry;

  static void removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static void showLoadingOverlay(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_overlayEntry == null) {
        final overlay = Overlay.of(context);
        _overlayEntry = OverlayEntry(
          builder: (context) => const Center(
            child: Material(
              color: Colors.transparent,
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
        overlay.insert(_overlayEntry!);
      }
    });
  }
}
