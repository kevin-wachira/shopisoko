import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/models/domain_server.dart';
import 'dart:convert';

class ProductRepository{
final String url_fetch_products="${DomainServer.name}shopisoko/productfetch.php";
final String url_fetch_products_by_category="${DomainServer.name}shopisoko/productsByCategory.php";
final String url_fetch_products_by_category_sub="${DomainServer.name}shopisoko/productsBySubCategory.php";
final String url_products_like_name="${DomainServer.name}shopisoko/product_like_name.php";
  ProductRepository(){

  }

  Future<List<Product>> getProducts() async{
    final http.Response response =
    await http.get(url_fetch_products, headers: {"Accept": "application/json"});

    var products = jsonDecode(response.body);
    var list_products = products["products"] as List;
    List<Product> user_products =
    list_products.map<Product>((json) => Product.fromJson(json)).toList();
    return user_products;
  }

  Future<List<Product>> getProductByName(String name) async{
    final http.Response response=await http.post(
      url_fetch_products,headers: {"Accept":"application/json"},
      body: {"name":name}
    );

    var products=jsonDecode(response.body);
    var list_products=products["products"] as List;
    List<Product> user_products=list_products.map<Product>((json) => Product.fromJson(json)).toList();
    return user_products;
  }

Future<List<Product>> getProductsLikeName(String name) async {
  print('The search String is ' + name);
  final http.Response response = await http.post(url_products_like_name,
      headers: {"Accept": "application/json"}, body: {'name': name});
  //  print(response.body);
  if (response.body.isNotEmpty) {
    var products = jsonDecode(response.body);
    var list_products = products["products"] as List;
    List<Product> user_products =
    list_products.map<Product>((json) => Product.fromJson(json)).toList();
    return user_products;
  } else {
    List<Product> user_product = [];
    return user_product;
  }
}
Future<List<Product>> getProductByCategory(int id) async{
  final http.Response response=await http.post(
      url_fetch_products_by_category,headers: {"Accept":"application/json"},
      body: {"id":id.toString()}
  );

  var products=jsonDecode(response.body);
  var list_products=products["products"] as List;
  List<Product> user_products=list_products.map<Product>((json) => Product.fromJson(json)).toList();
  return user_products;
}

Future<List<Product>> getProductByCategorySub(int id) async{
  final http.Response response=await http.post(
      url_fetch_products_by_category_sub,headers: {"Accept":"application/json"},
      body: {"sub_category_id":id.toString()}
  );

  var products=jsonDecode(response.body);
  var list_products=products["products"] as List;
  List<Product> user_products=list_products.map<Product>((json) => Product.fromJson(json)).toList();
  return user_products;
}




}