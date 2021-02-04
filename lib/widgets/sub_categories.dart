import 'package:flutter/cupertino.dart';
import"package:flutter/material.dart";
//import 'package:groceries_app/fruits.dart';
import 'package:shopisoko/widgets/footer.dart';
import 'package:shopisoko/widgets/product_catalogue.dart';
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/services/subcategory_repository.dart';
import 'package:shopisoko/widgets/product_catalogue_sub.dart';
import 'package:shopisoko/widgets/cart_component.dart';
import 'package:shopisoko/services/category_repository.dart';

class Subcategories extends StatefulWidget{
  String category_id;

  Subcategories({Key key,@required this.category_id}) :super(key: key);
  _SubcategoriesState createState() => _SubcategoriesState(this.category_id);


}

class _SubcategoriesState extends State<Subcategories> {
  String category_id;
  SubCategoriesRepository subCategoriesRepository=new SubCategoriesRepository();
  CategoriesRepository categories_repository=new CategoriesRepository();
  Future<List<SubCategories>> future_subcategories;
  List<Categories> userCategories;

   _SubcategoriesState(this.category_id);


   @override
   void initState() {

    super.initState();
  }
   @override
  Widget build(BuildContext context){
     future_subcategories=this.getSubCategoriesById(int.parse(category_id));
     print('The category id is ' + category_id.toString());
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
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CartDetails()));
              },
              icon:Icon(Icons.shopping_cart,size: 30,)),*/
         // cartComponent(),
          CartComponent(),
          Icon(Icons.more_vert,size: 30)
        ],
        iconTheme: IconThemeData(
            color: Color.fromRGBO(0,0,139,1)
        ),
      ),

      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: FutureBuilder(
            future: future_subcategories,
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                List<SubCategories> userSubCategories=snapshot.data;
                return  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
                          child:  Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1/3,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),

                            decoration:  BoxDecoration(
                           //   color: Colors.white,
                               image: DecorationImage(
                                 image: NetworkImage(userCategories.elementAt(0).image)
                               )
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),

                                    child: Container(
                                        height: MediaQuery.of(context).size.height * 1/6,
                                        width: MediaQuery.of(context).size.width,

                                        color: Colors.grey,
                                        child: GestureDetector(
                                            onTap: (){
                                              //    Navigator.push(context,MaterialPageRoute(builder: (context)=>Product_catalogue1()));

                                            },
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: userSubCategories.length,
                                                itemBuilder: (context,index){
                                                  return Container(
                                                    height: 100,
                                                    width: 150,
                                                    color:Colors.transparent,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                                                      child: Container(
                                                        margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                                                        width: 30,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          /*boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.9),
                                                        spreadRadius: 10,
                                                        blurRadius: 5,
                                                        offset: Offset(0, 6), // changes position of shadow
                                                      ),
                                                      //hello
                                                    ],*/
                                                          //  borderRadius: BorderRadius.all(Radius.circular(14)),
                                                            color: Colors.grey.shade300,
                                                            image: DecorationImage(
                                                                image: NetworkImage(userSubCategories.elementAt(index).image))),
                                                        child: Center(
                                                            child:    Container(
                                                              width: 100,
                                                              height: 50,
                                                              margin: const EdgeInsets.all(15.0),
                                                              padding: const EdgeInsets.all(3.0),
                                                              decoration: BoxDecoration(
                                                                color: Colors.black.withOpacity(0.3),
                                                                //             border: Border.all(color: Colors.grey)
                                                              ),
                                                              child: Center(
                                                                child: Text(userSubCategories.elementAt(index).subcategory,style: TextStyle(
                                                                    color: Colors.white),),
                                                              ),
                                                            )
                                                        ),
                                                      ),
                                                    ),


                                                  );
                                                  /* return Column(
                                              mainAxisAlignment: MainAxisAlignment.end,

                                              children: [




                                              ],
                                            );*/




                                                }
                                            )
                                        )
                                    )


                                ),


                              ],
                            ),



                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                            child: Column(
                              children: userSubCategories.map((sub){
                                return ProductCatalogueSub(product_header: sub.subcategory,
                                  product_detail: 'View all',sub_category_search: sub.id.toString(),);
                              }).toList(),
                            )
                        ),
                        Footer(),
                        /* ProductCatalogue(product_header: "title",product_detail:"",category_search: '',),
              ProductCatalogue(product_header: "title",product_detail: "",category_search: '',),
              ProductCatalogue(product_header: "title",product_detail: "",category_search: '',),*/

                      ],

                    )
                );
              }
              else if(snapshot.connectionState==ConnectionState.waiting){
                return Container();
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
    );


  }

  Future<List<SubCategories>> getSubCategoriesById(int category_id) async{
    List<SubCategories> user_subcategories= await subCategoriesRepository.getSubCategoriesById(category_id.toString()).then((value) async{
      userCategories= await getCategory(value.elementAt(0).cat_id);
      return value;
    });
    return user_subcategories;
  }

  Future<List<Categories>> getCategory(int categoryId) async{
    List<Categories> categories= await categories_repository.getCategoryById(categoryId.toString());
    return categories;
  }

}
