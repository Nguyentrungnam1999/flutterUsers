import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading',
      home: Scaffold(
          body: Center(
        child: SpinKitPouringHourGlassRefined(
          color: Colors.blue,
          size: 100.0,
        ),
      )),
    );
  }
}
