import 'package:flutter/material.dart';

extension on String {
  String initials() {
    String result = "";
    List<String> words = split(" ");
    for (var element in words) {
      if (element.trim().isNotEmpty && result.length < 2) {
        result += element[0].trim();
      }
    }

    return result.trim().toUpperCase();
  }
}

class Initicon extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double size;
  final BorderRadiusGeometry? borderRadius;
  final double elevation;
  final TextStyle? style;
  final BoxBorder? border;

  const Initicon({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.grey,
    this.size = 45,
    this.borderRadius,
    this.elevation = 0,
    this.style,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: backgroundColor,
      borderRadius: borderRadius ?? BorderRadius.circular(150),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(150),
          border: border,
        ),
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              color: _color,
              fontSize: _fontSize,
            ),
            child: Text(
              text.initials(),
              style: style,
            ),
          ),
        ),
      ),
    );
  }

  Color get _color => HSLColor.fromColor(backgroundColor).lightness < 0.8
      ? Colors.white
      : Colors.black87;

  double get _fontSize => size / (text.initials().length == 2 ? 2.5 : 1.8);
}