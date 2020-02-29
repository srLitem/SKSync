import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolkassync/widgets/data.dart';
import 'package:schoolkassync/widgets/schools.dart';
import 'package:schoolkassync/widgets/topBar.dart';
import 'package:schoolkassync/repository/syncRepo.dart';

class SyncScreen extends StatefulWidget {
  String title;

  SyncScreen(this.title);

  @override
  State<StatefulWidget> createState() {
    return _SyncScreen();
  }
}

class _SyncScreen extends State<SyncScreen> {
  String response;
  bool success;

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, ids, child){
        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                TopBar('SchoolKasSync'),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Text(
                    '${widget.title}',
                    style: TextStyle(
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromRGBO(201, 73, 106, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Center(child: Schools()),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(201, 73, 106, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 70,
                    width: MediaQuery.of(context).size.width - 150,
                    child: InkWell(
                      onTap: () {showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          title: Text('So it begins...',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(201, 73, 106, 1),
                                  fontFamily: 'Asap'
                              )),
                          content: RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'The synchronization to the',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Asap'
                                      )
                                  ),
                                  TextSpan(
                                      text: ' ${widget.title}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(201, 73, 106, 1),
                                        fontFamily: 'Asap',
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                  TextSpan(
                                      text: ' environment',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'Asap',
                                      )
                                  )
                                ]
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'Oh no, WAIT!',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(201, 73, 106, 1),
                                  fontFamily: 'Asap',
                                ),
                              ),
                              shape: new RoundedRectangleBorder(
                                side: BorderSide(color: Color.fromRGBO(201, 73, 106, 1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: ()  => Navigator.pop(context),

                            ),
                            FlatButton(
                                splashColor: Colors.white,
                                color: Color.fromRGBO(201, 73, 106, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  'Let\'s go',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Asap'
                                  ),
                                ),
                                onPressed: () => syncTheData(ids.schools)
                            ),
                          ],
                          backgroundColor: Colors.white,
                        ),
                        barrierDismissible: false,
                      );},
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            buttonText(ids.schools),
                            style: TextStyle(
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        );
      },

    );
  }

  syncTheData(List data) async{
    List values;
    String environment;
    if(data.isEmpty){
      values = [];
    }else{
      values = data;
    }

    if(widget.title == 'Development'){
      environment = 'dev';
    }else if(widget.title == 'Staging'){
      environment = 'staging';
    }else {
      environment = 'production';
    }

    Navigator.pop(context);
    var response = await SyncRepoImpl().syncData(values, environment);
    setState(() {
        if (response){
          success = true;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              title: Text('Hey, this is nice!',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(201, 73, 106, 1),
                      fontFamily: 'Asap'
                  )),
              content: Text(
                'The sync has been finished, baby!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'Asap',
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  splashColor: Colors.white,
                  color: Color.fromRGBO(201, 73, 106, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'Back to work!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Asap'
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              backgroundColor: Colors.white,
            ),
            barrierDismissible: false,
          );
        }else{
          success = false;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              title: Text('Oh...no',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(201, 73, 106, 1),
                      fontFamily: 'Asap'
                  )),
              content: Text(
                'Oh my god, this is not so cool!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'Asap',
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  splashColor: Colors.white,
                  color: Color.fromRGBO(201, 73, 106, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'I\'m fired!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Asap'
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              backgroundColor: Colors.white,
            ),
            barrierDismissible: false,
          );
        }
      });
      debugPrint('$response');

  }
  
  String buttonText(List schools){
    if(schools.isEmpty){
      return 'Gotta sync them all!';
    }else{
      return 'Start the specific sync!';
    }
  }


}
