import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

class TrialChevron extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: TrialChevronWidget(),
      child: Container(
          child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 2.0),
                child: Text(
                  'Sale',style: TextStyle(
                    fontFamily: 'Open Sans',fontWeight: FontWeight.w500,color: Colors.white,
                    fontSize: 10
                ),
                ),
              )
          )
      ),
    );
  }

}

class TrialChevronWidget extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    num degToRad(num deg) => deg * (Math.pi / 180.0);

    Path path = Path();
    path.arcTo(Rect.fromLTWH(size.width / 2, size.height / 2, size.width / 4, size.height / 4), degToRad(0), degToRad(90), true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}