import 'package:flutter24/dart/inheritance/base_screen.dart';
import 'package:flutter24/dart/inheritance/screen_one.dart';

void main(){

  var object = ScreenOne("ScreenOne");

  object.startLoading();

  // var o = BaseScreen(); // Abstract classes can't be instantiated.

}