import 'dart:convert';

import 'package:crudusers/connectHttp/person.dart';
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

  Future createPerson(String name, String avatar, String birthdate,
      String phone, String address) async {
    try {
      final response = await http.post(Uri.parse(uri), body: {
        'name': name,
        'avatar': avatar,
        'birthdate': birthdate,
        'phone': phone,
        'address': address,
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

  Future updatePerson(String id, String name, String birthdate, String address,
      String phone) async {
    try {
      final response = await http.put(Uri.parse('$uri/$id'), body: {
        'name': name,
        'birthdate': birthdate,
        'address': address,
        'phone': phone,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future deletePerson(String id) async {
    try {
      final response = await http.delete(Uri.parse('$uri/$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
