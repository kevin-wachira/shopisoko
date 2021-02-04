import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopisoko/services/category_repository.dart';
import 'package:provider/provider.dart';
import 'package:shopisoko/pages/home_page_carousel.dart';
import 'app_utils/app_utils.dart';
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/services/brands_repository.dart';
import 'package:shopisoko/pages/categories_expanded_view.dart';
import 'pages/pages.dart';
import 'package:shopisoko/widgets/sub_categories.dart';
import 'package:shopisoko/widgets/product_catalogue.dart';
import 'package:shopisoko/pages/cart_details.dart';
import 'package:shopisoko/widgets/footer.dart';
import 'package:shopisoko/widgets/categories_view.dart';
import 'package:shopisoko/widgets/drawers/home_drawer.dart';
import 'package:shopisoko/widgets/custom_carousels.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopisoko/pages/search_page.dart';

void main() {
  runApp(
    MyApp(),
    // PushMessagingExample()
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: AppState(),),
      ChangeNotifierProvider(create: (_)=> Cart(cart_id: 0,cart_size: 0,total_amount: 0,cart_items_data: []),),
      ChangeNotifierProvider(create: (_)=>Orders.setup(bill_no: '',customer_name: '',customer_address: '',
          customer_phone: '',gross_amount: '',service_charge:'',vat_charge_rate:'16%',net_amount: '',discount: '0%',type: '',invoice_no: '',
          receipt_no: '',paid_status: '1',user_id: '1')),
      ChangeNotifierProvider(create: (_)=>User.setup(username: '',credit: '',fname: '',lname: '',phone: '',
          location: '',email: '',logged: '')),
      ChangeNotifierProvider(create: (_)=>Search(search: '')),
    ],
    child: MaterialApp(
        title: 'Shopi Soko',
        theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage()),);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Brand>> future_brands;
  Future<List<Categories>> future_categories;
  List<Categories> initial_categories=[];
  BrandsRepository brandsRepository=new BrandsRepository();
  CategoriesRepository categoriesRepository=new CategoriesRepository();
  SharedPreferences pref;
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  @override
  void initState() {

    super.initState();
    getBrands();
    future_categories=this.getCategories();
   // future_brands=brandsRepository.getBrands();
  }

  Future<void> setUserPreferences() async{
    pref=await _prefs;
    if(!pref.containsKey('username')){
      pref.setString('username','');
      pref.setString('email','');
      pref.setString('phone','');

    }
    else if(pref.containsKey('username')){
      if(pref.getString('username').isNotEmpty){
        Provider.of<User>(context,listen: false).username=pref.getString('username');
        Provider.of<User>(context,listen: false).email=pref.getString('email');
        Provider.of<User>(context,listen:false).phone=pref.getString('phone');
      }
    }

    if(!pref.containsKey('address')){
      pref.setString('address','');
      pref.setString('amount', '');
    }
    else if(pref.containsKey('address')){
      Provider.of<Orders>(context,listen: false).customer_address=pref.getString('address');
      Provider.of<Orders>(context,listen: false).service_charge=pref.getString('amount');
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future_brands,
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.done && snapshot.hasData && Provider.of<Search>(context).search_state==0){
          List<Brand> userBrands=snapshot.data;
          print('The brands are ' + userBrands.elementAt(0).brand);
          return homePageCarousel1(userBrands);
        }

        else if(Provider.of<Search>(context).search_state==2){
          return Subcategories(category_id:Provider.of<Search>(context).search_category);
        }
        else if(snapshot.hasError){
          return Material(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Center(
                  child: Text('Error loading Product items',style: TextStyle(color: Color.fromRGBO(0,0,139,1),
                  fontWeight: FontWeight.w600,fontSize: 14),)
                )
            ),
          );
        }

        else if(snapshot.connectionState==ConnectionState.waiting){
          return Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                child:  CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(0,0,139,1)),
                ),
              )
            ),
          );
        }

        else{
          print('Search value is ' + Provider.of<Search>(context).search_state.toString());
          return Container();
        }
      },
    );

  }

  Widget homePageCarousel1(List<Brand> userBrands){
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

          IconButton(icon:Icon(Icons.search, size: 30,),
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> SearchPage()));
          },),

          /*IconButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CartDetails()));
              },
              icon:Icon(Icons.shopping_cart,size: 30,)),*/
          cartComponent(),

          Icon(Icons.more_vert,size: 30)
        ],
        iconTheme: IconThemeData(
            color: Color.fromRGBO(0,0,139,1)
        ),
      ),

      drawer: HomeDrawer(brands: userBrands,),
      //.  backgroundColor: Colors.white,
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column( children: <Widget>[
            CustomCarousels(),
            Padding(padding: const EdgeInsets.only(left: 20.0, right: 20.0),),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).orientation==Orientation.portrait ?
              MediaQuery.of(context).size.height * 6/11 :
              MediaQuery.of(context).size.width * 6/11,
              child: ProductCatalogue(product_header:'Our Products',product_detail: '',category_search: '',),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),

              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories"),

                  InkWell(
                    onTap: () {

                    }
                    ,
                    child:FlatButton(
                      onPressed: () {
                        //    Navigator.push(context,MaterialPageRoute(builder: (context)=>Fruits()));
                      },

                    ),
                  ),
                ],
              ),
            ),
            CategoriesView(userCategories: initial_categories,),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).orientation==Orientation.portrait ?
              MediaQuery.of(context).size.height * 6/11 :
              MediaQuery.of(context).size.width * 6/11,
              child: ProductCatalogue(product_header:'Our Products',product_detail: 'View all',category_search: '',),
            ),

            CategoriesView(userCategories: initial_categories,),
            FutureBuilder(
                future: future_categories,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                  List<Categories>  new_categories=snapshot.data;
                  print('The first item is ' + new_categories.elementAt(0).id);
                    return  Column(
                        children: new_categories.map((category){
                         return Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).orientation==Orientation.portrait ?
                            MediaQuery.of(context).size.height * 6/11 :
                            MediaQuery.of(context).size.width * 6/11,
                            child: ProductCatalogue(product_header:category.name,product_detail:'View all',
                            category_search: category.id,),
                          );
                        }).toList()
                    );
                  }
                  else if(snapshot.hasError){
                    return Container(
                      child: Text('Error found' + snapshot.error.toString()),
                    );
                  }

                  else{
                    return Container();
                  }
                }),



            Container(
                width: 600,
                //   height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //       color: Colors.grey,

                child: Footer()
            ),


          ],),



        ),
      ),

    );
  }

  Future<List<Brand>> getBrands() async{
  //  Provider.of<Search>(context).search_state=1;
    future_brands=brandsRepository.getBrands().then((value) async{
      initial_categories=await getCategories();
      return value;
    });

    return future_brands;
  }

  Future<List<Categories>> getCategories() async{
   // Future<List<Categories>> user_categories=categoriesRepository.getCategories();
    Future<List<Categories>> user_categories=categoriesRepository.getCategories();
    return user_categories;
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
  }
}

