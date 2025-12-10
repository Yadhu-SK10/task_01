class ApiResponse {
  bool success;
  Data? data;
  String? error;

  ApiResponse({
    required this.success,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    success: json['success'] ?? false,
    data: json['data'] != null ? Data.fromJson(json['data']) : null,
    error: json['error'],
  );
}

class Data {
  User user;
  String message;

  Data({
    required this.user,
    required this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json['user']),
    message: json['message'] ?? '',
  );
}

class User {
  int userId;
  String name;
  int age;
  String profession;
  String profileImage;

  User({
    required this.userId,
    required this.name,
    required this.age,
    required this.profession,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['user_id'] ?? 0,
    name: json['name'] ?? 'N/A',
    age: json['age'] ?? 0,
    profession: json['profession'] ?? 'N/A',
    profileImage: json['profile_image'] ?? '',
  );
}