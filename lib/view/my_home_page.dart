import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/appointments_model.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Get Data")),
      body: FutureBuilder(
        future: fetchAppointmentsHTTP(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Image.asset("assets/Loading animation.gif"));
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.error,
                  //   color: Colors.red,
                  //   size: 60,
                  // ),
                  Image.asset("assets/bear-19270_256.gif", height: 300),
                  CupertinoActivityIndicator(color: Colors.red, radius: 30),
                  Text("Error ${snapshot.error}"),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            List<AppointmentsModel> appointment = snapshot.data!;


            if(appointment.isEmpty){
              return Center(
                child: Text("List is Empty"),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {

                AppointmentsModel appointmentsModel = appointment[index];

                return ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    child: Text("${appointmentsModel.id}"),
                  ),
                  title: Text(appointmentsModel.patientName),
                  subtitle: Text(appointmentsModel.time),
                );
              },
              itemCount: snapshot.data?.length,
            );
          }

          return FlutterLogo();
        },
      ),
    );
  }
}
