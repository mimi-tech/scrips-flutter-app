
class NewUser {


  String email;
  String password;
  String token;

  NewUser({

    this.email,
    this.password,
    this.token



  });
  // now create converter

  factory NewUser.fromJson(Map<String,dynamic> responseData){
    return NewUser(
      email : responseData['email'],
      password: responseData['password'],
      token: responseData['token'],

    );
  }
  Map<String, dynamic> toJson() {
    return {

      "email": email,
      "password": password,
      "token": token,

    };
}}