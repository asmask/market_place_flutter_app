import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Speciality {
  final int id;
  final String name;
  const Speciality({
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return "($id,$name)";
  }

  static Speciality fromJson(Map<String, dynamic> json) => Speciality(
        id: json['id'],
        name: json['name'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class SpecialityApi {
  static Future<List<Speciality>> getSpecialitiesByCat(int id) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/categories/$id");
    var response = await http.get(url);
    final category = json.decode(response.body);
    debugPrint('$category');
    final List specialities = category['specialities'];
    debugPrint('$specialities');
    if (response.statusCode == 200) {
      return specialities.map((json) => Speciality.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  /* static Future<List<Speciality>> getSpecialitiesById(int id) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/specialities/$id");
    var response = await http.get(url);
    final speciality = json.decode(response.body);
    debugPrint('$speciality');
    final List services = speciality['services'];
    debugPrint('$services');
    if (response.statusCode == 200) {
      return services.map((json) => Speciality.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }*/
}
