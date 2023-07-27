import 'package:flutter/material.dart';

class EyeCustomPaint extends CustomPainter {
  PointerMoveEvent? pointerMoveEvent;

  EyeCustomPaint(this.pointerMoveEvent);

  static const paddingUp = 40;

  @override
  void paint(Canvas canvas, Size size) {
    _paintEyeBrow(canvas, size);
    _paintEye(canvas, size);
    _paintEyeBalls(canvas, size);
  }

  void _paintEyeBrow(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height);
    canvas.drawPath(path, paint);
    double browHeight=10;
    double browH = 0;
    final browHMax = size.height / 2+40;
    paint.strokeWidth=2;
    double browHChange=5.5;
    for (double browV = 0; browV <= size.width; browV+=10) {
      canvas.drawLine(Offset(browV, size.height+browH-paint.strokeWidth*2), Offset(browV, size.height+browH-browHeight-paint.strokeWidth*2),paint);
      bool eyeBrowKeepGoingUp=browHMax>browV;
      if(eyeBrowKeepGoingUp){
        browH-=browHChange;
        browHChange=browHChange-0.3;
      }else{
        browH+=browHChange;
        browHChange=browHChange+0.45;
      }

    }

  }

  void _paintEye(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    final path1 = Path();
    path1.moveTo(0, paddingUp + size.height);
    path1.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, paddingUp + size.height);
    canvas.drawPath(path1, paint);
    final path2 = Path();
    path2.moveTo(0, paddingUp + size.height);
    path2.quadraticBezierTo(
        size.width / 2,
        size.height + size.height / 2 + paddingUp,
        size.width,
        paddingUp + size.height);
    canvas.drawPath(path2, paint);
  }

  void _paintEyeBalls(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(getXOffset(size), getYOffset(size)), size.height * 0.125, paint);
  }

  double getXOffset(Size size) {
    final position = pointerMoveEvent?.position.dx;
    if (position == null) return size.width * 0.5;
    final leftMax = size.width * 0.2;
    final rightMax = size.width * 0.8;
    if (position < leftMax) {
      return leftMax;
    } else if (position > rightMax) {
      return rightMax;
    }
    return position;
  }

  double getYOffset(Size size) {
    return size.height + paddingUp - 10;
  }

  @override
  bool shouldRepaint(covariant EyeCustomPaint oldDelegate) {
    return oldDelegate.pointerMoveEvent != pointerMoveEvent;
  }
}
