import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:market_place_flutter_app/entities/speciality.dart';

class Category {
  final int id;
  final String name;
  final String image;
  final List<Speciality> specialities;

  const Category({
    required this.id,
    required this.name,
    required this.image,
    required this.specialities,
  });
  @override
  String toString() {
    return "($id,$name,$image,$specialities)";
  }

  static Category fromJson(Map<String, dynamic> json) => Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      specialities: List<dynamic>.from(json['specialities'])
          .map((i) => Speciality.fromJson(i))
          .toList()
      //json['specialities'].cast<Speciality>(),
      );
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
