import 'package:flutter/material.dart';

class SoldOutContainer extends StatelessWidget{
  SoldOutContainer({Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 40,
      height: 40,

      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: Center(
        child: Text('sold out',style: TextStyle(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w600,
          fontFamily: 'Open Sans',),),
      ),
    );
  }
}