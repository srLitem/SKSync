import 'package:flutter/material.dart';

class TopBar extends StatelessWidget{

  String title;

  TopBar (this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/14,
      decoration: BoxDecoration(
        color: Color.fromRGBO(201, 73, 106, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child:
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Asap',
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

}