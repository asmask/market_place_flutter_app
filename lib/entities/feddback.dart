import 'package:market_place_flutter_app/entities/service.dart';

import 'client.dart';

class Feedback {
  final int id;
  final double rating;
  final String comment;
  final Service service;
  final Client client;
  const Feedback({
    required this.id,
    required this.rating,
    required this.comment,
    required this.service,
    required this.client,
  });
  @override
  String toString() {
    return "($id,$rating,$comment,$service,$client)";
  }

  static Feedback fromJson(Map<String, dynamic> json) => Feedback(
        id: json['id'],
        rating: json['name'],
        comment: json['description'],
        service: json['service'],
        client: json['description'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'rating': rating,
        'comment': comment,
        'service': service,
        'client': client
      };
}

class FeedbackApi {}
