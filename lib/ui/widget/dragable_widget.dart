import 'package:flutter/material.dart';

/// Reusable draggable widget
class DraggableWidget extends StatefulWidget {
  final Widget child;
  final double initialLeft;
  final double initialTop;
  final bool horizontalOnly;

  const DraggableWidget({
    Key? key,
    required this.child,
    this.initialLeft = 0,
    this.initialTop = 0,
    this.horizontalOnly = true, // restrict movement to horizontal axis
  }) : super(key: key);

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  late double posX;
  late double posY;

  @override
  void initState() {
    super.initState();
    posX = widget.initialLeft;
    posY = widget.initialTop;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: posX,
      top: posY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // Horizontal movement
            if (widget.horizontalOnly) {
              posX += details.delta.dx;
              posX = posX.clamp(0.0, screenWidth - 56); // 56 = default FAB size
            } else {
              posX += details.delta.dx;
              posY += details.delta.dy;
              posX = posX.clamp(0.0, screenWidth - 56);
              posY = posY.clamp(0.0, screenHeight - 56 - kToolbarHeight); // avoid appbar
            }
          });
        },
        child: widget.child,
      ),
    );
  }
}
