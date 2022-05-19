import 'dart:convert';
import 'package:http/http.dart' as http;

class Client {
  final String pwd;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String token;
  final String location;

  const Client({
    required this.pwd,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.location = "",
    this.token = "",
  });
//update Client
  Client copy({
    String? pwd,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? token,
    String? location,
  }) =>
      Client(
        pwd: pwd ?? this.pwd,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        token: token ?? this.token,
        location: location ?? this.location,
      );
  static Client fromJson(Map<String, dynamic> json) => Client(
      pwd: json['password'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      location: json['location']);
  Map<String, dynamic> toJson() => {
        'password': pwd,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'location': location,
      };
}

class ClientApi {
  static Future<bool> register(Client client) async {
    var url = Uri.parse("http://127.0.0.1:8000/api/clients");
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

  static login(String username, String pwd) async {
    //var url = Uri.parse("http://192.168.56.1:8000/api/login");
    //var url = Uri.parse("http://10.0.3.2:8000/api/login");
    var url = Uri.parse("http://127.0.0.1:8000/api/login");

    Map data = {'username': username, 'password': pwd};
    var response = await http.post(url, body: json.encode(data), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['token'];
    } else {
      return "";
    }
  }
}
