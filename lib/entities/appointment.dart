import 'package:market_place_flutter_app/entities/service.dart';

import 'client.dart';

class Appointment {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime date;
  final String status;
  final Service service;
  final Client client;
  const Appointment({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.status,
    required this.service,
    required this.client,
  });
  @override
  String toString() {
    return "($id,$startTime,$endTime,$date,$service,$client)";
  }

/*var now = DateTime.now();
var formatterDate = DateFormat('dd/MM/yy');
var formatterTime = DateFormat('kk:mm');
String actualDate = formatterDate.format(now);
String actualTime = formatterTime.format(now);*/
  static Appointment fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        startTime: json['name'],
        endTime: json['description'],
        date: json['description'],
        status: json['status'],
        service: json['service'],
        client: json['description'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'startTime': startTime,
        'endTime': endTime,
        'date': date,
        'status': status,
        'service': service,
        'client': client
      };
}

class AppointmentApi {}
