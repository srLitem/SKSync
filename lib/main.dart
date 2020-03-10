import 'package:flutter/material.dart';
import 'package:schoolkassync/widgets/structure.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SchoolkasSync',
      theme: ThemeData(
        fontFamily: 'Asap',
      ),
      home: Structure(),
    );
  }
}
