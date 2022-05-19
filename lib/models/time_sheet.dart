import 'package:market_place_flutter_app/models/service.dart';

class TimeSheet {
  int? id;
  String? day;
  String? startTime;
  String? endTime;
  Service? service;

  TimeSheet({
    this.id,
    this.day,
    this.startTime,
    this.endTime,
    this.service,
  });

  TimeSheet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    if (service != null) {
      data['service'] = service!.toJson();
    }

    return data;
  }
}
