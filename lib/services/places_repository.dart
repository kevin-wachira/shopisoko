import 'dart:async';
import 'dart:convert';
import 'package:shopisoko/models/place.dart';
import 'package:shopisoko/models/api.dart';
import 'package:dio/dio.dart';
class PlacesRepository{

  PlacesRepository();

  getPlaces(String query) async {
    List<Place> listPlace=[];
    String url2 =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${Config.apiKey}&input=${Uri.encodeQueryComponent(query)}";
    Response response = await Dio().get(url2);
    listPlace = Place.parseLocationList(response.data);
    return listPlace;
  }
}