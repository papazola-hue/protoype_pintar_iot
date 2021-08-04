import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    this.tinggi: 60,
    this.lebar: 150,
    this.child,
    this.color,
    this.onPressed,
    this.shape,
  }) : super(key: key);
  final double lebar;
  final double tinggi;
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final OutlinedBorder shape;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: lebar, height: tinggi),
      child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: shape != null ? MaterialStateProperty.all(shape) : null,
            backgroundColor: MaterialStateProperty.all(color),
            padding: MaterialStateProperty.all(EdgeInsets.all(16)),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}