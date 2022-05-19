import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_place_flutter_app/models/others/draggable_list.dart';
import 'package:market_place_flutter_app/provider/constants.dart';
import 'package:market_place_flutter_app/widget/change_theme_button.dart';

class TimeSheetsScreen extends StatefulWidget {
  const TimeSheetsScreen({Key? key}) : super(key: key);

  @override
  State<TimeSheetsScreen> createState() => _TimeSheetsScreenState();
}

class _TimeSheetsScreenState extends State<TimeSheetsScreen> {
  late List<DragAndDropList> lists;
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  @override
  void initState() {
    super.initState();
    lists = draggableList.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('TimeSheets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          actions: const [
            ChangeThemeIconButton(),
          ],
        ),
        body: DragAndDropLists(
          lastItemTargetHeight: 50,
          addLastItemTargetHeightToTop: true,
          listPadding: const EdgeInsets.all(16),
          listInnerDecoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20)),
          onItemReorder: onReorderListItem,
          onListReorder: onReorderList,
          children: lists,
          itemDivider: Divider(
            thickness: 2,
            height: 2,
            color: Theme.of(context).cardColor,
          ),
          itemDragHandle: buildDragHandle(),
        ));
  }

  DragAndDropList buildList(DraggableList e) => DragAndDropList(
        header: AppBar(
          automaticallyImplyLeading: false,

          //padding: const EdgeInsets.all(8),
          title: Text(
            e.header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
          ),
          actions: <Widget>[
            e.header != "Days Off"
                ? IconButton(
                    icon: const Icon(
                      Icons.watch_later_outlined,
                    ),
                    onPressed: () {
                      openDialog(e.header);
                    })
                : Container(),
          ],
        ),
        children: e.items
            .map((e) => DragAndDropItem(
                    child: ListTile(
                  title: Text(e.title),
                  onTap: () {
                    debugPrint("ewwwwwwwwwwwwwwwwww " + e.title);
                  },
                )))
            .toList(),
      );

  void onReorderListItem(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;
      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(int oldListIndex, int newListIndex) {}

  DragHandle buildDragHandle({bool isList = false}) {
    //top for the list center for items
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.deepPurple : Theme.of(context).primaryColor;
    return DragHandle(
        verticalAlignment: verticalAlignment,
        child: Container(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.drag_handle,
            color: color,
          ),
        ));
  }

  nextButton() {
    debugPrint(lists.map((e) => e.children).toList().toString());
  }

  openDialog(String header) {
    if (header == 'Days On (full session)') {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Add works time for full session"),
                content: SizedBox(
                    height: 300,
                    child: Column(children: [
                      const Text("First Session"),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Start Time",
                                  hintText: _startTime,
                                  suffixIcon: IconButton(
                                    icon:
                                        const Icon(Icons.watch_later_outlined),
                                    onPressed: () {
                                      _getTimeFromUser(isStartTime: true);
                                    },
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "End Time",
                                  hintText: _endTime,
                                  suffixIcon: IconButton(
                                    icon:
                                        const Icon(Icons.watch_later_outlined),
                                    onPressed: () {
                                      _getTimeFromUser(isStartTime: false);
                                    },
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Second Session"),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Start Time",
                                  hintText: _startTime,
                                  suffixIcon: const Icon(
                                    Icons.watch_later_outlined,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "End Time",
                                  hintText: _endTime,
                                  suffixIcon: const Icon(
                                    Icons.watch_later_outlined,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Service duration",
                            hintText: _startTime,
                            suffixIcon: const Icon(
                              Icons.watch_later_outlined,
                            )),
                      ),
                    ])),
                actions: [
                  IconButton(
                      onPressed: () {
                        debugPrint('hh');
                      },
                      icon: const Icon(Icons.ac_unit))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Add works time for single session"),
                content: SizedBox(
                    height: 300,
                    child: Column(children: [
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Start Time",
                            hintText: _startTime,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.watch_later_outlined),
                              onPressed: () {
                                _getTimeFromUser(isStartTime: true);
                              },
                            )),
                      ),
                    ])),
                actions: [
                  IconButton(
                      onPressed: () {
                        debugPrint('hh');
                      },
                      icon: const Icon(Icons.ac_unit))
                ],
              ));
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      debugPrint("Time canceled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}
