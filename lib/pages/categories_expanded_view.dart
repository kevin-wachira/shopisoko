import 'package:flutter/material.dart';
import 'package:shopisoko/widgets/categories_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopisoko/widgets/sale_chevron.dart';
import 'package:shopisoko/widgets/categories_detailed_view.dart';
import 'package:shopisoko/models/models.dart';
import 'package:provider/provider.dart';
import 'package:shopisoko/services/product_repository.dart';
import 'package:shopisoko/widgets/cart_component.dart';

class CategoriesExpandedView extends StatefulWidget {
  CategoriesExpandedView({Key key,@required this.category_search}) :super(key: key);
  String category_search;

  CategoriesExpandedState createState() => CategoriesExpandedState(category_search);
}
class  CategoriesExpandedState extends State<CategoriesExpandedView>{
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int _payment_value=1;
  int populated_view=1;
  ProductRepository product_repository=new ProductRepository();
  Future<List<Product>> future_product;
  //int payment value1=1;
  String category_search;

  CategoriesExpandedState(this.category_search);

  @override
  void initState() {
    this.future_product=this.getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Shopi Soko", style: TextStyle(
            color: Color.fromRGBO(0,0,139,1),
            fontSize: 15,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700
        ),
        ),
        centerTitle: true,
        actions: [

          Icon(Icons.search, size: 30,),

          /*IconButton(
              onPressed: (){
            //    Navigator.push(context,MaterialPageRoute(builder: (context)=>CartDetails()));
              },
              icon:Icon(Icons.shopping_cart,size: 30,)),*/

          CartComponent(),
          Icon(Icons.more_vert,size: 30)
        ],
        iconTheme: IconThemeData(
            color: Color.fromRGBO(0,0,139,1)
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: future_product,
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                List<Product> userProduct=snapshot.data;
                return SingleChildScrollView(
                  child:Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0,top: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  child:    DropdownButtonHideUnderline(child:
                                  DropdownButton(
                                    value: _payment_value,
                                    iconEnabledColor: Color.fromRGBO(0,0,0,1),
                                    items: [
                                      DropdownMenuItem(child: Text('All',semanticsLabel: 'hello',
                                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,
                                            color: Color.fromRGBO(0,0,0,1)),),
                                        value: 1,),

                                      DropdownMenuItem(child: Text("On Sale",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                      DropdownMenuItem(child: Text("In Stock",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                    ],
                                    onChanged: (value){
                                      setState((){
                                        _payment_value=value;
                                      });
                                    },
                                  ))



                              ),),
                            Expanded(
                              flex: 2,
                              child: Container(
                                  height: 40.0,
                                  child:    DropdownButtonHideUnderline(child:
                                  DropdownButton(
                                    value: _payment_value,
                                    iconEnabledColor: Color.fromRGBO(0,0,0,1),
                                    items: [
                                      DropdownMenuItem(child: Text('Best Match',semanticsLabel: 'hello',
                                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800,
                                            color: Color.fromRGBO(0,0,0,1)),),
                                        value: 1,),

                                      DropdownMenuItem(child: Text("Brand A-Z",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                      DropdownMenuItem(child: Text("Brand Z-A",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                      DropdownMenuItem(child: Text("Price Low to High",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                      DropdownMenuItem(child: Text("Price High to low",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                      DropdownMenuItem(child: Text("Popularity",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                      DropdownMenuItem(child: Text("Mostly Viewed",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                    ],
                                    onChanged: (value){
                                      setState((){
                                        _payment_value=value;
                                      });
                                    },
                                  ))



                              ),
                            ),
                            //Spacer(),
                            Expanded(
                              flex: 1,
                              child:
                              Container(
                                  height: 40.0,
                                  child:    DropdownButtonHideUnderline(child:
                                  DropdownButton(
                                    value: _payment_value,
                                    icon: Icon(Icons.filter_alt_outlined,color: Colors.black12,size: 20,),
                                    iconEnabledColor: Color.fromRGBO(0,0,0,1),
                                    items: [
                                      DropdownMenuItem(child: Text('filter',semanticsLabel: 'hello',
                                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800,
                                            color: Color.fromRGBO(0,0,0,1)),),
                                        value: 1,),

                                      DropdownMenuItem(child: Text("Filter by price",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),
                                      DropdownMenuItem(child: Text("Filter by brand",style: TextStyle(fontSize: 14,
                                          fontWeight: FontWeight.w700,color: Colors.black),),value: 3,),

                                    ],
                                    onChanged: (value){
                                      setState((){
                                        _payment_value=value;
                                      });
                                    },
                                  ))

                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
                        child: Container(
                          width: 600,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          color: Colors.grey,

                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Products :"),
                              IconButton(
                                icon:Icon(Icons.menu, color: Colors.black, size: 20,
                                ),  onPressed:(){
                                updateView();
                              },
                              ),

                            ],
                          ),
                        ),
                      ),
                      populated_view==1?
                      createExpandedView(userProduct) :
                      populated_view==2 ?
                      CategoriesListView(products: userProduct,) :
                      populated_view==3 ?
                      CategoriesDetailedView(products: userProduct,) : null
                    ],
                  ),
                );
              }

              else if(snapshot.hasError){
                return Container();
              }

              else if(snapshot.connectionState==ConnectionState.done){
                return Container();
              }

              else{
                return Container();
              }
            },
          )

        ),
      )
    );
  }

  Widget createExpandedView(List<Product> products){
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).orientation==Orientation.portrait ?
        MediaQuery.of(context).size.height *3/4:
        MediaQuery.of(context).size.width ,
        //    color: Colors.red,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 5/6,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: products.length,
          itemBuilder: (context,index){
            return
              Container(
                //             color: Colors.red,
                width: MediaQuery.of(context).size.width * 1/2,
                height: MediaQuery.of(context).orientation==Orientation.portrait ?
                MediaQuery.of(context).size.height *1/4 :
                MediaQuery.of(context).size.width * 1/4,
                //    color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                          //        color: Colors.blue.shade200,
                                  image: DecorationImage(
                                      image: NetworkImage(products.elementAt(index).image))),
                            ),

                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SaleChevron(
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                        child: Container(
                          width:MediaQuery.of(context).size.width * 2/5,
                          height: MediaQuery.of(context).orientation==Orientation.portrait ?
                          MediaQuery.of(context).size.height * 1/8 :
                          MediaQuery.of(context).size.width * 1/8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                                child: Wrap(
                                  children: [
                                    Text(products.elementAt(index).name,style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                        fontSize: 11
                                    ),)
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                child: Wrap(
                                  children: [
                                    Text("Ksh " + products.elementAt(index).price,style: TextStyle(
                                        fontWeight: FontWeight.w400,fontSize: 8,
                                        color: Colors.black,fontFamily: 'Open Sans'
                                    ),)
                                  ],
                                ),
                              ),

                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                                  child: Container(
                                    width: 400,
                                    height: 40,
                                    // color: Colors.red,
                                    child: FlatButton.icon(
                                      onPressed: (){
                                        setState(() {
                                          addToCart(products.elementAt(index));
                                        });
                                      },
                                      icon: Icon(Icons.shopping_cart,color: Colors.white,size: 16,),
                                      label: Text('ADD TO CART',style: TextStyle(
                                          color: Colors.white,fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12
                                      ),),
                                      color: Color.fromRGBO(0,0,139,1),
                                    ),
                                  )
                              ),

                            ],
                          ),
                        )
                    )
                  ],
                ),
              );
          },
        ),
      ),
    );
  }

  updateView(){
   if(populated_view<3){
     setState(() {
       populated_view++;
     });
   }
   else{
     setState(() {
       populated_view=1;
     });
   }

  }

  Future<List<Product>> getProducts() async{
    if(category_search==''){
      Future<List<Product>> user_products=product_repository.getProducts();
      return user_products;
    }

    else{
      print('category search is ' + category_search);
      int category_search_id=int.parse(category_search);
      Future<List<Product>> user_products=product_repository.getProductByCategorySub(category_search_id);
      return user_products;
    }
  }

  addToCart(Product userProduct){

    CartItemsData cartItemsData=new CartItemsData(orderNo: '0000001',pId: userProduct.id,pName:userProduct.name,
        price:userProduct.price,image:userProduct.image,quantity: '1');
    Provider.of<Cart>(context,listen: false).increaseCartSize(cartItemsData);
    print('The new size is '+ Provider.of<Cart>(context,listen: false).cart_size.toString());

    //  cart.cart_items_data.add(cartItemsData);

  }
  /*Widget cartComponent(){
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
  }*/
}

