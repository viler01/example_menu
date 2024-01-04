class Comanda{
  final List<String?> list;
  final String time;
  final String id;
  final double tableNumber;
 final DateTime createdAt;
 final bool isActive;
 final List<String?> foodNameList;
final List<int> quantityList;
final String request;
bool isGathered;
 List<String>? requestList;
  Comanda({
    required this.isGathered,
    required this.id,
    required this.time,
    required this.list,
    required this.tableNumber,
    required this.createdAt,
    required this.isActive,
    required this.foodNameList,
    required this.quantityList,
    required this.request,
    this.requestList
  });
}