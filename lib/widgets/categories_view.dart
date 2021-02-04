import 'package:flutter/material.dart';
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/pages/product_details.dart';
import 'package:shopisoko/services/subcategory_repository.dart';
import 'package:shopisoko/pages/categories_expanded_view.dart';


import 'dart:collection';

import 'package:shopisoko/widgets/sub_categories.dart';

class CategoriesView extends StatelessWidget{
  List<Categories> userCategories;
  String category_search;
  Future<List<Categories>> usercategories;
  SubCategoriesRepository subcategoryrepository=new  SubCategoriesRepository();

  CategoriesView({Key key,@required this.userCategories}):super(key:key);
  List<Color> list_colors=[ Colors.orangeAccent.withOpacity(0.2), Colors.yellow.withOpacity(0.2),
    Colors.deepOrange.withOpacity(0.2), Colors.greenAccent.withOpacity(0.2)];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1/2,
        child:  GridView.builder(
    scrollDirection: Axis.vertical,
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 300,
    childAspectRatio: 4/4,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10
           ),
           itemCount: userCategories.length,
           itemBuilder: (context,index){
           return GestureDetector(
             onTap: (){

               if(userCategories.isNotEmpty){
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>Subcategories( category_id: userCategories.elementAt(index).id,)));

               }

             },
             child: Container(
               padding: const EdgeInsets.all(0),
               child: Padding(
                 padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisSize: MainAxisSize.max,
                   children: [
                     Padding(
                       padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                       child: Text(userCategories.elementAt(index).name,style: TextStyle(fontWeight: FontWeight.w900,
                           fontSize: 18,color: Colors.black87,fontFamily: 'Open Sans'),),
                     ),
                     Align(
                         alignment: Alignment.bottomRight,
                         child:Padding(
                           padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                           child: Container(
                             width: 100,
                             height: 100,
                             decoration: BoxDecoration(
                                 image: DecorationImage(
                                     fit: BoxFit.contain,
                                     image: NetworkImage(userCategories.elementAt(index).image)
                                   //image: AssetImage('assets/images/fruits.png')
                                 )
                             ),
                           ),
                         )
                     )
                   ],
                 ),
               ),
               color: Colors.orangeAccent.withOpacity(0.2),

             ),
           );
           }

        ),

      ),
    );
  }

}