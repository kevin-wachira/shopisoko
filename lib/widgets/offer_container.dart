import 'package:flutter/material.dart';

class OfferContainer extends StatelessWidget{
  OfferContainer({Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 40,
      height: 40,

      decoration: BoxDecoration(
          color: Colors.green,
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Center(
        child: Text('21% Off',style: TextStyle(color: Colors.white,fontSize: 9,fontWeight: FontWeight.w600,
        fontFamily: 'Open Sans',),),
      ),
    );
  }
}