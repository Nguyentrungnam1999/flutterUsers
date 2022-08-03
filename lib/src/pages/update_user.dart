import 'package:crudusers/main.dart';
import 'package:crudusers/person.dart';
import 'package:crudusers/person_detail.dart';
import 'package:crudusers/respository/person_respository.dart';
import 'package:crudusers/src/controllers/user_controller.dart';
import 'package:crudusers/src/models/user.dart';
import 'package:crudusers/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UpdateUser extends StatefulWidget {
  final User user;
  UpdateUser({required this.user});
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final UserController usersController = Get.put(UserController());
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    var formatDate = DateFormat('yyyy-MM-dd').format(date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        elevation: 0.0,
        title: Text('Edit Person'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 100, left: 18, right: 18),
          child: Container(
            height: 550,
            width: 400,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(4),
            //   color: Colors.indigo[500],
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.indigo[500],
                  ),
                  child: Text(
                    '${widget.user.name}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(boxShadow: []),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Name'),
                      controller: nameController,
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: Row(
                    children: [
                      Text('Birth Date: '),
                      FlatButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2999));

                            if (newDate == null) return;
                            setState(() {
                              date = newDate;
                            });
                          },
                          child: Text('${formatDate}')),
                    ],
                  ),
                ),
                Container(
                    width: 300,
                    decoration: BoxDecoration(boxShadow: []),
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(hintText: 'Address'),
                    )),
                Container(
                    width: 300,
                    decoration: BoxDecoration(boxShadow: []),
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(hintText: 'Phone'),
                    )),
                ElevatedButton(
                  onPressed: () async {
                    bool res = await usersController.updateUser(
                        widget.user.id,
                        nameController.text,
                        date.toString(),
                        phoneController.text,
                        addressController.text);
                    if (res) {
                      Get.to(const HomePage());
                    } else {
                      throw Exception('Faield to create data.');
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
