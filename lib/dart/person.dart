// To define variable in class
// => ? null , late , initial value = "" , constructor

// Global variable => define in class body
// Local variable  => define in function body or parameters

// Encapsulation => private variables , public functions

// public variable => private variable => _

class Person {
  int _id = 0;
  String _name = "";
  String _phone = "";
  String _age = "";
  String _dateTime = "2023-06-19 6:53";

  Person(this._id, this._name, this._phone, this._age);

  Person.one(this._id, this._name);

  Person.name(this._id, this._name);

  Person.me(this._id, this._name);

  Person.you(this._id, this._name);

  String getDate() {
    return _dateTime.split(" ")[0]; // 2023-06-19
  }

  String getTime() {
    return _dateTime.split(" ")[1]; // 6:53
  }

  String getName() {
    return "Mr . $_name";
  }

  void setName(String name) {
    if (name.length < 2) {
      print('Invalid name');
      return;
    }
    _name = name;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
