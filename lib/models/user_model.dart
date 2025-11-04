class UserModel {
  final String? profileImage;
  final String name;
  final String userId;
  final String age;
  final String profession;

  UserModel({
    this.profileImage,
    required this.name,
    required this.userId,
    required this.age,
    required this.profession,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['data']?['user'];

    if (user == null) {
      throw Exception('Invalid user data');
    }

    return UserModel(
      profileImage: user['profile_image'] as String?,
      name: user['name'] as String? ?? 'N/A',
      userId: user['user_id']?.toString() ?? 'N/A',
      age: user['age']?.toString() ?? 'N/A',
      profession: user['profession'] as String? ?? 'N/A',
    );
  }
}