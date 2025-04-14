class BukuResponse {
  bool? success;
  String? message;
  List<Bukus>? bukus;

  BukuResponse({this.success, this.message, this.bukus});

  BukuResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['bukus'] != null) {
      bukus = <Bukus>[];
      json['bukus'].forEach((v) {
        bukus!.add(new Bukus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.bukus != null) {
      data['bukus'] = this.bukus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bukus {
  int? id;
  String? judul;
  int? isbn;
  int? harga;
  String? deskripsi;
  String? foto;
  Null? filePath;
  int? idPenulis;
  int? idPenerbit;
  int? idKategori;
  String? tahunTerbit;
  int? jumlahBuku;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  Kategori? kategori;
  Penuli? penuli;
  Penerbit? penerbit;

  Bukus(
      {this.id,
      this.judul,
      this.isbn,
      this.harga,
      this.deskripsi,
      this.foto,
      this.filePath,
      this.idPenulis,
      this.idPenerbit,
      this.idKategori,
      this.tahunTerbit,
      this.jumlahBuku,
      this.createdAt,
      this.updatedAt,
      this.imageUrl,
      this.kategori,
      this.penuli,
      this.penerbit});

  Bukus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    isbn = json['isbn'];
    harga = json['harga'];
    deskripsi = json['deskripsi'];
    foto = json['foto'];
    filePath = json['file_path'];
    idPenulis = json['id_penulis'];
    idPenerbit = json['id_penerbit'];
    idKategori = json['id_kategori'];
    tahunTerbit = json['tahun_terbit'];
    jumlahBuku = json['jumlah_buku'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
    kategori = json['kategori'] != null
        ? new Kategori.fromJson(json['kategori'])
        : null;
    penuli =
        json['penuli'] != null ? new Penuli.fromJson(json['penuli']) : null;
    penerbit = json['penerbit'] != null
        ? new Penerbit.fromJson(json['penerbit'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['isbn'] = this.isbn;
    data['harga'] = this.harga;
    data['deskripsi'] = this.deskripsi;
    data['foto'] = this.foto;
    data['file_path'] = this.filePath;
    data['id_penulis'] = this.idPenulis;
    data['id_penerbit'] = this.idPenerbit;
    data['id_kategori'] = this.idKategori;
    data['tahun_terbit'] = this.tahunTerbit;
    data['jumlah_buku'] = this.jumlahBuku;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    if (this.kategori != null) {
      data['kategori'] = this.kategori!.toJson();
    }
    if (this.penuli != null) {
      data['penuli'] = this.penuli!.toJson();
    }
    if (this.penerbit != null) {
      data['penerbit'] = this.penerbit!.toJson();
    }
    return data;
  }
}

class Kategori {
  int? id;
  String? namaKategori;
  String? createdAt;
  String? updatedAt;

  Kategori({this.id, this.namaKategori, this.createdAt, this.updatedAt});

  Kategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKategori = json['nama_kategori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kategori'] = this.namaKategori;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Penuli {
  int? id;
  String? namaPenulis;
  String? createdAt;
  String? updatedAt;

  Penuli({this.id, this.namaPenulis, this.createdAt, this.updatedAt});

  Penuli.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPenulis = json['nama_penulis'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_penulis'] = this.namaPenulis;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Penerbit {
  int? id;
  String? namaPenerbit;
  String? alamat;
  String? createdAt;
  String? updatedAt;

  Penerbit(
      {this.id,
      this.namaPenerbit,
      this.alamat,
      this.createdAt,
      this.updatedAt});

  Penerbit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPenerbit = json['nama_penerbit'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_penerbit'] = this.namaPenerbit;
    data['alamat'] = this.alamat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
