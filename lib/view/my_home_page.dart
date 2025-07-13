import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/appointments_model.dart';
import 'package:flutter_mvvm/services/api_services.dart';
import 'package:flutter_mvvm/view/widgets/error_design_widget.dart';
import 'package:flutter_mvvm/view/widgets/loading_widget.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Get Data")),
      body: FutureBuilder(
        future: ApiServices().fetchAppointmentsHTTP(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }

          if (snapshot.hasError) {
            return ErrorDesignWidget();
          }

          if (snapshot.hasData) {
            List<AppointmentsModel> appointment = snapshot.data!;

            if (appointment.isEmpty) {
              return Center(child: Text("List is Empty"));
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                AppointmentsModel appointmentsModel = appointment[index];

                return ListTile(
                  onTap: () {},
                  leading: CircleAvatar(child: Text("${appointmentsModel.id}")),
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
