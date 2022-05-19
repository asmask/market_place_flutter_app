import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:market_place_flutter_app/entities/speciality.dart';

class Service {
  final String pwd;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String token;
  final String title;
  final String description;
  final Speciality speciality;

  const Service({
    required this.pwd,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.title,
    required this.description,
    required this.speciality,
    this.token = "",
  });
//update Service
  Service copy({
    String? pwd,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? title,
    String? description,
    Speciality? speciality,
    String? token = "",
  }) =>
      Service(
        pwd: pwd ?? this.pwd,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        title: title ?? this.title,
        description: description ?? this.description,
        speciality: speciality ?? this.speciality,
        token: token ?? this.token,
      );
  getSpIRI() {
    int id = speciality.id;
    return '/api/specialities/$id';
  }

  static Service fromJson(Map<String, dynamic> json) => Service(
      pwd: json['password'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      title: json['title'],
      description: json['description'],
      speciality: Speciality.fromJson(json['speciality']));

  Map<String, dynamic> toJson() => {
        'password': pwd,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'title': title,
        'description': description,
        'speciality': speciality
            .toJson(), //json.encode(speciality.toJson()), //getSpIRI()
      };
}

class ServiceApi {
  static Future<bool> register(Service service) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/services");
    Map data = service.toJson();
    debugPrint('$data');
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
        //final fnameLower = Service.firstName.toLowerCase();
        //final lnameLower = service.lastName.toLowerCase();
        final specialityLower = service.speciality.name.toLowerCase();
        debugPrint(' ssssssssssssssss : $specialityLower');

        final queryLower = query.toLowerCase();
        return specialityLower.contains(
            queryLower); /*&&
            lnameLower.contains(queryLower) &&
            fnameLower.contains(queryLower);*/
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Service>> getServicesBySpeciality(var sp) async {
    var url =
        Uri.parse("http://127.0.0.1:8000/api/services?speciality.name=$sp");
    var response = await http.get(url);
    final List services = json.decode(response.body);
    debugPrint('By Speciality $services');

    if (response.statusCode == 200) {
      return services.map((json) => Service.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
