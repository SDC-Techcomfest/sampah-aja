
class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? address;

  UserModel({this.firstName, this.lastName, this.email, this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    address: json['address']
  );

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'address': address,
  };
}