import 'package:market_place_flutter_app/entities/service.dart';
import 'package:market_place_flutter_app/models/client.dart';

class Appointment {
  int? id;
  String? startTime;
  String? endTime;
  String? date;
  String? status;
  Service? service;
  Client? client;

  Appointment(
      {this.id,
      this.startTime,
      this.endTime,
      this.date,
      this.status,
      this.service,
      this.client});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    date = json['date'];
    status = json['status'];
    service = json['service'];
    client = json['client'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['date'] = date;
    data['status'] = status;
    data['service'] = service;
    data['client'] = client;

    return data;
  }
}
