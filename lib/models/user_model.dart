class DoctorModel {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? uId;
  String? image;
  String? cover;
  String? specialization;
  int? age;

  DoctorModel({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.uId,
    this.image,
    this.cover,
    this.specialization,
    this.age,
  });
  DoctorModel.fromjason(Map<String, dynamic> jason) {
    name = jason['name'];
    phone = jason['phone'];
    email = jason['email'];
    password = jason['password'];
    uId = jason['uId'];
    age = jason['age'];
    image = jason['image'];
    cover = jason['cover'];
    specialization = jason['specialization'];
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
      'specialization': specialization,
      'age': age,
    };
  }
}
