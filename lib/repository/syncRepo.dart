import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class SyncRepo{

  Future<bool> syncData(List schoolsToUpdate, String env);
}

class SyncRepoImpl implements SyncRepo{

  bool result;
  List<int> dataListAsInt;

  Future<bool> syncData(List schoolsToUpdate, String env) async{
    String loginEnv = DotEnv().env['URL_LOGIN'];
    String syncEnv = DotEnv().env['URL_SYNC'];
    String urlLogin = 'https://api.$env${loginEnv}';
    debugPrint(urlLogin);
    String urlSync = 'https://api.$env${syncEnv}';
    debugPrint(urlSync);
    debugPrint(DotEnv().env['EMAIL']);
    debugPrint(DotEnv().env['PASSWORD']);

    if(schoolsToUpdate.isEmpty || schoolsToUpdate.contains('')){
      dataListAsInt = [0];
      debugPrint('The list is empty');
    }else {
      debugPrint('The list is filled');
      dataListAsInt = schoolsToUpdate.map((data) => int.parse(data)).toList();
    }

    debugPrint('Logging in...');
    var response_log = await http.post(urlLogin,
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
      body : jsonEncode({"email": DotEnv().env['EMAIL'],"password": DotEnv().env['PASSWORD']}),
    );

    debugPrint('Response status: ${response_log.statusCode}');
    var jsonData_log = json.decode(response_log.body);
    debugPrint('Response API Key: ${jsonData_log['api_key']}');
    String APIKEY = await jsonData_log['api_key'];

    debugPrint('Synchronizing all dev data with ${schoolsToUpdate.toString()}');
    var response = await http.post(urlSync,
      headers: {"Content-Type": "application/json", "Accept": "application/json", "Authorization": "Bearer $APIKEY"},
      body:  jsonEncode({"schools": dataListAsInt}),
    );

    debugPrint('Response status: ${response.statusCode}');
    var jsonData = json.decode(response.body);
    debugPrint('Respone Status: ${jsonData['status']}');

    if(response.statusCode == 200){
      result = true;
    }else {
      result = false;
    }

    return result;

  }

}