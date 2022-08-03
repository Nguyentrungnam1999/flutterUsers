import 'package:crudusers/src/configs/appConfig.dart';
import 'package:crudusers/src/models/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Dio _dio = Dio();
  RxList<User> users = <User>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   getListUserData();
  // }

  Future getListUserData() async {
    try {
      final response = await _dio.get(baseUrl);
      List result = response.data;
      final List<User> userData = result.map((e) => User.fromJson(e)).toList();

      if (response.statusCode == 200) {
        users.addAll(userData);
      }
      print(users);
    } catch (e) {
      return e.toString();
    }
  }

  Future addNewUser(String name, String avatar, String birthdate, String phone,
      String address) async {
    try {
      final response = await _dio.post(baseUrl, data: {
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

  Future updateUser(String id, String name, String birthdate, String phone,
      String address) async {
    try {
      final response = await _dio.put('$baseUrl/$id', data: {
        'name': name,
        'birthdate': birthdate,
        'phone': phone,
        'address': address,
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

  deleteUser(String id) async {
    try {
      final response = await _dio.delete('$baseUrl/$id');
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
