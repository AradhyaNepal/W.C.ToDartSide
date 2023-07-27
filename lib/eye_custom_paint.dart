import 'package:flutter/material.dart';


class EyeCustomPaint extends CustomPainter {
  static const paddingUp=40;
  @override
  void paint(Canvas canvas, Size size) {
    _paintEyeBrow(canvas, size);
    _paintEye(canvas, size);
    _paintEyeBalls(canvas,size);//Todo: Paint eye which moves on which point user have tapped

  }

  void _paintEyeBrow(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style=PaintingStyle.stroke;
    paint.strokeWidth = 5;
    final path=Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width/2, size.height/2, size.width, size.height);
    canvas.drawPath(path, paint);
  }

  void _paintEye(Canvas canvas, Size size) {

    var paint = Paint();
    paint.color = Colors.red;
    paint.style=PaintingStyle.stroke;
    paint.strokeWidth = 5;
    final path1=Path();
    path1.moveTo(0, paddingUp+size.height);
    path1.quadraticBezierTo(size.width/2, size.height/2, size.width, paddingUp+size.height);
    canvas.drawPath(path1, paint);
    final path2=Path();
    path2.moveTo(0, paddingUp+size.height);
    path2.quadraticBezierTo(size.width/2, size.height+size.height/2+paddingUp, size.width, paddingUp+size.height);
    canvas.drawPath(path2, paint);
  }

  void _paintEyeBalls(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style=PaintingStyle.fill;
    canvas.drawOval(, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
