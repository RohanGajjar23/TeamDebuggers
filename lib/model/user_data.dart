class UserData {
  late String name;
  late String email;
  late String phoneNumber;
  late String photoUrl;
  late String dob;
  late String role;
  late String publicId;
  late String privateId;
  late String uid;

  UserData({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.dob,
    required this.role,
    required this.publicId,
    required this.privateId,
    required this.uid,
  });

  // map to UserData object
  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      name: data['name'],
      email: data['email'],
      photoUrl: data['photoUrl'],
      dob: data['dob'],
      role: data['role'],
      publicId: data['publicId'],
      uid: data['uid'],
      privateId: data['privateId'],
    );
  }

  //UserData Object to map or json
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'dob': dob,
      'role': role,
      'publicId': publicId,
      'privateId': privateId,
      'uid': uid,
    };
  }
}
