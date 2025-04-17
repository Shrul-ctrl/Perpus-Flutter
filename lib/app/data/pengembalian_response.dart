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
  String? noPeminjaman;
  String? tanggalPengembalian;
  int? denda;
  String? statusDenda;
  String? statusKembali;
  Null? alasanKembali;
  List<PengembalianDetails>? pengembalianDetails;

  Pengembalians(
      {this.id,
      this.noPeminjaman,
      this.tanggalPengembalian,
      this.denda,
      this.statusDenda,
      this.statusKembali,
      this.alasanKembali,
      this.pengembalianDetails});

  Pengembalians.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noPeminjaman = json['no_peminjaman'];
    tanggalPengembalian = json['tanggal_pengembalian'];
    denda = json['denda'];
    statusDenda = json['status_denda'];
    statusKembali = json['status_kembali'];
    alasanKembali = json['alasan_kembali'];
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
    data['no_peminjaman'] = this.noPeminjaman;
    data['tanggal_pengembalian'] = this.tanggalPengembalian;
    data['denda'] = this.denda;
    data['status_denda'] = this.statusDenda;
    data['status_kembali'] = this.statusKembali;
    data['alasan_kembali'] = this.alasanKembali;
    if (this.pengembalianDetails != null) {
      data['pengembalian_details'] =
          this.pengembalianDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PengembalianDetails {
  String? judulBuku;
  Null? jumlah;
  Null? keterangan;

  PengembalianDetails({this.judulBuku, this.jumlah, this.keterangan});

  PengembalianDetails.fromJson(Map<String, dynamic> json) {
    judulBuku = json['judul_buku'];
    jumlah = json['jumlah'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul_buku'] = this.judulBuku;
    data['jumlah'] = this.jumlah;
    data['keterangan'] = this.keterangan;
    return data;
  }
}
