class User {
  final int id;
  final String name;
  final String number;
  final String age;
  final String department;
  final String imageUrl;

  User(
      {required this.id,
      required this.name,
      required this.number,
      required this.age,
      required this.department,
      required this.imageUrl});

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "age": age,
        "department": department,
        "imageUrl": imageUrl
      };

  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      age: json['age'],
      department: json['department'],
      imageUrl: json['imageUrl']);
}
