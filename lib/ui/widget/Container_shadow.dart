import 'package:flutter/material.dart';
class ContainerShaadow extends StatelessWidget {
  const ContainerShaadow({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return   Container(
/*      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2, // makes shadow extend on all sides
            offset: const Offset(0, 0), // no directional bias
          ),
        ],
      ),*/
      child: child,
    );
  }
}
