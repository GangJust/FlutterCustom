import 'package:flutter/material.dart';

enum BatteryBulgeType { top, right }

class BatteryWidget extends StatelessWidget {
  final Size size;
  final int level;
  final Color color;
  final double strokeWidth;
  final bool text;
  final TextStyle textStyle;
  final BatteryBulgeType type;
  final Offset offset;

  const BatteryWidget({
    Key key,
    this.size = const Size(30, 15),
    this.level = 20,
    this.color = Colors.grey,
    this.strokeWidth = 1,
    this.text = false,
    this.textStyle = const TextStyle(fontSize: 12, color: Colors.black54),
    this.type = BatteryBulgeType.right,
    this.offset = const Offset(0, 0),
  })  : assert(level >= 1 && level <= 100),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _BatteryPainter(
        size,
        level,
        color,
        strokeWidth,
        text,
        textStyle,
        type,
        offset,
      ),
    );
  }
}

class _BatteryPainter extends CustomPainter {
  final Size size;
  final int level;
  final Color color;
  final double strokeWidth;
  final bool text;
  final TextStyle textStyle;
  final BatteryBulgeType type;
  final Offset offset;

  _BatteryPainter(
    this.size,
    this.level,
    this.color,
    this.strokeWidth,
    this.text,
    this.textStyle,
    this.type,
    this.offset,
  );

  double get ratio {
    var max = size.width > size.height ? size.width : size.height;
    var min = size.width < size.height ? size.width : size.height;

    return max / min;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final _paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = color;

    final _paintFill = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = color;

    //移动画布
    canvas.translate(offset.dx, offset.dy);

    var max = size.width > size.height ? size.width : size.height;
    var min = size.width < size.height ? size.width : size.height;

    if (type == BatteryBulgeType.right) {
      _battery(canvas,Size(max, min), _paintStroke);
      _batteryBulgeRight(canvas,Size(max, min), _paintFill);
      _batteryFillRight(canvas,Size(max, min), _paintFill);
      if(text) _batteryText(canvas,Size(max, min), _paintStroke);
    } else {
      _battery(canvas,Size(min, max), _paintStroke);
      _batteryBulgeTop(canvas,Size(min, max), _paintFill);
      _batteryFillTop(canvas,Size(min, max), _paintFill);
      if(text) _batteryText(canvas,Size(min, max), _paintStroke);
    }


  }

  ///电池外框
  void _battery(Canvas canvas,Size size, Paint paint) {
    final rRect = RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(ratio));
    canvas.drawRRect(rRect, paint);
  }

  ///电池填充 向右
  void _batteryFillRight(Canvas canvas,Size size, Paint paint) {
    final left = 0.0;
    final top = 0.0;
    final right = (size.width / 100) * level;
    final bottom = size.height;
    final radius = Radius.circular(ratio);
    final rRect = RRect.fromLTRBR(left, top, right, bottom, radius);

    canvas.drawRRect(rRect, paint);
  }

  ///电池填充 向上
  void _batteryFillTop(Canvas canvas,Size size, Paint paint) {
    final left = 0.0;
    final top = size.height - ((size.height / 100) * level);
    final right = size.width;
    final bottom = size.height;
    final radius = Radius.circular(ratio);
    final rRect = RRect.fromLTRBR(left, top, right, bottom, radius);

    canvas.drawRRect(rRect, paint);
  }

  ///电池盖右侧
  void _batteryBulgeRight(Canvas canvas,Size size, Paint paint) {
    final left = size.width;
    final top = size.height / 4;
    final right = size.width + size.height / 6;
    final bottom = size.height - size.height / 4;
    final radius = Radius.circular(ratio);
    final rRect = RRect.fromLTRBR(left, top, right, bottom, radius);

    canvas.drawRRect(rRect, paint);
  }

  ///电池盖顶部
  void _batteryBulgeTop(Canvas canvas,Size size, Paint paint) {
    final left = size.width / 5;
    final top = -(size.width / 6);
    final right = size.width - size.width / 4;
    final bottom = 0.0;
    final radius = Radius.circular(ratio);
    final rRect = RRect.fromLTRBR(left, top, right, bottom, radius);

    canvas.drawRRect(rRect, paint);
  }

  ///电池文本值
  void _batteryText(Canvas canvas,Size size, Paint paint) {
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '$level',
        style: textStyle,
      ),
    );
    textPainter.layout();

    final dx = (size.width - textPainter.width) / 2;
    final dy = (size.height - textPainter.height) / 2;
    textPainter.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
