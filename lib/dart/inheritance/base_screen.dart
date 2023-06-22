// Abstraction => class , function

// Abstract class => no object , to inherit
//  contain abstract function

// abstract function => no body
abstract class BaseScreen{

  final String _screenName;

  BaseScreen(this._screenName){
    print('Current Screen => $_screenName');
  }

  void printData();

  void startLoading(){
    print('circle loading');
  }

  void stopLoading(){

  }

  void _showSuccess(){}

  void _showError(){}


}