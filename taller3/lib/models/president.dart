class President {
  final int id;
  final String name;
  final String lastName;
  final String image;
  final String description;

  President({
    required this.id,
    required this.name,
    required this.lastName,
    required this.image,
    required this.description,
  });

  factory President.fromJson(Map<String, dynamic> json) {
    return President(
      id: json['id'],
      name: json['name'] ?? 'No Name',
      lastName: json['lastName'] ?? '',
      image: json['image'] ?? 'https://via.placeholder.com/150',
      description: json['description'] ?? 'Sin descripción disponible',
    );
  }
}