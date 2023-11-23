class Comanda{
  final List<String?> list;
  final String time;
  final String id;
  final double tableNumber;
 final DateTime createdAt;
 final bool isActive;
 final List<String?> foodNameList;
final List<int> quantityList;
  Comanda({
    required this.id,
    required this.time,
    required this.list,
    required this.tableNumber,
    required this.createdAt,
    required this.isActive,
    required this.foodNameList,
    required this.quantityList
  });
}