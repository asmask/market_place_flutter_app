import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Insurance {
  final int id;
  final String name;
  final String description;
  const Insurance({
    required this.id,
    required this.name,
    required this.description,
  });
  @override
  String toString() {
    return "($id,$name,$description)";
  }

  static Insurance fromJson(Map<String, dynamic> json) => Insurance(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}

class InsuranceApi {
  static Future<List<Insurance>> getSpecialitiesByCat(int id) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/categories/$id");
    var response = await http.get(url);
    final category = json.decode(response.body);
    final List insurances = category['insurances'];
    debugPrint('$insurances');
    if (response.statusCode == 200) {
      return insurances.map((json) => Insurance.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
