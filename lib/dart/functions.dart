void main() {
  

  var fun = Functions();
  fun.printMyName();
  var myName = fun.getMyName();
  print(myName);
  print(fun.getMyName());
  fun.welcome("Ali");
  print(fun.welcome2("Mohsen"));

  // To show function parameters => ctrl + p
  fun.printUserName("Ali");
  fun.printUserName2("Saied");
  fun.printUserName2("Amir", "Mohammed");

  fun.printUserName4(firstName: "Mahmoud");
  fun.printUserName5();
  fun.printUserName5(name: "Mohammed");
  fun.printUserName6(firstName: "Amir");
  fun.printUserName6(firstName: "Amir", lastName: "Mohammed");
}

class Functions {
  // void functionName( parameters => variables ){ function body }
  // DataType functionName( parameters => variables ){ function body }

  void printMyName() {
    print('Amir');
  }

  String getMyName() {
    return "Amir";
  }

  void welcome(String name) {
    print('Welcome Mr . $name');
  }

  String welcome2(String name) {
    return 'Welcome Mr . $name';
  }

// Default Parameters => required , optional
// Named   Parameters => required , optional

  void printUserName(String firstName) {
    print('Welcome Mr . $firstName');
  }

  void printUserNameArrow(String firstName) => print('Welcome Mr . $firstName');

  void printUserName2(String firstName, [String lastName = ""]) {
    print('Welcome Mr . $firstName $lastName');
  }

  void printUserName2Arrow(String firstName, [String lastName = ""]) =>
      print('Welcome Mr . $firstName $lastName');

  void printUserName3([String name = ""]) {
    print('Welcome Mr . $name');
  }

  void printUserName3Arrow([String name = ""]) => print('Welcome Mr . $name');

  void printUserName4({required String firstName}) {
    print('Welcome Mr . $firstName');
  }

  void printUserName5({String name = ""}) {
    print('Welcome Mr . $name');
  }

  void printUserName6({required String firstName, String lastName = ""}) {
    print('Welcome Mr . $firstName $lastName');
  }

}
