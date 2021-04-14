class User {
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  final String phoneNum;

  User({this.id, this.fullName, this.email, this.userRole, this.phoneNum});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        phoneNum = data['phone'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'phone': phoneNum,
    };
  }
}
