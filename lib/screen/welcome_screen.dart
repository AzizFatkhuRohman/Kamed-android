import 'package:flutter/material.dart';
import 'package:kamed/screen/login_screen.dart';
import 'package:kamed/utils/colors.dart';
// import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/kamed.png"),
              fit: BoxFit.cover
              )
            ),
          )
          ),
         Expanded(
  child: GestureDetector(
    onTap: () {
      // Kode yang akan dijalankan ketika widget di-tap
      // Contoh: Navigasi ke halaman baru
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Teks berada di tengah tombol
      children: <Widget>[
        Icon(
        Icons.play_arrow,
        color: primaryColor,
        size: 24,
      ),
        Container(
          width: 350,
          height: 60,
          margin: EdgeInsets.only(top: 20), // Beri margin top
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: blueColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Teks berada di tengah tombol
            children: <Widget>[
              Text(
                "Mulai berpetualang",
                style:
                  TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
)

        ],
      ),
    );
  }
}