import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<List<dynamic>> fetchAppointmentsHTTP() async {
    await Future.delayed(const Duration(seconds: 5));
    final response = await http.get(
      Uri.parse('https://geu.ejust.edu.eg/get/appointments/api'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
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
            return Center(
              child: Image.asset(
                "assets/Loading animation.gif",

              ),
            );
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

          if(snapshot.hasData){

            return ListView.builder(
              itemBuilder: (context, index) {
                final appointment = snapshot.data;
                return ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    child: Text("${appointment?[index]['id']}"),
                  ),
                  title: Text("${appointment?[index]['patient_name']}"),
                  subtitle: Text("${appointment?[index]['time']}"),
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
