/// status : true
/// message : null
/// data : {"id":58593,"name":"HTI","email":"hti3@gmail.com","phone":"01221472648","image":"https://student.valuxapps.com/storage/assets/defaults/user.jpg","points":0,"credit":0,"token":"0GJfPxqbQSyh78sr7ZGK2KwPp4HOm9VK5hVDh55iQYptWs5WYAgOHXXdjSnt1c1qpU9caf"}

class ProfileResponse {
  ProfileResponse({
    bool? status,
    String? message,
    ProfileData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  ProfileData? _data;

  bool? get status => _status ?? false;

  String get message => _message ?? '';

  ProfileData get data => _data ?? ProfileData();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : 58593
/// name : "HTI"
/// email : "hti3@gmail.com"
/// phone : "01221472648"
/// image : "https://student.valuxapps.com/storage/assets/defaults/user.jpg"
/// points : 0
/// credit : 0
/// token : "0GJfPxqbQSyh78sr7ZGK2KwPp4HOm9VK5hVDh55iQYptWs5WYAgOHXXdjSnt1c1qpU9caf"

class ProfileData {
  ProfileData({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    num? points,
    num? credit,
    String? token,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _image = image;
    _points = points;
    _credit = credit;
    _token = token;
  }

  ProfileData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _points = json['points'];
    _credit = json['credit'];
    _token = json['token'];
  }

  num? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  num? _points;
  num? _credit;
  String? _token;

  num get id => _id ?? 0;

  String get name => _name ?? '';

  String get email => _email ?? '';

  String get phone => _phone ?? '';

  String get image => _image ?? '';

  num get points => _points ?? 0;

  num get credit => _credit ?? 0;

  String get token => _token ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['points'] = _points;
    map['credit'] = _credit;
    map['token'] = _token;
    return map;
  }
}
