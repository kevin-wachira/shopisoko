import 'package:flutter/material.dart';
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/services/product_repository.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget{
  SearchPage({Key key}):super(key:key);

  @override
  SearchPageState createState()=> SearchPageState();
}

class SearchPageState extends State<SearchPage>{
TextEditingController searchController=new TextEditingController();
ProductRepository productRepository=new ProductRepository();
List<Product> _searchResult = [];
String search_name = "%";
bool searchPanelClosed = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child:  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 1 / 8,
                    vertical: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  height: 40,
                  child: TextField(
                    style: TextStyle(fontSize: 14.0),
                    autofocus: true,
                    controller: searchController,
                    onChanged: (text) {
                      if (text.length > 0) {
                        setState(() {
                          searchPanelClosed = false;
                          search_name = text + "%";
                          print('The text is ' + search_name);
                          this.fetchProductsLikeName(text + "%");
                          print('The search list is  ' +
                              _searchResult.length.toString());
                          print('And the searchPanelClosed is ' +
                              searchPanelClosed.toString());
                        });
                      } else if (text.length == 0) {
                        setState(() {
                          searchPanelClosed = true;
                          search_name = "";
                          Provider.of<Search>(context,listen: false).search='';
                          // future_product = this.getProducts();
                          _searchResult = [];
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 0.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.deepPurple,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple,),
                          borderRadius: BorderRadius.circular(20.0)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                )),
            _searchResult.length > 0 && searchPanelClosed == false
                ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 1 / 8,
                  vertical: 0.0),
              child: Stack(
                children: [
                  new SizedBox(
                    height: 200,
                    width: (MediaQuery.of(context).orientation) ==
                        Orientation.portrait
                        ? (MediaQuery.of(context).size.width) * 3 / 4
                        : (MediaQuery.of(context).size.width) * 3 / 5,
                    child: _searchResult.length != 0
                        ? new ListView.builder(
                        itemCount: _searchResult.length,
                        itemBuilder: (context, i) {
                          return new Card(
                            child: new ListTile(
                              leading: new Icon(
                                Icons.shopping_bag,

                                color: Colors.deepPurple,
                                size: 24,
                              ),
                              title:
                              new Text(_searchResult[i].name),
                              subtitle: new Text(
                                'Ksh ' + _searchResult[i].price,
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Open Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () {
                                setState(() {
                                  searchPanelClosed = true;
                                  searchController.text = _searchResult[i].name;
                                  search_name = searchController.text;
                                  Provider.of<Search>(context,listen: false).search=searchController.text;

                                  //   this.fetchProductsLikeName(search_name);
                                });

                                Navigator.pop(context);
                                //   updateProductUi(i);
                              },
                            ),
                            margin: const EdgeInsets.all(0.0),
                          );
                        })
                        : new Card(),
                  )
                ],
              ),
            )
                : SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }

Future<List<Product>> fetchProductsLikeName(String name) async {
  print('The search String is ' + name);
  _searchResult = await this.productRepository.getProductsLikeName(name);
  print('The length of search result is ' + _searchResult.length.toString());
  return _searchResult;
}

}