import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_mvvm/model/appointments_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {

  Future<List<AppointmentsModel>> fetchAppointmentsHTTP() async {
    final response = await http.get(
      Uri.parse('https://geu.ejust.edu.eg/get/appointments/api'),
    );

    if (response.statusCode == 200) {


      List<dynamic> jsonList = json.decode(response.body);



      // List<AppointmentsModel> appointments = jsonList
      //     .map((json) => AppointmentsModel.fromJson(json))
      //     .toList();

      List<AppointmentsModel> appointments = [];

      for (var item in jsonList) {
        appointments.add(AppointmentsModel.fromJson(item));
      }


      return appointments;
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  Future<List<dynamic>> fetchAppointmentsDio() async {
    final response = await Dio().get(
      'https://geu.ejust.edu.eg/get/appointments/api',
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load appointments');
    }
  }
}