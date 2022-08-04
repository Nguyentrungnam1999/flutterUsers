import 'dart:ffi';

import 'package:crudusers/src/configs/appConfig.dart';
import 'package:crudusers/src/controllers/user_controller.dart';
import 'package:crudusers/src/models/user.dart';
import 'package:crudusers/src/pages/create_user.dart';
import 'package:crudusers/src/pages/loading_page.dart';
import 'package:crudusers/src/pages/user_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  final UserController usersController = Get.put(UserController());

  Future getData() async {
    await usersController.getListUserData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: usersController.isLoading == true
          ? LoadingPage()
          : RefreshIndicator(
              onRefresh: refresh,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: usersController.users.length,
                      itemBuilder: ((context, index) {
                        final user = usersController.users[index];
                        DateTime dt = DateTime.parse(user.birthdate ?? '');
                        var formatDate = DateFormat('yyyy-MM-dd').format(dt);

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          color: const Color.fromARGB(255, 247, 243, 243),
                          child: InkWell(
                            onTap: (() {
                              Get.to(UserDetail(user: user));
                            }),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    '${user.avatar == '' ? 'https://picsum.photos/250?image=9' : user.avatar}'),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text('${user.name}'),
                              subtitle: Text('${formatDate.toString()}'),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(CreateUser());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
