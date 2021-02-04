import 'package:flutter/material.dart';
import 'package:shopisoko/app_utils/app_utils.dart';
import 'package:shopisoko/services/subcategory_repository.dart';
import 'package:shopisoko/widgets/stanleywidgets/flatmenu_btn.dart';
import 'package:provider/provider.dart';
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/widgets/sub_categories.dart';

class HomeDrawer extends StatefulWidget {
  List<Brand> brands;
  HomeDrawer({Key key,@required this.brands}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState(brands);
}

class _HomeDrawerState extends State<HomeDrawer> {
  Duration duration = Duration(milliseconds: 700);
  List<Brand> brands;
  _HomeDrawerState(this.brands);
  List<Categories> userCategories;
  String category_search;
  Future<List<Categories>> usercategories;
  SubCategoriesRepository subcategoryrepository=new  SubCategoriesRepository();


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    TextStyle style = TextStyle(
        color: appState.dark ? Colors.white : Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold);
    Color color = appState.dark ? Colors.white : Colors.grey[500];
    final _sizedWidth = SizedBox(width: 10);
    return Drawer(
      child: AnimatedContainer(
          duration: duration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: DrawerHeader(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Icon(Icons.shop, color: Colors.white)))),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1/2,
                 // color: Colors.black54,
                  child: ListView.builder(
                    itemCount: brands.length,
                    itemBuilder: (context,index){
                      return ExpansionTile(
                          backgroundColor:
                          appState.dark ? Color(0xFF0b313b) : Colors.grey[100],
                          title: Row(children: [
                            Icon(
                              Icons.food_bank,
                              color: color,
                            ),
                            _sizedWidth,
                            Text(
                              brands.elementAt(index).brand,
                              style: style,
                            )
                          ]),

                          children: brands.elementAt(index).categories.map((x){
                            return FlatMenuBtn(x.name,(){
                             setState(() {
                               Provider.of<Search>(context,listen:false).search_category=x.id;
                               Provider.of<Search>(context,listen:false).search_state=2;
                               Navigator.push(context,MaterialPageRoute(builder: (context)=>Subcategories( category_id:x.id,)));

                             });

                            });
                          }).toList());
                    },

                  ),
                ),
              )
            ],
          )),
    );
  }

  setSearchParam(String id){
    setState(() {
      Provider.of<Search>(context,listen:false).search_category=id;
      Provider.of<Search>(context,listen:false).search_state=2;
    });
  }
}
