import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:market_place_flutter_app/models/speciality.dart';

class Category {
  int? id;
  String? name;
  String? image;
  List<Speciality>? specialities;

  Category({this.id, this.name, this.image, this.specialities});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['specialities'] != null) {
      specialities = <Speciality>[];
      json['specialities'].forEach((v) {
        specialities!.add(Speciality.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    if (specialities != null) {
      data['specialities'] = specialities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryApi {
  static Future<List<Category>> getCategories() async {
    var url = Uri.parse("http://127.0.0.1:8000/api/categories");
    var response = await http.get(url);
    final List categories = json.decode(response.body);
    debugPrint('aa $categories');
    if (response.statusCode == 200) {
      return categories.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
