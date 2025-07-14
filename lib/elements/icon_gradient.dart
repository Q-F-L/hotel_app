import 'package:flutter/material.dart';

class IconGradient extends StatelessWidget {
  IconGradient({super.key, required this.icon, required this.colors});
  Widget icon;
  List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) => RadialGradient(
              center: Alignment.centerLeft, // near the top right
              radius: 0.7,
              colors: <Color>[
                colors[0], // yellow sun
                colors[1], // blue sky
              ],
              stops: <double>[0.5, 1.0],
            ).createShader(bounds),
        child: icon);
  }
}
