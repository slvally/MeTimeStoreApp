import 'dart:convert';

Produk produkFromJson(String str) => Produk.fromJson(json.decode(str));

String produkToJson(Produk data) => json.encode(data.toJson());

class Produk {
  Produk({
    required this.deskripsi,
    required this.gambar,
    required this.harga,
    required this.namaProduk,
    required this.rating,
    required this.reviews,
    required this.selled,
    required this.quantity,
    required this.check,
  });
  String deskripsi;
  String gambar;
  int harga;
  String namaProduk;
  double rating;
  int reviews;
  int selled;
  int quantity;
  bool check;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        deskripsi: json["deskripsi"],
        gambar: json["gambar"],
        harga: json["harga"],
        namaProduk: json["nama_produk"],
        rating: json["rating"].toDouble(),
        reviews: json["reviews"],
        selled: json["selled"],
        quantity: json["quantity"],
        check: json["check"],
      );

  Map<String, dynamic> toJson() => {
        "deskripsi": deskripsi,
        "gambar": gambar,
        "harga": harga,
        "nama_produk": namaProduk,
        "rating": rating,
        "reviews": reviews,
        "selled": selled,
        "quantity": quantity,
        "check": check,
      };
}
