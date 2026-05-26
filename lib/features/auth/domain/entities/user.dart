import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String visitorID;
  final String fullName;
  final String userName;
  final String phoneNumber;
  final String email;
  final int schoolSpecializationID;
  final int specializationID;
  final String? schoolSpecializationName;
  final String? specializationName;
  final String? image;

  const User({
    required this.visitorID,
    required this.fullName,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.schoolSpecializationID,
    required this.specializationID,
    this.schoolSpecializationName,
    this.specializationName,
    this.image,
  });

  @override
  List<Object?> get props => [
    visitorID,
    fullName,
    userName,
    phoneNumber,
    email,
    schoolSpecializationID,
    specializationID,
    schoolSpecializationName,
    specializationName,
    image,
  ];
}
