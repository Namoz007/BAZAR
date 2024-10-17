import '../../domain/entities/user_model.dart';
class UserDetails extends UserModel {
  UserDetails({
    required super.id,
    required super.email,
    required super.fullName,
    super.gender,
    super.birthday,
    super.phoneNumber,
    super.imgUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      gender: json['gender'],
      birthday: json['birthday'] == null || json['birthday'].toString().isEmpty ? null : DateTime.parse(json['birthday'].toString()),
      phoneNumber: json['phoneNumber'],
      imgUrl: json['imgUrl'] == null || json['imgUrl'].toString().isEmpty ? null : json['imgUrl']
    );
  }


  Map<String,dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "fullName": fullName,
      "gender": gender ?? '',
      "birthday": birthday == null ? '' : birthday.toString(),
      "phoneNumber": phoneNumber ?? '',
      "imgUrl": imgUrl ?? ''
    };
  }
}