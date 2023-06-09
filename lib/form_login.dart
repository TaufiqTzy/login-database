import 'dart:convert';
import 'package:absensi_mobile/main_menu.dart';
import 'package:absensi_mobile/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nobpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  void showHidePassword() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  Future<void> login() async {
    final nobp = nobpController.text;
    final password = passwordController.text;

    final response = await http.post(
      Uri.parse("http://192.168.56.1/absensi/login.php"),
      body: {"nobp": nobp, "password": password},
    );

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    if (value == 1) {
      final nobp = data['nobp'];
      savePref(value, nobp);
      print(message);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenu(() {
          // Fungsi untuk logout atau tindakan setelah sign out
        })),
      );
    } else {
      print(message);
    }


    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainMenu()),);
  }

  Future<void> savePref(int value, String nama) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("value", value);
    await preferences.setString("nama", nama);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nobpController,
              decoration: const InputDecoration(
                labelText: "No BP",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Isi No BP dengan valid";
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              obscureText: _secureText,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: showHidePassword,
                  icon: Icon(
                    _secureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Isi Password dengan valid";
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: login,
              
              child: const Text("Login"),
            ),
             TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: const Text("Register"),
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
// import 'package:absensi_mobile/main_menu.dart';
// import 'package:absensi_mobile/register.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class  Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _loginState();
// }

// enum LoginStatus { notSignIn, signIn }

// class _loginState extends State<Login> {
//   LoginStatus _loginStatus = LoginStatus.notSignIn;
//   String? nobp, password;
//   final _key = new GlobalKey<FormState>();

//   bool _secureText = true;

//   showHide(){
//     setState(() {
//       _secureText = !_secureText;
//    });
//   }

//   check() {
//    final form = _key.currentState;
//    if (form != null && form.validate()) {
//      form.save();
//      login();
//    }
//  }

//   login() async {
//    final response = await http.post("http://192.168.56.1/absensi/login.php",
//        body: {"nobp":nobp,"password": password});
//    final data = jsonDecode(response.body);
//    int value = data['value'];
//    String pesan = data['message'];
//    String nama = data['username'];
//   //  String namaAPI = data['nama'];
//   //  String nobp = data['nobp'];
//    if (value == 1) {
//      setState(() {
//        _loginStatus = LoginStatus.signIn;
//        savePref(value, nama);
//      });
//      print(pesan);
//    } else {
//      print(pesan);
//    }
//  }

//  savePref(int value, String nama) async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    setState(() {
//      preferences.setInt("value", value);
//      preferences.setString("nama", nama);
//     //  preferences.setString("email", email);
//     //  preferences.setString("id", id);
//      preferences.commit();
//    });
//  }

//  var value;
//  getPref() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    setState(() {
//      value = preferences.getInt("value");

//      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
//    });
//  }

//  signOut() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    setState(() {
//      preferences.setInt("value", null);
//      preferences.commit();
//      _loginStatus = LoginStatus.notSignIn;
//    });
//  }

//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    getPref();
//  }

//   @override
//   Widget build(BuildContext context) {
//     switch (_loginStatus) {
//      case LoginStatus.notSignIn:
//       return Scaffold(
//         body: Container(
//           child: Card(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Form(
//                 key: _key,
//                 child: Column(
//                   children: <Widget>[
//                     TextFormField(
//                       validator: (e){
//                         if(e != null && e.isEmpty){
//                           return "isi no bp dengan valid";
//                         }

//                       },
//                       onSaved: (e) => nobp = e,
//                     ),
//                     TextFormField(
//                       obscureText: _secureText,
//                       onSaved: (e) => password = e,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         suffixIcon: IconButton(
//                           onPressed: showHide,
//                           icon: Icon(_secureText
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                         ),
//                       ),
//                     ),
//                     MaterialButton(
//                       onPressed: () {
//                         check();
//                       },
//                       child: Text("Login"),
//                     ),
//                     MaterialButton(
//                       onPressed: (){
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Register()));
//                       },
//                       child: Text("Register"),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//       break;
//      case LoginStatus.signIn:
//        return MainMenu(signOut);
//        break;
//     }
//   }
// }