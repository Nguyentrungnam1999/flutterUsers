import 'dart:convert';

import 'package:crudusers/person.dart';
import 'package:http/http.dart' as http;

class ResponsitoryPerson {
  String uri = 'https://62e0a43c98dd9c9df6150956.mockapi.io/api/v1/uers';

  Future getData() async {
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var it = jsonDecode(response.body) as List;
      List<Person> persons = it.map((e) => Person.fromJson(e)).toList();
      return persons;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future createPerson(String name, String avatar) async {
    try {
      final response = await http.post(Uri.parse(uri), body: {
        'name': name,
        'avatar': avatar,
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
