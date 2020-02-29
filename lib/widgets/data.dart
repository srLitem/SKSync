import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier{
  final List<String> _ids = [];

  List<String> get schools => _ids;

  void addSchoolID(String school){
    debugPrint('Adding the value $school');
    _ids.add(school);
    //_ids.forEach((fruit) => print(fruit));
    debugPrint(_ids.toString());
    notifyListeners();
  }

  void removeSchoolID(String schoolID){
    debugPrint('Removing the value $schoolID');
    _ids.remove(schoolID);
    //_ids.forEach((fruit) => print(fruit));
    debugPrint(_ids.toString());
    notifyListeners();
  }
}