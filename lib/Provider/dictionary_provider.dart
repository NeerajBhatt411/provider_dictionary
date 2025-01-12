import 'package:dictionary_provider/API/api_services.dart';
import 'package:flutter/cupertino.dart';

class dictionaryProvider extends ChangeNotifier {
  bool isReady = false;
  List model = [];
  bool noDataFound = false;
  void getData(String word) {
    isReady = true;
    notifyListeners();
    ApiServices().getDictionary(word).then(
      (value) {
        model = value;
        isReady = false;
        notifyListeners();
      },
    ).catchError((error){
      noDataFound=true;
      isReady = false;
      notifyListeners();

    });
  }
}
