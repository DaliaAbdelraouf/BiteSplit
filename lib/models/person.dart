class Person {
  final String name;
  final String id;

  Person({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      id: json['id'],
    );
  }
}

