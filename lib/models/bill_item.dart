class BillItem {
  String name;
  double price;
  List<String> assignedTo;
  int count;

  BillItem({
    required this.name,
    required this.price,
    required this.assignedTo,
    this.count = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'assignedTo': assignedTo,
    };
  }

  factory BillItem.fromJson(Map<String, dynamic> json) {
    return BillItem(
      name: json['name'],
      price: json['price'],
      assignedTo: List<String>.from(json['assignedTo']),
    );
  }
}

