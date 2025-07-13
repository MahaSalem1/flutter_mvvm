class AppointmentsModel {
  final int id;
  final String patientName;
  final String time;

  AppointmentsModel({
    required this.id,
    required this.patientName,
    required this.time,
  });

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(id: json['id'], patientName: json['patient_name'], time: json['time']);
  }
}
