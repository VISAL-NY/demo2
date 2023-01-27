import 'package:flutter/foundation.dart';

class GetValue extends ChangeNotifier{
  int value=0;
  int get getValue=>value;
  void setValue(int value){
    this.value=value;
    notifyListeners();
  }

}