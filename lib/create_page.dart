import 'package:crudusers/main.dart';
import 'package:crudusers/respository/person_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  ResponsitoryPerson responsesitory = ResponsitoryPerson();
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'create page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Person'),
          actions: [Icon(Icons.add_alert_sharp)],
        ),
        body: Container(
            child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'First Name'),
              controller: _nameController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Avatar'),
              controller: _avatarController,
            ),
            ElevatedButton(
              onPressed: () async {
                bool response = await responsesitory.createPerson(
                    _nameController.text, _avatarController.text);
                if (response) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
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
