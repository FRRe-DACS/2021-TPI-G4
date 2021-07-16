import 'package:sipre/models/userBusiness.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String token = '';

class Services {
  List reports = [];
  Map data;
  String getNumberMonth(String month) {
    String mes = '';
    switch (month) {
      case 'Enero':
        month = '1';
        break;
      case 'Febrero':
        month = '2';
        break;
      case 'Marzo':
        month = '3';
        break;
      case 'Abril':
        month = '4';
        break;
      case 'Mayo':
        month = '5';
        break;
      case 'Junio':
        month = '6';
        break;
      case 'Julio':
        month = '7';
        break;
      case 'Agosto':
        month = '8';
        break;
      case 'Septiembre':
        month = '9';
        break;
      case 'Octubre':
        month = '10';
        break;
      case 'Noviembre':
        month = '11';
        break;
      case 'Diciembre':
        month = '12';
        break;
    }

    return mes;
  }

  String getMonth(String mes) {
    String month = '';
    switch (mes) {
      case '01':
        month = 'Enero';
        break;
      case '1':
        month = 'Enero';
        break;
      case '2':
        month = 'Febrero';
        break;
      case '02':
        month = 'Febrero';
        break;
      case '3':
        month = 'Marzo';
        break;
      case '03':
        month = 'Marzo';
        break;
      case '4':
        month = 'Abril';
        break;
      case '04':
        month = 'Abril';
        break;
      case '05':
        month = 'Mayo';
        break;
      case '06':
        month = 'Junio';
        break;
      case '6':
        month = 'Junio';
        break;
      case '5':
        month = 'Mayo';
        break;
      case '07':
        month = 'Julio';
        break;
      case '7':
        month = 'Julio';
        break;
      case '08':
        month = 'Agosto';
        break;
      case '8':
        month = 'Agosto';
        break;
      case '09':
        month = 'Septiembre';
        break;
      case '9':
        month = 'Septiembre';
        break;
      case '10':
        month = 'Octubre';
        break;

      case '11':
        month = 'Noviembre';
        break;
      case '12':
        month = 'Diciembre';
        break;
    }

    return month;
  }

  Future<List> getStatistics(String year) async {
    List<dynamic> map = [];
    final List<Map<String, dynamic>> columns = [];

    final response = await http.get(
      //'http://10.0.2.2:3000/api/estadisticas?year=$year',
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/estadisticas?year=$year',
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      map = jsonDecode(response.body);

      if (map.isNotEmpty) {
        for (int i = 0; i <= map.length - 1; i++) {
          columns.add(map[i]);
        }
      }
    }
    return columns;
  }

  Future<bool> updateReport(
      String _id, List<Map<String, dynamic>> listaRegistro) async {
    String body = json.encode(listaRegistro);

    final response = await http.put(
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/reports/$_id',
      //'http://10.0.2.2:3000/api/reports/$_id',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'token': token,
      },
      body: body,
    );
    if (response.statusCode == 200) {
      print('datos actualizados');
      return true;
    } else {
      print(response.body);

      return false;
    }
  }

  Future<bool> addReport(
      Map<String, dynamic> infoEmpresa,
      Map<String, dynamic> periodo,
      List<Map<String, dynamic>> listaRegistro) async {
    final response = await http.post(
      //'http://10.0.2.2:3000/api/reports',
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/reports',
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': token,
      },
      body: jsonEncode(<String, dynamic>{
        'infoEmpresa': infoEmpresa,
        'listaRegistro': listaRegistro,
        'periodo': periodo,
      }),
    );
    if (response.statusCode == 200) {
      print('reporte agregado');

      return true;
    } else {
      print(response.body);
      return false;
      //throw Exception('Fallo al cargar reportes');
    }
  }

  Future<dynamic> updateProfileBusiness(UserBusiness userBusiness) async {
    String cuit = userBusiness.cuit.toString();

    final response = await http.put(
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/userbusiness?cuit=$cuit',
      //'http://10.0.2.2:3000/api/userbusiness?cuit=$cuit',
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': token,
      },
      body: jsonEncode(<String, dynamic>{
        'cuit': userBusiness.cuit,
        'razon_social': userBusiness.razon_social,
        'industria': userBusiness.industria,
        'email': userBusiness.email,
        'tel': userBusiness.tel,
        'ciudad': userBusiness.ciudad,
      }),
    );
    if (response.statusCode == 200) {
      print('datos actualizados');
    } else {
      print(response.body);
    }
  }

  Future<dynamic> getAllReports() async {
    final response = await http.get(
      //'http://10.0.2.2:3000/api/reports',
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/reports',
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      String body = response.body;

      reports = json.decode(body);

      return reports;
    } else {
      return Future.error('fallo al cargar reportes');
    }
  }

  Future<dynamic> deleteReport(String _id) async {
    final response = await http.delete(
      //'http://10.0.2.2:3000/api/reports/$_id',
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/reports/$_id',
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('reporte borrado exitosamente');
    } else {
      return Future.error('fallo al cargar reportes');
    }
  }

  Future<bool> signInUserMinistery(String mail, String password) async {
    final response = await http.post(
      //'http://10.0.2.2:3000/api/login',
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/loginMinisterio',
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': mail,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserBusiness> signIn(String email, String password) async {
    final response = await http.post(
      //'http://10.0.2.2:3000/api/login',
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/login',
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      UserBusiness business = new UserBusiness();

      token = response.headers['token'];

      Map<dynamic, dynamic> map = jsonDecode(response.body);
      business.cuit = map['cuit'];
      business.ciudad = map['ciudad'];
      business.email = map['email'];
      business.razon_social = map['razon_social'];
      business.industria = map['industria'];
      business.tel = map['tel'];

      return business;
    } else {
      return Future.error(response.body);
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> signUp(String cuit, String social_reason, String industry,
      String mail, String password, String phone, String city) async {
    final response = await http.post(
      //'http://10.0.2.2:3000/api/signup',
      'https://ministeriodesarrolloproductivo.herokuapp.com/api/signup',
      headers: <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': mail,
        'password': password,
        'razon_social': social_reason,
        'cuit': cuit,
        'industria': industry,
        'tel': phone,
        'ciudad': city,
      }),
    );
    if (response.statusCode == 200) {
      print('empresa registrada');
    } else {
      print(response.body);
    }
  }
}
