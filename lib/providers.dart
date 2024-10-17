import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller/dock_controller.dart';

/// Provider for managing icon state.
final dockControllerProvider = Provider((ref) => DockController());

/// StateNotifier to manage the icon list state.
final iconsProvider = StateNotifierProvider<IconNotifier, List<IconData>>(
      (ref) => IconNotifier(ref.read(dockControllerProvider)),
);

class IconNotifier extends StateNotifier<List<IconData>> {
  final DockController controller;

  IconNotifier(this.controller) : super(controller.icons);

  /// Reorder the icons and update state.
  void reorderIcons(int oldIndex, int newIndex) {
    controller.reorderIcons(oldIndex, newIndex);
    state = List.from(controller.icons); // Refresh state with the updated list.
  }
}
