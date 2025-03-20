class PengembalianResponse {
  bool? success;
  String? message;
  List<Pengembalians>? pengembalians;

  PengembalianResponse({this.success, this.message, this.pengembalians});

  PengembalianResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['pengembalians'] != null) {
      pengembalians = <Pengembalians>[];
      json['pengembalians'].forEach((v) {
        pengembalians!.add(new Pengembalians.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.pengembalians != null) {
      data['pengembalians'] =
          this.pengembalians!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pengembalians {
  int? id;
  int? idUser;
  int? idPeminjaman;
  String? tanggalPenggembalian;
  int? denda;
  String? statusDenda;
  String? statusKembali;
  Null? alasanKembali;
  String? createdAt;
  String? updatedAt;
  User? user;
  Peminjaman? peminjaman;

  Pengembalians(
      {this.id,
      this.idUser,
      this.idPeminjaman,
      this.tanggalPenggembalian,
      this.denda,
      this.statusDenda,
      this.statusKembali,
      this.alasanKembali,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.peminjaman});

  Pengembalians.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idPeminjaman = json['id_peminjaman'];
    tanggalPenggembalian = json['tanggal_penggembalian'];
    denda = json['denda'];
    statusDenda = json['status_denda'];
    statusKembali = json['status_kembali'];
    alasanKembali = json['alasan_kembali'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    peminjaman = json['peminjaman'] != null
        ? new Peminjaman.fromJson(json['peminjaman'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_peminjaman'] = this.idPeminjaman;
    data['tanggal_penggembalian'] = this.tanggalPenggembalian;
    data['denda'] = this.denda;
    data['status_denda'] = this.statusDenda;
    data['status_kembali'] = this.statusKembali;
    data['alasan_kembali'] = this.alasanKembali;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.peminjaman != null) {
      data['peminjaman'] = this.peminjaman!.toJson();
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

class Peminjaman {
  int? id;
  String? noPeminjaman;
  int? idUser;
  int? idStaff;
  int? idSiswa;
  String? tanggalPinjam;
  String? batasPinjam;
  String? statusPinjam;
  Null? alasanPinjam;
  String? createdAt;
  String? updatedAt;

  Peminjaman(
      {this.id,
      this.noPeminjaman,
      this.idUser,
      this.idStaff,
      this.idSiswa,
      this.tanggalPinjam,
      this.batasPinjam,
      this.statusPinjam,
      this.alasanPinjam,
      this.createdAt,
      this.updatedAt});

  Peminjaman.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noPeminjaman = json['no_peminjaman'];
    idUser = json['id_user'];
    idStaff = json['id_staff'];
    idSiswa = json['id_siswa'];
    tanggalPinjam = json['tanggal_pinjam'];
    batasPinjam = json['batas_pinjam'];
    statusPinjam = json['status_pinjam'];
    alasanPinjam = json['alasan_pinjam'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_peminjaman'] = this.noPeminjaman;
    data['id_user'] = this.idUser;
    data['id_staff'] = this.idStaff;
    data['id_siswa'] = this.idSiswa;
    data['tanggal_pinjam'] = this.tanggalPinjam;
    data['batas_pinjam'] = this.batasPinjam;
    data['status_pinjam'] = this.statusPinjam;
    data['alasan_pinjam'] = this.alasanPinjam;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
