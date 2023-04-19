import 'package:flutter/cupertino.dart';

class User1 extends ChangeNotifier {

  String name;
  String email;
  String phone;

  // Constructor
  User1({

    required this.name,
    required this.email,
    required this.phone,

  });
  void updateAccount(input) {
    User1 user;
    user = input;
    notifyListeners();
  }
  User1 copy({

    String? name,
    String? phone,
    String? email,

  }) =>
      User1(

        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,

      );

  static User1 fromJson(Map<String, dynamic> json) => User1(

        name: json['name'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {

        'name': name,
        'email': email,
        'phone': phone,
      };
}
