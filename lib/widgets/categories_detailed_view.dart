import 'package:flutter/material.dart';
import 'package:shopisoko/widgets/sale_chevron.dart';
import 'package:shopisoko/models/models.dart';
import 'package:provider/provider.dart';
import 'package:shopisoko/services/product_repository.dart';


class CategoriesDetailedView extends StatefulWidget{
  CategoriesDetailedView({Key key,@required this.products}):super(key: key);
  List<Product> products;

  @override
  CategoriesDetailedState createState()=> CategoriesDetailedState(this.products);
}

class CategoriesDetailedState extends State<CategoriesDetailedView>{

  ProductRepository product_repository=new ProductRepository();
 // Future<List<Product>> future_product;
  List<Product> products;

  String category_search;

  CategoriesDetailedState(this.products);
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
                MediaQuery.of(context).size.height *1/5 :
                MediaQuery.of(context).size.width * 1/5,
                //    color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 0.0),
                          child: Container(
                            margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(14)),
                                //color: Colors.blue.shade200,
                                image: DecorationImage(
                                    image: NetworkImage(products.elementAt(index).image))),
                          ),),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0,horizontal: 1.0),
                                child: Text(products.elementAt(index).name,style: TextStyle(
                                  color: Colors.black87,fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w400,fontSize: 14
                                ),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0,horizontal: 1.0),
                                child: Text('Ksh ' + products.elementAt(index).price,style: TextStyle(
                                    color: Colors.black87,fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w400,fontSize: 12
                                ),),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.0,horizontal: 1.0),
                                child: Container(
                                  width: 250,
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
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider()

                  ],
                ),
              );
          },
        ),
      ),
    );
  }

  addToCart(Product userProduct){

    CartItemsData cartItemsData=new CartItemsData(orderNo: '0000001',pId: userProduct.id,pName:userProduct.name,
        price:userProduct.price,image:userProduct.image,quantity: '1');
    Provider.of<Cart>(context,listen: false).increaseCartSize(cartItemsData);
    print('The new size is '+ Provider.of<Cart>(context,listen: false).cart_size.toString());

    //  cart.cart_items_data.add(cartItemsData);

  }
}

