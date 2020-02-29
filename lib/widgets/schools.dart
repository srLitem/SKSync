import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolkassync/widgets/data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Schools extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Schools();
  }
}

class _Schools extends State<Schools> {
  TextEditingController textIds = new TextEditingController();

  //Grid variables
  List<String> _list = []; 

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, ids, child) {
      return Container(
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height / 1.8,
        decoration: BoxDecoration(
          color: Color.fromRGBO(201, 73, 106, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Opacity(
                opacity: emptyState(ids.schools),
                child: Container(
                  height: MediaQuery.of(context).size.height * 1.5,
                  width: MediaQuery.of(context).size.width * 1.5,
                  child: SvgPicture.asset(
                    'assets/img/onboarding-man.svg',
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Schools',
                          style: TextStyle(
                            fontFamily: 'Asap',
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          //Makes the boundaries of the Textfield dynamic
                          width: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(.5),
                            ),
                            child: TextField(
                              controller: textIds,
                              autofocus: false,
                              onSubmitted: (d) {
                                if (!ids.schools.contains(textIds.text) & (textIds.text != '')){
                                  ids.addSchoolID(textIds.text);
                                }
                                addID(textIds.text); },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                border: InputBorder.none,
                                hintText: 'ID',
                                hintStyle: TextStyle(
                                  fontFamily: 'Asap',
                                  fontSize: 27,
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Asap',
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          height: 40,
                          width: 40,
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              if (!ids.schools.contains(textIds.text) & (textIds.text != '')){
                                ids.addSchoolID(textIds.text);
                              }
                              addID(textIds.text); },
                            color: Color.fromRGBO(201, 73, 106, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      padding: EdgeInsets.all(10),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: _list.map((id) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(.7),
                              ),
                              child: Center(
                                child: Text(
                                  id,
                                  style: TextStyle(
                                    fontFamily: 'Asap',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(Icons.remove_circle),
                                onPressed: () {
                                  removeID(id);
                                  ids.removeSchoolID(id);
                                },
                                //Add the ID to the Gridview
                                color: Color.fromRGBO(201, 73, 106, 1),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  addID(String text) {
    setState(() {
      if (_list.contains(text)) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: Text('Buddy, invalid ID',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Asap')),
            content: Text('This ID has already been added to the list!',
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: 'Asap')),
            actions: <Widget>[
              FlatButton(
                  splashColor: Colors.white,
                  color: Color.fromRGBO(201, 73, 106, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'Gotta check that',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Asap'),
                  ),
                  onPressed: () => Navigator.pop(context)),
            ],
            backgroundColor: Colors.white,
          ),
          barrierDismissible: false,
        );
        textIds.text = '';
      } else if (textIds.text.isEmpty) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            title: Text('You forgot to add something...',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Asap')),
            content: Text('Emptiness is not a cool thing. Please, add an ID',
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: 'Asap')),
            actions: <Widget>[
              FlatButton(
                  splashColor: Colors.white,
                  color: Color.fromRGBO(201, 73, 106, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'You got it',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Asap'),
                  ),
                  onPressed: () => Navigator.pop(context)),
            ],
            backgroundColor: Colors.white,
          ),
          barrierDismissible: false,
        );
      } else {
        debugPrint('The value is $text');
        _list.add(text);
        textIds.text = ''; //Makes the input field empty
      }
    });
  }

  removeID(String text) {
    setState(() {
      _list.remove(text);
    });
  }
  
  double emptyState(List schools){
    if(schools.isEmpty){
      return 0.5;
    }else{
      return 0.1;
    }
  }
}
