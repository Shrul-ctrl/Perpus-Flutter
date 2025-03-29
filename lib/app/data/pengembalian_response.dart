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
  List<PengembalianDetails>? pengembalianDetails;

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
      this.pengembalianDetails});

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
    if (json['pengembalian_details'] != null) {
      pengembalianDetails = <PengembalianDetails>[];
      json['pengembalian_details'].forEach((v) {
        pengembalianDetails!.add(new PengembalianDetails.fromJson(v));
      });
    }
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
    if (this.pengembalianDetails != null) {
      data['pengembalian_details'] =
          this.pengembalianDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PengembalianDetails {
  int? id;
  int? idPengembalian;
  int? idBuku;
  int? jumlahKembali;
  int? bukuHilang;
  int? bukuRusak;
  String? dendaHilang;
  String? dendaRusak;
  String? dendaKeterlambatan;
  String? createdAt;
  String? updatedAt;
  Buku? buku;

  PengembalianDetails(
      {this.id,
      this.idPengembalian,
      this.idBuku,
      this.jumlahKembali,
      this.bukuHilang,
      this.bukuRusak,
      this.dendaHilang,
      this.dendaRusak,
      this.dendaKeterlambatan,
      this.createdAt,
      this.updatedAt,
      this.buku});

  PengembalianDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPengembalian = json['id_pengembalian'];
    idBuku = json['id_buku'];
    jumlahKembali = json['jumlah_kembali'];
    bukuHilang = json['buku_hilang'];
    bukuRusak = json['buku_rusak'];
    dendaHilang = json['denda_hilang'];
    dendaRusak = json['denda_rusak'];
    dendaKeterlambatan = json['denda_keterlambatan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    buku = json['buku'] != null ? new Buku.fromJson(json['buku']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_pengembalian'] = this.idPengembalian;
    data['id_buku'] = this.idBuku;
    data['jumlah_kembali'] = this.jumlahKembali;
    data['buku_hilang'] = this.bukuHilang;
    data['buku_rusak'] = this.bukuRusak;
    data['denda_hilang'] = this.dendaHilang;
    data['denda_rusak'] = this.dendaRusak;
    data['denda_keterlambatan'] = this.dendaKeterlambatan;
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
