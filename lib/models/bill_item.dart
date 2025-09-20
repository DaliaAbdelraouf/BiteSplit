class BillItem {
  final String name;
  final double price;
  final List<String> assignedTo;

  BillItem({
    required this.name,
    required this.price,
    required this.assignedTo,
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

