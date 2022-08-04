import 'package:crudusers/src/configs/appConfig.dart';
import 'package:crudusers/src/models/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Dio _dio = Dio();
  RxList<User> users = <User>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getListUserData();
    super.onInit();
  }

  Future getListUserData() async {
    try {
      isLoading.value = true;
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        List result = response.data;
        users.value = result.map((e) => User.fromJson(e)).toList();
      }
      return users;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future addNewUser(String name, String avatar, String birthdate, String phone,
      String address) async {
    try {
      isLoading.value = true;
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
    } finally {
      isLoading.value = false;
    }
  }

  Future updateUser(String id, String name, String birthdate, String phone,
      String address) async {
    try {
      isLoading.value = true;
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
    } finally {
      isLoading.value = false;
    }
  }

  deleteUser(String id) async {
    try {
      isLoading.value = true;
      final response = await _dio.delete('$baseUrl/$id');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
