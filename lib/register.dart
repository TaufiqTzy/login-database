import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? nobp, username, password;
  final _key = GlobalKey<FormState>();

  bool _secureText = true;

  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void check() {
    final form = _key.currentState;
    if (form != null && form.validate()) {
      form.save();
      save();
    }
  }

  void save() async {
    final response = await http.post(
      Uri.parse("http://192.168.56.1/absensi/register.php"),
      body: {
        "nobp": nobp,
        "username": username,
        "password": password,
      },
    );
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              validator: (e) {
                if (e == null || e.isEmpty) {
                  return "Isi nama lengkap";
                }
                return null;
              },
              onSaved: (e) => username = e,
              decoration: InputDecoration(labelText: "Nama Lengkap"),
            ),
            TextFormField(
              validator: (e) {
                if (e == null || e.isEmpty) {
                  return "Isi NBP";
                }
                return null;
              },
              onSaved: (e) => nobp = e,
              decoration: InputDecoration(labelText: "NoBP"),
            ),
            TextFormField(
              obscureText: _secureText,
              onSaved: (e) => password = e,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: showHide,
                  icon: Icon(
                    _secureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:convert';
// // import 'dart:html';
// // import 'dart:math';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Register extends StatefulWidget {
//  @override
//  _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//  String? nobp, username, password;
//  final _key = new GlobalKey<FormState>();

//  bool _secureText = true;

//  showHide() {
//    setState(() {
//      _secureText = !_secureText;
//    });
//  }

//  check() {
//    final form = _key.currentState;
//    if (form != null && form.validate()) {
//      form.save();
//      save();
//    }
//  }

//  save() async {
//    final response = await http.post("http://192.168.56.1/absensi/register.php",
//        body: {"nobp": nobp, "username": username, "password": password});
//    final data = jsonDecode(response.body);
//    int value = data['value'];
//    String pesan = data['message'];
//    if (value == 1) {
//      setState(() {
//        Navigator.pop(context);
//      });
//    } else {
//      print(pesan);
//    }
//  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Register"),
//      ),
//      body: Form(
//        key: _key,
//        child: ListView(
//          padding: EdgeInsets.all(16.0),
//          children: <Widget>[
//            TextFormField(
//              validator: (e) {
//                if (e != null && e.isEmpty) {
//                  return "isi nama lengkap";
//                }
//              },
//              onSaved: (e) => username = e,
//              decoration: InputDecoration(labelText: "Nama Lengkap"),
//            ),
//            TextFormField(
//              validator: (e) {
//                if (e != null && e.isEmpty) {
//                  return "isi nobp";
//                }
//              },
//              onSaved: (e) => nobp = e,
//              decoration: InputDecoration(labelText: "nobp"),
//            ),
//            TextFormField(
//              obscureText: _secureText,
//              onSaved: (e) => password = e,
//              decoration: InputDecoration(
//                labelText: "Password",
//                suffixIcon: IconButton(
//                  onPressed: showHide,
//                  icon: Icon(
//                      _secureText ? Icons.visibility_off : Icons.visibility),
//                ),
//              ),
//            ),
//            MaterialButton(
//              onPressed: () {
//                check();
//              },
//              child: Text("Register"),
//            )
//          ],
//        ),
//      ),
//    );
//  }
// }