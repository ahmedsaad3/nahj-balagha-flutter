import 'package:equatable/equatable.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<T> call({required Parameters params});
}

class NoParameter extends Equatable {
  const NoParameter();

  @override
  List<Object> get props => [];
}

class SignupParams extends Equatable {
  final String fullName;
  final String userName;
  final String phoneNumber;
  final String email;
  final String password;
  final String address;
  final String tokenNotification;
  final int specializationID;
  final int schoolSpecializationID;
  final List<Map<String, dynamic>> interests;

  const SignupParams({
    required this.fullName,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.address,
    required this.tokenNotification,
    required this.specializationID,
    required this.schoolSpecializationID,
    required this.interests,
  });

  @override
  List<Object?> get props => [
    fullName,
    userName,
    phoneNumber,
    email,
    password,
    address,
    tokenNotification,
    specializationID,
    schoolSpecializationID,
    interests,
  ];

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "userName": userName,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
      "cardID": "",
      "address": address,
      "tokenNotification": tokenNotification,
      "birthDate": "",
      "specializationID": specializationID,
      "schoolSpecializationID": schoolSpecializationID,
      "interests": interests,
      "imagePath": "",
      "notes": "",
    };
  }
}

class UpdateUserInfoParams extends Equatable {
  final String fullName;
  final String email;
  final int specializationID;
  final int schoolSpecializationID;

  const UpdateUserInfoParams({
    required this.fullName,
    required this.email,
    required this.specializationID,
    required this.schoolSpecializationID,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "specializationID": specializationID,
      "schoolSpecializationID": schoolSpecializationID,
    };
  }

  @override
  List<Object?> get props => [
    fullName,
    email,
    specializationID,
    schoolSpecializationID,
  ];
}

class PaginationParams extends Equatable {
  final int? categoryId;
  final String? searchTerm;
  final String? subjectNameId;
  final int pageNumber;
  final int pageSize;

  const PaginationParams({
    this.categoryId,
    this.searchTerm,
    this.subjectNameId,
    this.pageNumber = 1,
    this.pageSize = 8,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      "PageNumber": pageNumber,
      "PageSize": pageSize,
    };

    if (categoryId != null) {
      map["WorkTypeID"] = categoryId;
    }

    if (searchTerm != null) {
      map["Title"] = searchTerm;
    }

    if (subjectNameId != null) {
      map["SubjectNameID"] = subjectNameId;
    }

    return map;
  }

  @override
  List<Object?> get props => [
    categoryId,
    searchTerm,
    subjectNameId,
    pageNumber,
    pageSize,
  ];
}

class TopicIdParams extends Equatable {
  final String topicId;
  const TopicIdParams({required this.topicId});

  @override
  List<Object?> get props => [topicId];
}
