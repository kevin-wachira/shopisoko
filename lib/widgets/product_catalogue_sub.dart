import 'package:flutter/material.dart';
//import 'package:nikeshi/widgets/trial_container.dart';
import 'package:shopisoko/widgets/sale_chevron.dart';
import 'package:shopisoko/pages/product_details.dart';
import 'offer_container.dart';
import 'sold_out_container.dart';
import 'package:shopisoko/widgets/sub_categories.dart';
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/services/product_repository.dart';
import 'package:provider/provider.dart';
import 'package:shopisoko/pages/categories_expanded_view.dart';

class ProductCatalogueSub extends StatefulWidget{
  String product_header;
  String product_detail;
  String sub_category_search;
  ProductCatalogueSub({Key key,@required this.product_header,@required this.product_detail,
    @required this.sub_category_search}):super(key:key);

  @override
  ProductCatalogueSubState createState()=> new ProductCatalogueSubState(product_header,product_detail,
      sub_category_search);
}

class ProductCatalogueSubState extends State<ProductCatalogueSub>{
  String product_header;
  String product_detail;
  String sub_category_search;
  Future<List<Brand>> future_brands;
  Future<List<Product>> future_product;
  ProductRepository product_repository=new ProductRepository();



  ProductCatalogueSubState(this.product_header,this.product_detail,this.sub_category_search);
  @override
  void initState() {
    this.future_product=this.getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: future_product,
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
          List<Product> user_products=snapshot.data;
          return  Padding(
            padding: EdgeInsets.only(bottom: 10.0,left: 10.0,right: 10.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                          child: Text(
                            product_header,style: TextStyle(fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54
                          ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            print('The id is ' + product_detail);
                            if(product_detail.isNotEmpty){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoriesExpandedView(category_search: sub_category_search,)));
                            }

                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                            child: Text(
                              product_detail,style: TextStyle(fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w500,fontSize: 12,color: Colors.black54
                            ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).orientation==Orientation.portrait ?
                        MediaQuery.of(context).size.height * 2/5 :
                        MediaQuery.of(context).size.width * 2/5,
                        //   color: Colors.red,
                        child: FutureBuilder(
                          future: future_product,
                          builder: (context,snapshot){
                            if(snapshot.hasData){

                              //  print('Url is ' + user_products.elementAt(0).image);
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: user_products.length,
                                itemBuilder: (context,index){
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetail(product: user_products.elementAt(index),)));
                                    },
                                    child: Container(
                                      //             color: Colors.red,
                                      width: MediaQuery.of(context).size.width * 1/2,
                                      height: MediaQuery.of(context).orientation==Orientation.portrait ?
                                      MediaQuery.of(context).size.height *2/6 :
                                      MediaQuery.of(context).size.width * 2/6,
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
                                                        // color: Colors.blue.shade200,
                                                        image: DecorationImage(
                                                            image: NetworkImage(user_products.elementAt(index).image))),
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
                                                width:MediaQuery.of(context).size.width * 2/7,
                                                height: MediaQuery.of(context).orientation==Orientation.portrait ?
                                                MediaQuery.of(context).size.height * 1/5 :
                                                MediaQuery.of(context).size.width * 1/5,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    int.parse(user_products.elementAt(index).qty) > 0 ?
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                                                      child: OfferContainer(),
                                                    ): Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                                                      child: SoldOutContainer(),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                                                      child: Wrap(
                                                        children: [
                                                          Text(user_products.elementAt(index).name,style: TextStyle(
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
                                                          Text("Ksh " + user_products.elementAt(index).price,style: TextStyle(
                                                              fontWeight: FontWeight.w400,fontSize: 8,
                                                              color: Colors.black,fontFamily: 'Open Sans'
                                                          ),)
                                                        ],
                                                      ),
                                                    ),

                                                    Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                                                        child: Container(
                                                          width: 150,
                                                          height: 30,
                                                          child: FlatButton.icon(
                                                            onPressed: (){
                                                              setState(() {
                                                                addToCart(user_products.elementAt(index));
                                                              });
                                                            },
                                                            icon: Icon(Icons.shopping_cart,color: Colors.white,size: 10,),
                                                            label: Text('ADD TO CART',style: TextStyle(
                                                                color: Colors.white,fontFamily: 'Open Sans',
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 10
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
                                    ),
                                  );
                                },
                              );
                            }
                            else if(snapshot.hasError){
                              return Container();
                            }

                            else{
                              return Container();
                            }
                          },
                        )
                    ),
                  )
                ],
              ),
            ),
          );
        }

        else if(snapshot.connectionState==ConnectionState.waiting){
          return Container();
        }
        else if(snapshot.hasError){
          return Container(
            child: Center(
              child: Text('Check your internet connection'),
            ),
          );
        }

        else{
          return Container();
        }
      },
    );
  }

  Future<List<Product>> getProducts() async{
    if(sub_category_search==''){
      Future<List<Product>> user_products=product_repository.getProducts();
      return user_products;
    }

    else{
      print('category search is ' + sub_category_search);
      int category_search_id=int.parse(sub_category_search);
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