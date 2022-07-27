import 'package:crudusers/create_page.dart';
import 'package:crudusers/person.dart';
import 'package:crudusers/respository/person_respository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ResponsitoryPerson responsitoryPerson = ResponsitoryPerson();
  List<Person> persons = [];

  // final formatDate = DateFormat.yMd().format(date);

  getData() async {
    persons = await responsitoryPerson.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'user app',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('employee list'),
          actions: [Icon(Icons.person_pin_rounded)],
        ),
        body: ListView.builder(
          itemCount: persons.length,
          itemBuilder: ((context, index) {
            Person person = persons[index];
            DateTime dt = DateTime.parse(person.birthdate ?? '');
            var formatDate = DateFormat('yy-MM-dd').format(dt);

            return ListTile(
              leading: Container(
                  height: 60,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage('${persons[index].avatar}'),
                    backgroundColor: Colors.transparent,
                  )),
              title: new Text('${person.name}'),
              subtitle: Text('${formatDate.toString()}'),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.popAndPushNamed(context, 'create');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreatePage()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
