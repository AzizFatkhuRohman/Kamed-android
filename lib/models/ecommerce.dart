import 'package:cloud_firestore/cloud_firestore.dart';

class Jual {
  final String deskripsi;
  final String namaBarang;
  final String hargaBarang;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  const Jual(
      {
      required this.deskripsi,
      required this.namaBarang,
      required this.hargaBarang,
      required this.uid,
      required this.username,
      required this.likes,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      });

  static Jual fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Jual(
      deskripsi: snapshot["deskripsi"],
      namaBarang: snapshot["namaBarang"],
      hargaBarang: snapshot["hargaBarang"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage']
    );
  }

   Map<String, dynamic> toJson() => {
        "deskripsi": deskripsi,
        "namaBarang": namaBarang,
        "hargaBarang": hargaBarang,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}