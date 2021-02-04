import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaleChevron extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: SaleChevronWidget(),
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

class SaleChevronWidget extends CustomPainter{
  @override
  void paint(Canvas canvas,Size size){
       final Gradient gradient=new LinearGradient(
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
         colors: [Colors.red,Colors.red,],
         tileMode: TileMode.clamp
       );

     final Rect colorBounds=Rect.fromLTRB(0,0,size.width * 1/6,size.height * 1/6);
    /* final Paint paint=new Paint()..
     shader=gradient.createShader(colorBounds);*/
       var paint=new Paint();
       paint.color=Colors.red;
       paint.style=PaintingStyle.fill;

     Path path=Path();
     path.moveTo(10,0);
     path.lineTo(40,0);
   //  path.quadraticBezierTo(38,2,40,5);
     path.lineTo(40,16);
     path.lineTo(10,16);
     path.lineTo(10,12);
    path.lineTo(4,8);
    path.lineTo(10, 4);
    // path.lineTo(0, size.height * 0.15);
     path.lineTo(10,0);
     path.close();

     canvas.drawPath(path,paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}