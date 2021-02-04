import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/pages/cart_details.dart';

class CartComponent extends StatefulWidget{
  CartComponent({Key key}):super(key:key);

  @override
  CartComponentState createState()=> CartComponentState();

}
class CartComponentState extends State<CartComponent>{

  CartComponentState();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        new IconButton(icon: Icon(
          Icons.shopping_cart_outlined,size: 30,
          color: Color.fromRGBO(0,0,139,1),
        ),
          onPressed: () {
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartDetails()));
            });
          },),
        Provider.of<Cart>(context).cart_size > 0 ?
        new Positioned(
          top: 0.0,
          right: 0.0,
          child: new Stack(
            children: <Widget>[
              new Container(width: 30, height: 30,),
              //   new Icon(Icons.brightness_1,size: 20.0,color: Colors.red,),
              new Positioned(
                  top: 3.0,
                  left: 6.0,
                  child: Badge(
                    position: BadgePosition.topEnd(
                        top: 0, end: 3),
                    badgeColor: Color.fromRGBO(0,0,139,1),
                    animationDuration: Duration(
                        milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text('' + Provider
                        .of<Cart>(context)
                        .cart_size
                        .toString(),
                      style: TextStyle(color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
              )
            ],
          ),
        ): SizedBox(width: 0, height: 0,)


      ],
    );
  }
}