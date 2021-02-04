import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shopisoko/models/models.dart';
import 'package:shopisoko/models/domain_server.dart';

class BrandsRepository{
  final String url_fetch_brands="${DomainServer.name}shopisoko/fetchall.php";
  final String url_fetch_brands_by_id="${DomainServer.name}shopisoko/fetch_brands_by_id.php";
  BrandsRepository(){

  }

  Future<List<Brand>> getBrands() async{
    final http.Response response =
    await http.get(url_fetch_brands, headers: {"Accept": "application/json"});

    var brands = jsonDecode(response.body);
    var list_brands = brands["brands"] as List;
    List<Brand> user_brands =
    list_brands.map<Brand>((json) => Brand.fromJson(json)).toList();
    return user_brands;
  }

  Future<List<Brand>> getBrandsById(String id) async{
    final http.Response response=await http.post(
        url_fetch_brands_by_id,headers: {"Accept":"application/json"},
        body: {"id": id}
    );

    var brands=jsonDecode(response.body);
    var list_brands=brands["brands"] as List;
    List<Brand> user_brands=list_brands.map<Brand>((json) => Brand.fromJson(json)).toList();
    return user_brands;
  }


}