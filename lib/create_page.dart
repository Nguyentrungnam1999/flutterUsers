import 'dart:io';

import 'package:crudusers/main.dart';
import 'package:crudusers/respository/person_respository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  ResponsitoryPerson responsesitory = ResponsitoryPerson();
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();
  final _addressControler = TextEditingController();
  DateTime date = DateTime.now();
  // Image
  File? _image;
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    var formatDate = DateFormat('yyyy-MM-dd').format(date);
    print('==============${_image.toString()}');
    return MaterialApp(
      title: 'create page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Person'),
          actions: const [Icon(Icons.add_alert_sharp)],
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Container(
                  child: Column(children: [
                    _image != null
                        ? Image.file(
                            _image!,
                            width: 90,
                            height: 90,
                          )
                        : Image.network(
                            'https://picsum.photos/250?image=9',
                            height: 90,
                            width: 90,
                          ),

                    // CircleAvatar(
                    //   radius: 50.0,
                    //   backgroundImage: ,
                    //   backgroundColor: Colors.transparent,
                    // ),
                    ElevatedButton.icon(
                      onPressed: () => getImage(ImageSource.gallery),
                      icon: Icon(Icons.folder),
                      label: Text('Pick from Gallery'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => getImage(ImageSource.camera),
                      icon: Icon(Icons.camera),
                      label: Text('Pick from Camera'),
                    ),
                  ]),
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  controller: _nameController,
                ),
                Row(
                  children: [
                    const Text('Birth Date: '),
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
                TextField(
                  decoration: InputDecoration(hintText: 'Avatar'),
                  controller: _avatarController,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Address'),
                  controller: _addressControler,
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool response = await responsesitory.createPerson(
                        _nameController.text,
                        _avatarController.text,
                        date.toString(),
                        _addressControler.text);
                    if (response) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    } else {
                      throw Exception('Faield to create data.');
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            )),
      ),
    );
  }
}
