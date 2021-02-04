import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/models/domain_server.dart';

class CategoriesRepository{
  final String url_fetch_categories="${DomainServer.name}shopisoko/categoriesfetch.php";
  final String url_fetch_categories_by_id="${DomainServer.name}shopisoko/categoriesById.php";
  final String url_fetch_category_by_id="${DomainServer.name}shopisoko/fetchCategoryById.php";
  CategoriesRepository(){

  }

  Future<List<Categories>> getCategories() async{
    final http.Response response =
    await http.get(url_fetch_categories, headers: {"Accept": "application/json"});

    var categories = jsonDecode(response.body);
    var list_categories = categories["categories"] as List;
    List<Categories> user_categories =
    list_categories.map<Categories>((json) => Categories.fromJson(json)).toList();
    return user_categories;
  }

  Future<List<Categories>> getCategoriesById(String id) async{
    final http.Response response=await http.post(
        url_fetch_categories_by_id,headers: {"Accept":"application/json"},
        body: {"id": id}
    );

    var categories=jsonDecode(response.body);
    var list_categories=categories["categories"] as List;
    List<Categories> user_categories=list_categories.map<Categories>((json) => Categories.fromJson(json)).toList();
    return user_categories;
  }

  Future<List<Categories>> getCategoryById(String id) async{
    final http.Response response=await http.post(
        url_fetch_category_by_id,headers: {"Accept":"application/json"},
        body: {"id": id}
    );

    var categories=jsonDecode(response.body);
    var list_categories=categories["categories"] as List;
    List<Categories> user_categories=list_categories.map<Categories>((json) => Categories.fromJson(json)).toList();
    return user_categories;
  }


}