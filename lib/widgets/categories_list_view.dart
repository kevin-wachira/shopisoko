import 'package:flutter/material.dart';
import 'package:shopisoko/widgets/sale_chevron.dart';
import 'package:shopisoko/models/models.dart';
import 'package:provider/provider.dart';
import 'package:shopisoko/services/product_repository.dart';

class CategoriesListView extends StatefulWidget{
  CategoriesListView({Key key,@required this.products}):super(key: key);
  List<Product> products;

  @override
  CategoriesListState createState()=> CategoriesListState(products);
}

class CategoriesListState extends State<CategoriesListView>{
  ProductRepository product_repository=new ProductRepository();
  Future<List<Product>> future_product;
  List<Product> products;

  String category_search;

  CategoriesListState(this.products);


  @override
  void initState() {
  //  this.future_product=this.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).orientation==Orientation.portrait ?
        MediaQuery.of(context).size.height *3/4:
        MediaQuery.of(context).size.width ,
        //    color: Colors.red,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context,index){
            return
              Container(
                //             color: Colors.red,
                width: MediaQuery.of(context).size.width * 1/2,
                height: MediaQuery.of(context).orientation==Orientation.portrait ?
                MediaQuery.of(context).size.height *1/2 :
                MediaQuery.of(context).size.width * 1/2,
                //    color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child:  Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                                child: Container(
                                  margin: EdgeInsets.only(right: 0, left: 8, top: 8, bottom: 8),
                                  width: MediaQuery.of(context).size.width *7/10,
                                  height: 250,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(14)),
                                    //  color: Colors.blue.shade200,
                                      image: DecorationImage(
                                          image: NetworkImage(products.elementAt(index).image))),
                                ),),
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
                        padding: EdgeInsets.only(left: 30.0),
                        child: Container(
                          width:MediaQuery.of(context).size.width,
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
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
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
}