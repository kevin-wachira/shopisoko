import 'package:flutter/foundation.dart';

class Search with ChangeNotifier{
  String search='';
  int search_state=0;
  String search_category='';

  Search({this.search});

  setValue(String search){
    this.search=search;
    notifyListeners();
  }

  setSearchState(int search_state){
    this.search_state=search_state;
    notifyListeners();
  }
}