void main() {
  print('Hello World!');
  print("Hello Flutter");

  // DataTypes => String , int , double , bool
  // DataType variableName = value ;

  String firstName = "Amir";
  String lastName = 'Mohammed';
  int age = 20;
  double number = 1.6;
  bool working = true;

  var num1 = 1;
  num1 = 2;

  final num2 = 2;
  const num3 = 3;

  dynamic num4 = 4;
  num4 = "";

  print(firstName);
  print(lastName);

  // files , packages ( folders ) => small_letters_with_under_scores
  // class => ClassName
  // functions , variables => camelCase => getUserData();
  // naming => chars , $ , _
  var test = "";
  var $test = "";
  var _test = "";

  // getUserData

  // + - / * %
  // < > <= >=
  // == !=
  // && || !
  // ++ --
  // += -= /= *= %=
  // ? :
  // is is!
  // in
  // ! ?? ??=

  print(10 == 10);
  print(10 != 5);
  print("Flutter" == "Flutter");
  print("ali" == "Ali");

  int num = 10;
  num++;
  num--;
  num = num + 5;
  num += 5;
  num *= 5;
  num %= 5;

  num = 1;
  print(++num);
  print(num++);

  print(num is String);
  print(num is int);
  print(num is! double);

  // condition  ? true : false
  String data = "123456789";
  String ui = data.isEmpty ? "No data found!" : "Results";
  print(ui);

  // String status = "Accept";
  // Color textColor = status == "Accept" ? Colors.green : Colors.red;

  // Conditions
  // if , switch

  // if ( condition ) { true body } else { false body }

  print('--------------------');

  if (10 < 5) {
    print('True Body');
  } else {
    print('False body');
  }
  print('--------------------');

  // REQUESTED , ACCEPTED , REJECTED , ON_THE_WAY , REFUSED , FINISHED
  String orderStatus = "FINISHED";

  // if ( condition ) { true body } else if ( condition ) { true body } else { false body }

  if (orderStatus == "REQUESTED") {
    print('Case 1');
  } else if (orderStatus == "ACCEPTED") {
    print('Case 2');
  } else if (orderStatus == "ON_THE_WAY") {
    print('Case 3');
  } else if (orderStatus == "FINISHED") {
    print('Case 4');
  } else {
    print('Unknown Case');
  }

  String rate = "4.5";

  if (orderStatus == "FINISHED" && rate.isEmpty) {
    print('Show Rate Button');
  } else {
    print('Hide Rate Button');
  }

  if (orderStatus == "REJECTED" || orderStatus == "REFUSED") {
    print('Show RED Color');
  } else {
    print('Hide RED Color');
  }

  var x = !false;
  print(x);

  switch (orderStatus) {
    case "REQUESTED":
      {
        print('Case 1');
      }
      break;
    case "ACCEPTED":
      {
        print('Case 2');
      }
      break;
    case "ON_THE_WAY":
      {
        print('Case 3');
      }
      break;
    case "FINISHED":
      {
        print('Case 4');
      }
      break;
    default:
      {
        print('');
      }
  }
  print('--------------------');

  // for ( int i = 0 ; i < 10 ; i++ ) { body }
  for (int i = 0; i < 10; i++) {
    if (i == 7) {
      break;
    }
    print(i);
    if (i == 5) {
      continue;
    }
    print(i);
  }
  print('--------------------');

  int i = 0;
  while (i > 10) {
    print(i);
    i++;
  }
  print('--------------------');

  int z = 0;
  do {
    print(z);
    z++;
  } while (z > 10);

  // Array , List
  //             0         1          2       3
  var names = ["Amir", "Ahmed", "Mohammed", "Ali"];
  List<String> groupTwoNames = ["Hamdy", "Hussein", "Osama", "Aziz"];

  names.add("Moaz");
  names.add("Salah");
  names.addAll(groupTwoNames);

  print(names);

  // for(String name in names){}
  // for(var name in names){}

  for (String name in names) {
    print("Mr . $name");
  }

  var $name = "Salah";
  print('Name : ${$name}');

  print("Name : ${names[3]}");

  print("Name : ${names.getRange(0, 2)}");

  print(names.isEmpty);
  print(names.isNotEmpty);
  // names.clear();
  print(names.length);
  print(names.first);
  print(names.last);
  // print(names.single);
  print(names.contains("Ali"));

  print(names[0]);
  names[0] = "Shawky";
  print(names[0]);

  // remove => 5 ways
  // names.removeAt(2);
  // print(names);
  //
  // names.removeLast();
  // print(names);
  //
  // names.removeRange(4, 6);
  // print(names);

  names.add("Salah");
  print(names);

  // names.remove("Salah");
  names.removeWhere((element) => element == "Salah");

  names.removeWhere((element) {
    return element == "Salah";
  });

  for (int i = 0; i < names.length; i++) {
    if (names[i] == "Salah") {
      names.removeAt(i);
    }
  }

  for (var name in names) {
    if (name == "Salah") {
      names.remove(name);
    }
  }

  print(names);
  print('-----------------------');
  // Strings

  String welcome = "Welcome to flutter course";
  print(welcome.length);
  print(welcome.isEmpty);
  print(welcome.isNotEmpty);
  print(welcome.toLowerCase());
  print(welcome.toUpperCase());
  print(welcome.substring(8, 10));
  print(welcome.substring(19, 25));
  print(welcome.substring(19));

  // iPhone Iphone
  print('iPhone'.toLowerCase() == "Iphone".toLowerCase());

  print(welcome.contains("flutter"));

  // trim , trimRight , trimLeft
  String email = " amir@ gmail .com ";
  print(email.length);
  // email = email.trim();
  print(email.length);

  email = email.replaceAll(" ", "");
  print(email.length);

  // 01116036002
  // 0111 6036 002
  // +201116036002
  // +20111 6036 002
  //  00201116036002
  //  0020111 6036 002
  //  0020111-6036-002
  //  +20111-6036-002
  String phoneNumber = "+20111-6036-002";
  phoneNumber = phoneNumber.replaceAll(" ", "").replaceAll("-", "");
  if (phoneNumber.startsWith("00")) {
    phoneNumber = phoneNumber.replaceFirst("00", "+");
  } else if (!phoneNumber.startsWith("+"))
  {
    phoneNumber = "+2$phoneNumber";
  }

  print(phoneNumber);
}
