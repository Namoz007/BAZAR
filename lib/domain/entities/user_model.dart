
class UserModel {
  final String id;
  String fullName;
  String email;
  String? gender;
  DateTime? birthday;
  String? phoneNumber;
  String? imgUrl;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.gender,
    this.birthday,
    this.phoneNumber,
    this.imgUrl,
  });
}
