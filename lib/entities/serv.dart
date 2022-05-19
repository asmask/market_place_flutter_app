import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Service {
  final String firstName;
  final String lastName;
  const Service({
    required this.firstName,
    required this.lastName,
  });
  @override
  String toString() {
    return "$firstName,$lastName";
  }

  static Service fromJson(Map<String, dynamic> json) => Service(
        firstName: json['firstName'],
        lastName: json['lastName'],
      );
}

class ServiceApi {
  static Future<List<Service>> getServiceSuggestions(String query) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/services");
    var response = await http.get(url);
    final List services = json.decode(response.body);
    debugPrint('$services');

    if (response.statusCode == 200) {
      return services.map((json) => Service.fromJson(json)).where((service) {
        //final fnameLower = Service.firstName.toLowerCase();
        final lnameLower = service.toString().toLowerCase();
        //final specialityLower = service.speciality.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return lnameLower.contains(
            queryLower); /*&&
            lnameLower.contains(queryLower) &&
            fnameLower.contains(queryLower);*/
      }).toList();
    } else {
      throw Exception();
    }
  }
}
