import 'package:market_place_flutter_app/models/service.dart';
import 'package:market_place_flutter_app/models/client.dart';

class FeedBack {
  int? id;
  int? rating;
  String? comment;
  Service? service;
  Client? client;
  String? createdAt;
  String? updatedAt;

  FeedBack(
      {this.id,
      this.rating,
      this.comment,
      this.service,
      this.client,
      this.createdAt,
      this.updatedAt});

  FeedBack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    comment = json['comment'];
    service = json['service'];
    client = json['client'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rating'] = rating;
    data['comment'] = comment;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
