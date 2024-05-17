class PatientModel {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? uId;
  String? image;
  String? cover;
  int? age;

  PatientModel({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.uId,
    this.image,
    this.cover,
    this.age,
  });
  PatientModel.fromjason(Map<String, dynamic> jason) {
    name = jason['name'];
    phone = jason['phone'];
    email = jason['email'];
    password = jason['password'];
    uId = jason['uId'];
    age = jason['age'];
    image = jason['image'];
    cover = jason['cover'];
  }
  Map<String, dynamic> toJason() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'uId': uId,
      'image': image,
      'cover': cover,
      'age': age,
    };
  }
}
