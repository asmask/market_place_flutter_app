import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:market_place_flutter_app/models/service.dart';

class Speciality {
  int? id;
  String? name;
  List<Service>? services;

  Speciality({
    this.id,
    this.name,
    this.services,
  });

  Speciality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecialityApi {
  static Future<List<Service>> getSpecialitiesById(int id) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/specialities/$id");
    var response = await http.get(url);
    final speciality = json.decode(response.body);
    debugPrint('$speciality');
    final List services = speciality['services'];
    debugPrint('$services');
    if (response.statusCode == 200) {
      return services.map((json) => Service.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
