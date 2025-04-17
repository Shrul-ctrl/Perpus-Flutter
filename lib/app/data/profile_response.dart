class ProfileResponse {
  bool? success;
  String? message;
  Profiles? profiles;

  ProfileResponse({this.success, this.message, this.profiles});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    profiles = json['profiles'] != null
        ? new Profiles.fromJson(json['profiles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.toJson();
    }
    return data;
  }
}

class Profiles {
  int? id;
  String? name;
  int? isActivated;
  String? email;
  Null? emailVerifiedAt;
  String? isAdmin;
  String? fotoprofile;
  String? createdAt;
  String? updatedAt;
  Siswa? siswa;

  Profiles(
      {this.id,
      this.name,
      this.isActivated,
      this.email,
      this.emailVerifiedAt,
      this.isAdmin,
      this.fotoprofile,
      this.createdAt,
      this.updatedAt,
      this.siswa});

  Profiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActivated = json['is_activated'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isAdmin = json['isAdmin'];
    fotoprofile = json['fotoprofile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    siswa = json['siswa'] != null ? new Siswa.fromJson(json['siswa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_activated'] = this.isActivated;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['isAdmin'] = this.isAdmin;
    data['fotoprofile'] = this.fotoprofile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.siswa != null) {
      data['siswa'] = this.siswa!.toJson();
    }
    return data;
  }
}

class Siswa {
  int? id;
  int? idUser;
  String? alamat;
  String? noHp;
  String? kelas;
  String? nis;
  String? createdAt;
  String? updatedAt;

  Siswa(
      {this.id,
      this.idUser,
      this.alamat,
      this.noHp,
      this.kelas,
      this.nis,
      this.createdAt,
      this.updatedAt});

  Siswa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    kelas = json['kelas'];
    nis = json['nis'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['alamat'] = this.alamat;
    data['no_hp'] = this.noHp;
    data['kelas'] = this.kelas;
    data['nis'] = this.nis;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
