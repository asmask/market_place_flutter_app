import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:market_place_flutter_app/models/appointment.dart';
import 'package:market_place_flutter_app/models/feedback.dart';
import 'package:market_place_flutter_app/models/insurance.dart';
import 'package:market_place_flutter_app/models/speciality.dart';
import 'package:market_place_flutter_app/models/time_sheet.dart';

class Service {
  String? title;
  String? password;
  String? description;
  List<String>? languages;
  List<String>? paymentMethods;
  List<TimeSheet>? timeSheets;
  List<FeedBack>? feedbacks;
  List<Appointment>? appointments;
  List<Insurance>? insurance;
  Speciality? speciality;
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Service(
      {this.title,
      this.password,
      this.description,
      this.languages,
      this.paymentMethods,
      this.timeSheets,
      this.feedbacks,
      this.appointments,
      this.insurance,
      this.speciality,
      this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber});

  @override
  String toString() {
    var s = speciality!.name;
    return "($title,$s,$firstName,$lastName)";
  }

  Service.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    password = json['password'];
    description = json['description'];
    languages = json['languages'].cast<String>();
    paymentMethods = json['paymentMethods'].cast<String>();
    if (json['timeSheets'] != null) {
      timeSheets = <TimeSheet>[];
      json['timeSheets'].forEach((v) {
        timeSheets!.add(TimeSheet.fromJson(v));
      });
    }
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
    if (json['insurance'] != null) {
      insurance = <Insurance>[];
      json['insurance'].forEach((v) {
        insurance!.add(Insurance.fromJson(v));
      });
    }
    speciality = json['speciality'] != null
        ? Speciality.fromJson(json['speciality'])
        : null;
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    if (languages != null) {
      data['languages'] = languages;
    }
    if (paymentMethods != null) {
      data['paymentMethods'] = paymentMethods;
    }
    if (timeSheets != null) {
      data['timeSheets'] = timeSheets!.map((v) => v.toJson()).toList();
    }
    if (feedbacks != null) {
      data['feedbacks'] = feedbacks!.map((v) => v.toJson()).toList();
    }
    if (appointments != null) {
      data['appointments'] = appointments!.map((v) => v.toJson()).toList();
    }
    if (insurance != null) {
      data['insurance'] = insurance!.map((v) => v.toJson()).toList();
    }
    if (speciality != null) {
      data['speciality'] = speciality!.toJson();
    }
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;

    return data;
  }
}

class ServiceApi {
  static Future<bool> register(Service service) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/services");
    Map data = service.toJson();
    debugPrint('Version 2 $data');
    var response = await http.post(url, body: json.encode(data), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  static Future<List<Service>> getServiceSuggestions(String query) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/services");
    var response = await http.get(url);
    final List services = json.decode(response.body);
    debugPrint('$services');

    if (response.statusCode == 200) {
      return services.map((json) => Service.fromJson(json)).where((service) {
        debugPrint('e serviceeeeeeee  $service');
        //final fnameLower = Service.firstName.toLowerCase();
        final dataLower = service.toString().toLowerCase();
        //final specialityLower = service.speciality.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return dataLower.contains(
            queryLower); /*&&
            lnameLower.contains(queryLower) &&
            fnameLower.contains(queryLower);*/
      }).toList();
    } else {
      throw Exception();
    }
  }
}
