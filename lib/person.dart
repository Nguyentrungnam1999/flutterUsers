class Person {
  final String id;
  final String name;
  final String? avatar;
  final String? birthdate;
  final String? address;

  const Person({
    required this.id,
    required this.name,
    required this.avatar,
    required this.birthdate,
    required this.address,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      birthdate: json['birthdate'],
      address: json['address'],
    );
  }
}
