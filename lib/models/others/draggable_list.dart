class DraggableList {
  final String header;
  final List<DraggableListItem> items;

  const DraggableList({required this.header, required this.items});
}

class DraggableListItem {
  final String title;

  const DraggableListItem({required this.title});
}
