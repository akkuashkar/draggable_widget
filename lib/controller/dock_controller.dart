import 'package:flutter/material.dart';

class DockController {
  /// List of icons for the dock.
  List<IconData> icons = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  /// Reorder the icons based on drag-and-drop.
  void reorderIcons(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final icon = icons.removeAt(oldIndex);
    icons.insert(newIndex, icon);
  }
}
