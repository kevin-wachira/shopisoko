import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopisoko/widgets/product_catalogue.dart';
import 'package:shopisoko/widgets/footer.dart';
import 'package:shopisoko/models/models.dart';
import 'package:provider/provider.dart';
import  'package:badges/badges.dart';


class ProductDetail extends StatefulWidget{
     ProductDetail({Key key,@required this.product}):super(key:key);
     Product product;

     @override
  ProductDetailState createState()=>new ProductDetailState(product);
}

class ProductDetailState extends State<ProductDetail>{
  bool is_expanded=false;
  Product product;
  ProductDetailState(this.product);
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:Text('View Cart',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color.fromRGBO(0,0,139,1)),),
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
            icon:Icon(Icons.search,color: Color.fromRGBO(0,0,139,1),size: 30,),
          ),
           cartComponent(),
          /*IconButton(
              onPressed: (){},
              icon:Icon(Icons.shopping_cart,color: Color.fromRGBO(0,0,139,1),size:30)
          ),*/
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
      body: Container(
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).orientation==Orientation.portrait ?
                  MediaQuery.of(context).size.height * 1/3
                    :MediaQuery.of(context).size.width * 1/3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0,1.0),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.black12,
                      ),

                    ]
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top:20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                                child: InkWell(
                                  onTap: (){},
                                  child: Row(
                                    children: [
                                      Text('Save to List',style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Open Sans'
                                      ),),
                                      Icon(Icons.assignment,color: Colors.black54,size: 30,)
                                    ],
                                  ),
                                ),
                              ),

                            ],),
                        ),

                        Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 3/4,
                            height: MediaQuery.of(context).orientation==Orientation.portrait ?
                            MediaQuery.of(context).size.height * 1/6 :
                            MediaQuery.of(context).size.width * 1/6,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                 // fit: BoxFit.cover,
                                fit:BoxFit.contain,
                                  image:NetworkImage(product.image)
                             //     image: NetworkImage("https://media.npr.org/assets/news/2010/04/26/groceries_wide-0cf2b0fc41c9b82c329067ffe04d787041c17251.jpg?s=1400")
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10.0,top: 40.0),
                                child: InkWell(
                                  onTap: (){},
                                  child: Row(
                                    children: [
                                      Text('Share',style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Open Sans'
                                      ),),
                                      Icon(Icons.share,color: Colors.black54,size: 30,)
                                    ],
                                  ),
                                ),
                              ),

                            ],),
                        ),
                      ],
                    ),
                  )
                ),
              ),
              
              Padding(
                padding: EdgeInsets.only(bottom: 10.0,left: 10.0,right: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).orientation==Orientation.portrait ?
                  MediaQuery.of(context).size.height * 1/4:
                  MediaQuery.of(context).size.width * 1/4
                  ,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0,1.0),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.black12,
                      ),
                    ]
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                              child: Text(  'Name: ' + product.name,
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 15
                              ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                                    child: Container(
                                      width: 1,
                                      height: 1,
                                      child: Checkbox(
                                        value: int.parse(product.qty) > 0 ? true : false,
                                        activeColor: Color.fromRGBO(0,0,139,1),
                                        onChanged: (bool newValue){
                                          setState(() {

                                          });
                                        },
                                      ),
                                    )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                                    child: Text('In stock available',style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(0,0,139,1),
                                      fontFamily: 'Open Sans'
                                    ),),
                                  )
                                ],
                              )
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                              child: Text("Ksh " + product.price,
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0,139,1),
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17
                                ),
                              ),
                            ),

                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                                        child: Container(
                                          width: 1,
                                          height: 1,
                                          child: Icon(Icons.circle,color: Colors.blue,size: 10,)
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                                      child: Container(
                                          width: 1,
                                          height: 1,
                                          child: Icon(Icons.circle,color: Colors.blue,size: 10,)
                                      )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: FlatButton.icon(onPressed: (){
                            setState(() {
                              addToCart(product);
                            });
                          },
                              icon: Icon(Icons.shopping_cart,color: Colors.white,size: 30,),
                              label: Text('ADD TO CART',style: TextStyle(
                                color: Colors.white,fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 15
                              ),),
                          color: Color.fromRGBO(0,0,139,1),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
                        child: Wrap(
                          children: [
                            Text('The prices of all weighted items are subject to change at the time of '
                                'weighing',style: TextStyle(
                              fontWeight: FontWeight.w400,fontFamily: 'Open Sans',
                              color: Color.fromRGBO(0,0,139,1)
                            ),)
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0,left: 10.0,right: 10.0),
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: MediaQuery.of(context).size.width,
                    height: is_expanded ?
                    MediaQuery.of(context).orientation==Orientation.portrait ?
                    MediaQuery.of(context).size.height * 2/7 :
                        MediaQuery.of(context).size.width * 2/7:
                    MediaQuery.of(context).size.height * 1/5
                  ,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(1.0,1.0),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                            color: Colors.black12,
                          ),
                        ]
                    ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                        child: Text(
                          'Product Description',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Open Sans'
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0,left: 0.0,right: 0.0),
                        child: Text(
                          'Name: ' + product.name,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                          ),
                        ),
                      ),

                      is_expanded ?
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                        child: Text(
                          'tags for search purposes only,these do not signify the actual product '
                              'attributes - for clarity on product,please contact our customer support team:'
                              'Fresh,fresh vegetable,vegetable,salad',
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,
                              color: Colors.black54,fontFamily: 'Open Sans'),
                        ),
                      ) : SizedBox(height: 0,),

                      InkWell(
                        onTap: (){
                            setState(() {
                              is_expanded=!is_expanded;
                            });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.0,left: 0.0,right: 0.0,top: 20.0),
                          child: Text(
                            is_expanded ? 'Read less' : 'Read more',
                            style: TextStyle(
                                color: Color.fromRGBO(0,0,139,1),
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                decoration: TextDecoration.underline
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).orientation==Orientation.portrait ?
                MediaQuery.of(context).size.height * 6/11 :
                MediaQuery.of(context).size.width * 6/11,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0,1.0),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.black12,
                      ),
                    ]
                ),
                child: ProductCatalogue(product_header: 'Similar Products',product_detail: '',category_search: '',),
              ),
              Container(width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).orientation==Orientation.portrait ?
                MediaQuery.of(context).size.height * 6/11 :
                MediaQuery.of(context).size.width * 6/11,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0,1.0),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.black12,
                      ),
                    ]
                ),
                child:ProductCatalogue(product_header: 'Most Sold Items',product_detail: '',category_search: '',),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).orientation==Orientation.portrait ?
                MediaQuery.of(context).size.height * 6/11 :
                MediaQuery.of(context).size.width * 6/11,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0,1.0),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.black12,
                      ),
                    ]
                ),
                child: ProductCatalogue(product_header: 'Frequently Bought Together',product_detail: '',category_search: '',),
              ),



              Footer()
            ],
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 10,
        child: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width * 1/3,
        ),
      ),
      endDrawer: Drawer(
        elevation: 10,
        child: Container(
          width: MediaQuery.of(context).size.width * 1/3,
          color: Colors.blue,
        ),
      ),
    );
  }

  addToCart(Product userProduct){
   setState(() {
     CartItemsData cartItemsData=new CartItemsData(orderNo: '0000001',pId: userProduct.id,pName:userProduct.name,
         price:userProduct.price,image:product.image,quantity: '1');
     Provider.of<Cart>(context,listen: false).increaseCartSize(cartItemsData);
     print('The new size is '+ Provider.of<Cart>(context,listen: false).cart_size.toString());
     //  cart.cart_items_data.add(cartItemsData);
   });

  }

  Widget cartComponent(){
    return Stack(
      children: <Widget>[
        new IconButton(icon: Icon(
          Icons.shopping_cart_outlined,size: 30,
          color: Color.fromRGBO(0,0,139,1),
        ),
          onPressed: () {
            setState(() {
              //     _navigatorKey.currentState.pushReplacementNamed('/cart_nav');
            });
          },),
        Provider.of<Cart>(context,listen: false).cart_size > 0 ?
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