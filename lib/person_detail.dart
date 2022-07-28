import 'package:crudusers/edit_person.dart';
import 'package:crudusers/main.dart';
import 'package:crudusers/person.dart';
import 'package:crudusers/respository/person_respository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyDetails extends StatefulWidget {
  Person person;
  MyDetails({required this.person});
  @override
  _MyDetailsState createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  ResponsitoryPerson responsitoryPerson = ResponsitoryPerson();

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.parse(widget.person.birthdate ?? '');
    var formatDate = DateFormat('yyyy-MM-dd').format(dt);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Details'),
        elevation: 0.0,
        backgroundColor: Colors.indigo[700],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 32),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.indigo[700],
                child: Center(
                    child: Text(
                  'Details',
                  style: TextStyle(color: Color(0xffFFFFFF)),
                )),
              ),
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 90,
                          width: 90,
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage('${widget.person.avatar}'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Text(
                        'Name: ${widget.person.name}',
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
                        'Address: ${widget.person.address}',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                // height: 455 ,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xffFFFFFF), boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 1),
                  ),
                ]),
              ),
              Row(children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditPerson(
                                  person: widget.person,
                                )));
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
                                  'Are you sure delete - ${widget.person.name}'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    bool response = await responsitoryPerson
                                        .deletePerson(widget.person.id);
                                    if (response) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePage()));
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
