class PeminjamanResponse {
  bool? success;
  String? message;
  List<Peminjamans>? peminjamans;

  PeminjamanResponse({this.success, this.message, this.peminjamans});

  PeminjamanResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['peminjamans'] != null) {
      peminjamans = <Peminjamans>[];
      json['peminjamans'].forEach((v) {
        peminjamans!.add(new Peminjamans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.peminjamans != null) {
      data['peminjamans'] = this.peminjamans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Peminjamans {
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
  List<PeminjamanDetails>? peminjamanDetails;

  Peminjamans(
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
      this.updatedAt,
      this.peminjamanDetails});

  Peminjamans.fromJson(Map<String, dynamic> json) {
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
    if (json['peminjaman_details'] != null) {
      peminjamanDetails = <PeminjamanDetails>[];
      json['peminjaman_details'].forEach((v) {
        peminjamanDetails!.add(new PeminjamanDetails.fromJson(v));
      });
    }
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
    if (this.peminjamanDetails != null) {
      data['peminjaman_details'] =
          this.peminjamanDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PeminjamanDetails {
  int? id;
  int? idPeminjaman;
  int? idBuku;
  int? jumlahPinjam;
  String? createdAt;
  String? updatedAt;
  Buku? buku;

  PeminjamanDetails(
      {this.id,
      this.idPeminjaman,
      this.idBuku,
      this.jumlahPinjam,
      this.createdAt,
      this.updatedAt,
      this.buku});

  PeminjamanDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPeminjaman = json['id_peminjaman'];
    idBuku = json['id_buku'];
    jumlahPinjam = json['jumlah_pinjam'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    buku = json['buku'] != null ? new Buku.fromJson(json['buku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_peminjaman'] = this.idPeminjaman;
    data['id_buku'] = this.idBuku;
    data['jumlah_pinjam'] = this.jumlahPinjam;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.buku != null) {
      data['buku'] = this.buku!.toJson();
    }
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
