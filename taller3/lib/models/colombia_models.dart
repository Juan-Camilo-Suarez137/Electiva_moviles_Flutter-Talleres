class President {
  final int id;
  final String name;
  final String lastName;
  final String image;
  final String? description;

  President({required this.id, required this.name, required this.lastName, required this.image, this.description});

  factory President.fromJson(Map<String, dynamic> json) => President(
    id: json['id'],
    name: json['name'] ?? '',
    lastName: json['lastName'] ?? '',
    image: json['image'] ?? 'https://via.placeholder.com/150',
    description: json['description'],
  );
}

class GenericItem {
  final int id;
  final String name;

  GenericItem({required this.id, required this.name});

  factory GenericItem.fromJson(Map<String, dynamic> json) => GenericItem(
    id: json['id'],
    name: json['name'] ?? '',
  );
}