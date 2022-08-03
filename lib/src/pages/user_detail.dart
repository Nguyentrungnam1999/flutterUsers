import 'package:crudusers/src/controllers/user_controller.dart';
import 'package:crudusers/src/models/user.dart';
import 'package:crudusers/src/pages/home_page.dart';
import 'package:crudusers/src/pages/update_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatefulWidget {
  User user;
  UserDetail({required this.user});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.parse(widget.user.birthdate ?? '');
    var formatDate = DateFormat('yyyy-MM-dd').format(dt);
    return Scaffold(
      appBar: AppBar(title: const Text('Detail User')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 32),
          child: Column(
            children: [
              Card(
                elevation: 3,
                margin: EdgeInsets.zero,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.indigo[700],
                  child: Center(
                      child: Text(
                    'Details',
                    style: TextStyle(color: Color(0xffFFFFFF)),
                  )),
                ),
              ),
              Card(
                elevation: 3,
                margin: EdgeInsets.zero,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 90,
                            width: 90,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  '${widget.user.avatar != '' ? widget.user.avatar : 'https://picsum.photos/250?image=9'}'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        Text(
                          'Name: ${widget.user.name}',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'BirthDate: ${formatDate}',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Address: ${widget.user.address}',
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Phone: ${widget.user.phone}',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  // height: 455 ,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(color: Color(0xffFFFFFF), boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 2),
                    ),
                  ]),
                ),
              ),
              Row(children: [
                TextButton(
                  onPressed: () {
                    Get.to(UpdateUser(user: widget.user));
                  },
                  child: Text('Edit'),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text('Delete Person'),
                              content: Text(
                                  'Are you sure delete - ${widget.user.name}'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    bool response = await userController
                                        .deleteUser(widget.user.id);
                                    if (response) {
                                      Navigator.pop(context, 'OK');
                                      Get.to(HomePage());
                                    } else {
                                      Navigator.pop(context, 'OK');
                                    }
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            )));
                  },
                  child: Text('Delete'),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
