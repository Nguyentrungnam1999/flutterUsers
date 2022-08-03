import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String name;
  final String? avatar;
  final String? birthdate;
  final String? address;
  final String? phone;
  User({
    required this.id,
    required this.name,
    this.avatar,
    this.birthdate,
    this.address,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      birthdate: json['birthdate'],
      address: json['address'],
      phone: json['phone'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'phone': phone,
        'address': address,
        'birthdate': birthdate,
      };
}

List<User> avangerFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String avangerToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
