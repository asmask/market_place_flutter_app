import 'package:market_place_flutter_app/models/service.dart';

class Insurance {
  int? id;
  String? name;
  String? description;
  List<Service>? services;

  Insurance({
    this.id,
    this.name,
    this.description,
    this.services,
  });

  Insurance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['service'] != null) {
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
    data['description'] = description;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
