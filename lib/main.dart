import 'package:crudusers/app.dart';
import 'package:crudusers/create_page.dart';
import 'package:crudusers/loading_page.dart';
import 'package:crudusers/person.dart';
import 'package:crudusers/person_detail.dart';
import 'package:crudusers/respository/person_respository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   ResponsitoryPerson responsitoryPerson = ResponsitoryPerson();
//   List<Person> persons = [];
//   late bool _isLoading;

//   // final formatDate = DateFormat.yMd().format(date);

//   getData() async {
//     persons = await responsitoryPerson.getData();
//     _isLoading = false;
//     setState(() {});
//   }

//   @override
//   void initState() {
//     _isLoading = true;
//     Future.delayed(const Duration(), () {
//       setState(() {
//         getData();
//       });
//     });
//     super.initState();
//   }

//   Future refresh() async {
//     _isLoading = true;
//     getData();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isLoading
//         ? const LoadingPage()
//         : MaterialApp(
//             title: 'user app',
//             home: Scaffold(
//               appBar: AppBar(
//                 title: const Text('Person list'),
//                 actions: [Icon(Icons.person_pin_rounded)],
//               ),
//               body: RefreshIndicator(
//                 onRefresh: refresh,
//                 child: ListView.builder(
//                   itemCount: persons.length,
//                   itemBuilder: ((context, index) {
//                     Person person = persons[index];
//                     DateTime dt = DateTime.parse(person.birthdate ?? '');
//                     var formatDate = DateFormat('yyyy-MM-dd').format(dt);

//                     return Card(
//                       margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                       color: Color.fromARGB(255, 247, 243, 243),
//                       child: InkWell(
//                         onTap: (() {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => MyDetails(
//                                       person: person,
//                                     )),
//                           );
//                         }),
//                         child: ListTile(
//                           leading: Container(
//                               child: CircleAvatar(
//                             radius: 30.0,
//                             backgroundImage: NetworkImage(
//                                 '${person.avatar == '' ? 'https://picsum.photos/250?image=9' : person.avatar}'),
//                             backgroundColor: Colors.transparent,
//                           )),
//                           title: new Text('${person.name}'),
//                           subtitle: Text('${formatDate.toString()}'),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () {
//                   // Navigator.popAndPushNamed(context, 'create');
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const CreatePage()),
//                   );
//                 },
//                 child: Icon(Icons.add),
//               ),
//             ),
//           );
//   }
// }
