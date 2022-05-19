import 'package:market_place_flutter_app/models/appointment.dart';
import 'package:market_place_flutter_app/models/feedback.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Client {
  int? id;
  String? email;
  List<String>? roles;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? location;
  List<FeedBack>? feedbacks;
  List<Appointment>? appointments;

  Client(
      {this.id,
      this.email,
      this.roles,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.location,
      this.feedbacks,
      this.appointments});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    roles = json['roles'].cast<String>();
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    if (json['feedbacks'] != null) {
      feedbacks = <FeedBack>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(FeedBack.fromJson(v));
      });
    }
    if (json['appointments'] != null) {
      appointments = <Appointment>[];
      json['appointments'].forEach((v) {
        appointments!.add(Appointment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['roles'] = roles;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    if (feedbacks != null) {
      data['feedbacks'] = feedbacks!.map((v) => v.toJson()).toList();
    }
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientApi {
  static Future<bool> register(Client client) async {
    var url = Uri.parse("http://172.17.0.1:8000/api/clients");
    Map data = client.toJson();
    var response = await http.post(url, body: json.encode(data), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
