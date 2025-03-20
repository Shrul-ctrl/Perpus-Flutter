class KoleksiResponse {
  bool? success;
  String? message;
  List<Kolekasis>? kolekasis;

  KoleksiResponse({this.success, this.message, this.kolekasis});

  KoleksiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['kolekasis'] != null) {
      kolekasis = <Kolekasis>[];
      json['kolekasis'].forEach((v) {
        kolekasis!.add(new Kolekasis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.kolekasis != null) {
      data['kolekasis'] = this.kolekasis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Kolekasis {
  int? id;
  int? idUser;
  int? idBuku;
  String? statusDisukai;
  String? createdAt;
  String? updatedAt;
  User? user;
  Buku? buku;

  Kolekasis(
      {this.id,
      this.idUser,
      this.idBuku,
      this.statusDisukai,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.buku});

  Kolekasis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idBuku = json['id_buku'];
    statusDisukai = json['status_disukai'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    buku = json['buku'] != null ? new Buku.fromJson(json['buku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_buku'] = this.idBuku;
    data['status_disukai'] = this.statusDisukai;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.buku != null) {
      data['buku'] = this.buku!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  int? isActivated;
  String? email;
  Null? emailVerifiedAt;
  String? isAdmin;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.isActivated,
      this.email,
      this.emailVerifiedAt,
      this.isAdmin,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActivated = json['is_activated'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isAdmin = json['isAdmin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_activated'] = this.isActivated;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['isAdmin'] = this.isAdmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Buku {
  int? id;
  String? judul;
  int? isbn;
  int? harga;
  String? deskripsi;
  String? foto;
  int? idPenulis;
  int? idPenerbit;
  int? idKategori;
  String? tahunTerbit;
  int? jumlahBuku;
  String? createdAt;
  String? updatedAt;

  Buku(
      {this.id,
      this.judul,
      this.isbn,
      this.harga,
      this.deskripsi,
      this.foto,
      this.idPenulis,
      this.idPenerbit,
      this.idKategori,
      this.tahunTerbit,
      this.jumlahBuku,
      this.createdAt,
      this.updatedAt});

  Buku.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    isbn = json['isbn'];
    harga = json['harga'];
    deskripsi = json['deskripsi'];
    foto = json['foto'];
    idPenulis = json['id_penulis'];
    idPenerbit = json['id_penerbit'];
    idKategori = json['id_kategori'];
    tahunTerbit = json['tahun_terbit'];
    jumlahBuku = json['jumlah_buku'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['isbn'] = this.isbn;
    data['harga'] = this.harga;
    data['deskripsi'] = this.deskripsi;
    data['foto'] = this.foto;
    data['id_penulis'] = this.idPenulis;
    data['id_penerbit'] = this.idPenerbit;
    data['id_kategori'] = this.idKategori;
    data['tahun_terbit'] = this.tahunTerbit;
    data['jumlah_buku'] = this.jumlahBuku;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
