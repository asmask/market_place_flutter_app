import 'package:market_place_flutter_app/entities/service.dart';

class TimeSheet {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime day;
  final Service service;

  const TimeSheet({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.service,
  });
  @override
  String toString() {
    return "($id,$startTime,$endTime,$day,$service)";
  }

/*var now = DateTime.now();
var formatterDate = DateFormat('dd/MM/yy');
var formatterTime = DateFormat('kk:mm');
String actualDate = formatterDate.format(now);
String actualTime = formatterTime.format(now);*/
  static TimeSheet fromJson(Map<String, dynamic> json) => TimeSheet(
        id: json['id'],
        startTime: json['name'],
        endTime: json['description'],
        day: json['day'],
        service: json['service'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'startTime': startTime,
        'endTime': endTime,
        'day': day,
        'service': service,
      };
}

class TimeSheetApi {}
