import 'package:flutter/cupertino.dart';

class BottomController extends ChangeNotifier {
  int currentIndex = 0;
  changer(int val) {
    currentIndex = val;
    notifyListeners();
  }
}
