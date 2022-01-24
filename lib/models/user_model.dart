class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? password;

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.password});

  // data from server

  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      password: map['password'],
    );
  }

  //sending data to server
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'password': password,
    };
  }


}