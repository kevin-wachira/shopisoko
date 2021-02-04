import 'package:flutter/material.dart';
//import 'package:nikeshi2/pages/CheckoutPage2.dart';
import 'package:shopisoko/widgets/cart_component.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'package:shopisoko/pages/user_container.dart';
import '../models/models.dart';
import 'package:shopisoko/models/cart.dart';
import 'package:shopisoko/widgets/drawers/home_drawer.dart';


class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  Future<List<CartItemsData>> future_cart;
  Future<List<CartItemsData>> cart_item;
  @override
  void initState() {
/*
    this.future_cart=this.getProducts();
*/
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:Text('Checkout',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color.fromRGBO(0,0,139,1)),),
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
            icon:Icon(Icons.search,color: Color.fromRGBO(0,0,139,1),size: 30,),
          ),
          /* IconButton(
            onPressed: (){},
            icon:Icon(Icons.shopping_cart,color: Color.fromRGBO(0,0,139,1),size:30)
          ),*/
          CartComponent(),
          Builder(
              builder: (context)=>IconButton(
                  onPressed: (){Scaffold.of(context).openEndDrawer();},
                  icon:Icon(Icons.menu_rounded,color: Color.fromRGBO(0,0,139,1),size: 30,)
              )
          )
        ],
        iconTheme: IconThemeData(
            color: Color.fromRGBO(0,0,139,1)),
      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(

          child:  Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),

                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text("Product Name "),
                        Text("Quantity"),
                        Text("Amount")

                      ],

                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*1/2,

                     child:  ListView.builder(
                       itemCount: Provider.of<Cart>(context).cart_size,

                       itemBuilder: (context,index){
                         return Padding(
                           padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                           child: (Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,

                             children: [
                              Padding(
                                padding: EdgeInsets.only(left:20),
                                child:  Container(
                                  width: MediaQuery.of(context).size.width * 1/5,
                                  height: 30,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Provider.of<Cart>(context,listen: false).cart_items_data.elementAt(index).pName),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child:  Container(
                                  width: MediaQuery.of(context).size.width * 1/5,
                                  height: 30,
                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(Provider.of<Cart>(context,listen: false).cart_items_data.elementAt(index).quantity),

                                    ],
                                  ),
                                ),
                              ),
                               Padding(
                                 padding: EdgeInsets.only(left: 20),
                                 child: Container(
                                   width: MediaQuery.of(context).size.width * 1/5,
                                   height: 30,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Text(Provider.of<Cart>(context,listen: false).cart_items_data.elementAt(index).price),

                                     ],
                                   ),
                                 ),
                               )
                             ],
                           )
                           ),
                         );
                         /*createCartListItem(Provider.of<Cart>(context,listen: false).cart_items_data.elementAt(index),index);*/
                       },
                     ),
                    /*child: FutureBuilder(
                        future: future_cart,
                        builder: (context,snapshot){

                          if( snapshot.hasData) {

                            return Container();



                          }

                          else if(snapshot.connectionState==ConnectionState.waiting){
                            return Container();
                          }
                          else {
                            return Container();
                          }
                        }
                    )*/
                  /*
                   ),*/
                ),
                Container(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: Text('Grocery Cart details',style: TextStyle(fontWeight: FontWeight.w500,
                        fontFamily: 'Open Sans',fontSize: 14,color: Colors.black54),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1/4,
                    child:
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Text('Subtotal',style: TextStyle(color: Colors.black54,
                                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Open Sans'),),
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Text('Ksh ' + Provider.of<Cart>(context,listen: false).calculateTotal().toString(),style: TextStyle(color: Colors.black54,
                                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Open Sans'),),
                              )
                            ],
                          ),
                        ),

             /*           Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Text('Discount',style: TextStyle(color: Colors.black54,
                                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Open Sans'),),
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Text("10%",style: TextStyle(color: Colors.black54,
                                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Open Sans'),),
                              )
                            ],
                          ),
                        ),*/
/*
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Text('Packing/delivery fee',style: TextStyle(color: Colors.black54,
                                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Open Sans'),),
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Text('Ksh 2000',style: TextStyle(color: Colors.black54,
                                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Open Sans'),),
                              )
                            ],
                          ),
                        ),*/
    /*                    Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Text('Total',style: TextStyle(color: Colors.black87,
                                    fontWeight: FontWeight.w600,fontSize: 14,fontFamily: 'Open Sans'),),
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Text('Ksh 4000',style: TextStyle(color: Colors.black87,
                                    fontWeight: FontWeight.w600,fontSize: 14,fontFamily: 'Open Sans'),),
                              )
                            ],
                          ),
                        )*/
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child:     RaisedButton(

                      onPressed: (){
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>UserContainer()));

                      },
                      child: Text('PLACE   ORDER',style: TextStyle(
                          color: Colors.white,fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14
                      ),),
                      color: Color.fromRGBO(0,0,139,1),

                    ),
                  ),
                )

              ],




            ),
          ),

        ),


      ),

//// This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  getProducts(Product userProduct){

    CartItemsData cartItemsData=new CartItemsData(orderNo: '0000001',pId: userProduct.id,pName:userProduct.name,
        price:userProduct.price,quantity: '1');
    Provider.of<Cart>(context,listen: false).increaseCartSize(cartItemsData);
    print('The new size is '+ Provider.of<Cart>(context,listen: false).cart_size.toString());

    //  cart.cart_items_data.add(cartItemsData);

  }


}

