import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolkassync/widgets/data.dart';
import 'package:schoolkassync/widgets/syncScreen.dart';

class Structure extends StatefulWidget{
  @override
  _StructureState createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  String title;
  int indexTap = 0;



  void onTapped(int index){ //Function to set the tap to the current screen
    setState(() {
      indexTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => Data(),
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: list(indexTap),
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTapped,
            currentIndex: indexTap,
            selectedItemColor: Color.fromRGBO(201, 73, 106, 100),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Development'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                title: Text('Staging'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business_center),
                title: Text('Production'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget list(int index){
    List<Widget> widgetsChildren = [
      SyncScreen('Development'),
      SyncScreen('Staging'),
      SyncScreen('Production'),
    ];

    return widgetsChildren[index];
  }
}