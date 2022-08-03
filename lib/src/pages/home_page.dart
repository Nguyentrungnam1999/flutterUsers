import 'package:crudusers/src/configs/appConfig.dart';
import 'package:crudusers/src/controllers/user_controller.dart';
import 'package:crudusers/src/models/user.dart';
import 'package:crudusers/src/pages/create_user.dart';
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
  final UserController usersController = Get.put(UserController());

  getData() async {
    usersController.getListUserData();
    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: usersController.users.length,
              itemBuilder: ((context, index) {
                DateTime dt = DateTime.parse(
                    usersController.users[index].birthdate ?? '');
                var formatDate = DateFormat('yyyy-MM-dd').format(dt);

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  color: Color.fromARGB(255, 247, 243, 243),
                  child: InkWell(
                    onTap: (() {
                      Get.to(UserDetail(user: usersController.users[index]));
                    }),
                    child: ListTile(
                      leading: Container(
                          child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            '${usersController.users[index].avatar == '' ? 'https://picsum.photos/250?image=9' : usersController.users[index].avatar}'),
                        backgroundColor: Colors.transparent,
                      )),
                      title: new Text('${usersController.users[index].name}'),
                      subtitle: Text('${formatDate.toString()}'),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
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
