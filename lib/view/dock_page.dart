import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

class DockPage extends ConsumerWidget {
  const DockPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final icons = ref.watch(iconsProvider);

    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            image: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5XphJmWSqghMwKgh57dceQyagARQ9vG3g-A&s", // Your background image URL
            ).image,
            fit: BoxFit.cover, // Adjust how the image is displayed
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              width: 400, // Reduce the width of the container
              height: 80, // Reduced height
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],

              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, // Align icons to the center
                children: [
                  Expanded(
                    child: ReorderableListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      onReorder: (oldIndex, newIndex) {
                        ref.read(iconsProvider.notifier).reorderIcons(oldIndex, newIndex);
                      },
                      itemCount: icons.length,
                      buildDefaultDragHandles: false,
                      itemBuilder: (context, index) {
                        final icon = icons[index];
                        return ReorderableDragStartListener(
                          key: ValueKey(icon),
                          index: index,
                          child: _AnimatedIcon(
                            icon: icon,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  final IconData icon;

  const _AnimatedIcon({required this.icon, Key? key}) : super(key: key);

  @override
  State<_AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<_AnimatedIcon> {
  double _scale = 1.0;

  void _onHover(bool isHovered) {
    setState(() {
      _scale = isHovered ? 1.5 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          constraints: const BoxConstraints(minWidth: 48),
          width: 58, // Ensures consistent width for icons
          height: 58,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.primaries[widget.icon.hashCode % Colors.primaries.length],
          ),
          child: Center(
            child: Icon(widget.icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
