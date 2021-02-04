import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class Footer extends StatelessWidget{
  Footer({Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height *1/6,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2/10,
                    height: MediaQuery.of(context).size.height * 1/12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Icon(CupertinoIcons.shopping_cart,color: Colors.black54,size: 30,),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Text('Easy \nShopping',style: TextStyle(color: Colors.black54,
                              fontSize: 9,fontWeight: FontWeight.w400,fontFamily: 'Open Sans'),),
                        )
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2/10,
                    height: MediaQuery.of(context).size.height * 1/12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Icon(CupertinoIcons.checkmark_shield,color: Colors.black54,size: 30,),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Text('Freshness \nGuaranteed',style: TextStyle(color: Colors.black54,
                              fontSize: 9,fontWeight: FontWeight.w400,fontFamily: 'Open Sans'),),
                        )
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2/10,
                    height: MediaQuery.of(context).size.height * 1/12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Icon(Icons.local_shipping_outlined,color: Colors.black54,size: 30,),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Text('Open Box \nDelivery',style: TextStyle(color: Colors.black54,
                              fontSize: 9,fontWeight: FontWeight.w400,fontFamily: 'Open Sans'),),
                        )
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2/10,
                    height: MediaQuery.of(context).size.height * 1/12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Icon(CupertinoIcons.lock_circle,color: Colors.black54,size: 30,),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Text('Secure \nPayment',style: TextStyle(color: Colors.black54,
                              fontSize: 9,fontWeight: FontWeight.w400,fontFamily: 'Open Sans'),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Divider(),
            Center(
              child:Column(
                children: [
                  Text("\n Designed and Develped by Shopilyv "),
                ],
              ),

            )
          ],
        )
      ),
    );
  }
}