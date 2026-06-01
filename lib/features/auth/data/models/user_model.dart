import 'package:nahj_balagha_flutter/features/auth/data/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.visitorID,
    required super.fullName,
    required super.userName,
    required super.phoneNumber,
    required super.email,
    required super.schoolSpecializationID,
    required super.specializationID,
    super.schoolSpecializationName,
    super.specializationName,
    super.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    visitorID: json['visitorID'] ?? '',
    fullName: json['fullName'] ?? '',
    userName: json['userName'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    email: json['email'] ?? '',
    schoolSpecializationID: json['schoolSpecializationID'] ?? 0,
    specializationID: json['specializationID'] ?? 0,
    schoolSpecializationName: json['schoolSpecializationName'],
    specializationName: json['specializationName'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() {
    return {
      "visitorID": visitorID,
      "fullName": fullName,
      "userName": userName,
      "phoneNumber": phoneNumber,
      "email": email,
      "schoolSpecializationID": schoolSpecializationID,
      "specializationID": specializationID,
      "schoolSpecializationName": schoolSpecializationName,
      "specializationName": specializationName,
      "image": image,
    };
  }
}
