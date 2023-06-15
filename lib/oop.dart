// OOP => Class , Object
// Class  => Container ( variables, functions )
// Object => Copy of class

// class ClassName { body }
// DataTypes => String , int , double , bool
// DataType variableName = value ;
// DataType functionName( parameters => variables ){ body }
// void functionName( parameters => variables ){ body }
// Object define
// ClassName objectName = ClassName();
// var objectName = ClassName();
// final objectName = ClassName();
// const objectName = ClassName();

void main() {
  // To show parameters => ctrl + p
  User user1 = User(1,"Ahmed","0125337627", "Cairo");

  User user2 = User(2,"Ali", "0105467798", "Alex");
}

class User {
  int id = 0;
  String name = "";
  String phone = "";
  String city = "";

  User(this.id, this.name, this.phone, this.city){
    print('New Object');
    printUserData();
  }

  // Constructor => function
  // Constructor => optional body
  // Constructor => function naming = ClassName
  // Constructor => function has no return type
  // Constructor => function => call => create new object

  void printUserData() {
    print('User Id : $id');
    print('User Name : $name');
    print('User Phone : $phone');
    print('User City : $city');
  }
}
