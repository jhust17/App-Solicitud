// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solicitud/providers/Puser.dart';
import 'package:solicitud/pages/support.dart';
import 'package:solicitud/pages/home.dart';
import 'package:http/http.dart' as http;

import 'Models/Usuario.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      initialRoute: '/',
      routes: {
        // Cuando naveguemos hacia la ruta "/", crearemos el Widget FirstScreen
        '/': (context) => Inicio(),
        // Cuando naveguemos hacia la ruta "/second", crearemos el Widget SecondScreen
        '/Cliente': (context) => Home(),
        '/Soporte': (context) => Support(),
      },
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  TextEditingController usercontrol = new TextEditingController();
  TextEditingController passcontrol = new TextEditingController();
  String valueUser = '';
  String valuePass = '';
  _postvalidacion() async {
    valueUser = usercontrol.text != '' ? usercontrol.text : '';
    valuePass = passcontrol.text != '' ? passcontrol.text : '';
    if (valuePass != '' || valueUser != '') {
      Usuario userapp = Usuario(0, '');
      final url = 'http://192.168.1.3:3000/userv';
      final data = {"user": valueUser, "password": valuePass};
      final body = json.encode(data);

      final response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      print(response.statusCode);
      if (response.statusCode == 200) {
        var datos = utf8.decode(response.bodyBytes);
        final userdata = jsonDecode(datos);
        print(userdata);
        if (userdata.length == 0) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Color.fromARGB(255, 183, 186, 204),
                    title: Icon(
                      Icons.sim_card_alert_outlined,
                      color: Color.fromARGB(255, 201, 0, 0),
                      size: 50.0,
                    ),
                    content: Text(
                      "El user o password estan incorrectos",
                      style: TextStyle(fontSize: 20),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ok",
                            style: TextStyle(
                                color: Color.fromARGB(255, 19, 15, 221),
                                fontSize: 18.0),
                          ))
                    ],
                  ));
          print("Datos incorrectos");
        }

        for (var item in userdata) {
          userapp = new Usuario(item["id"], item["rol"]);
          listdata.insert(0, userapp);
          print(listdata[0].id);
        }
        if (userapp.rol == "Cliente") {
          Navigator.pushNamed(context, '/Cliente');
        } else if (userapp.rol == "Soporte") {
          Navigator.pushNamed(context, '/Soporte');
        }
      }
      usercontrol.text = '';
      passcontrol.text = '';
    }
    if (valueUser == '' || valuePass == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Color.fromARGB(255, 183, 186, 204),
                title: Icon(
                  Icons.sim_card_alert_outlined,
                  color: Color.fromARGB(255, 201, 0, 0),
                  size: 50.0,
                ),
                content: Text(
                  "Los campos estan vacios",
                  style: TextStyle(fontSize: 20),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "ok",
                        style: TextStyle(
                            color: Color.fromARGB(255, 19, 15, 221),
                            fontSize: 18.0),
                      ))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        body: cuerpo(usercontrol, passcontrol, _postvalidacion, context));
  }
}

Widget cuerpo(TextEditingController userc, TextEditingController passc, fdata(),
    context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    child: Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height / 2 + 50,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.1,
                      0.6,
                      1
                    ],
                    colors: [
                      Color.fromARGB(255, 36, 42, 78),
                      Color.fromARGB(255, 50, 72, 168),
                      Color.fromARGB(255, 86, 163, 235)
                    ])),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Icon(
                  Icons.account_box_outlined,
                  size: 80,
                  color: Colors.white,
                ),
                nombre(),
                SizedBox(
                  height: 50,
                ),
                campoUsuario(userc),
                SizedBox(
                  height: 10,
                ),
                campoContra(passc),
              ],
            )),
        botonEntrar(fdata),
        SizedBox(height: 16)
      ],
    )),
  );
}

Widget nombre() {
  return Text(
    "Sign in",
    style: TextStyle(
        color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),
  );
}

Widget campoUsuario(TextEditingController userc) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      autofocus: true,
      controller: userc,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 10,
                color: Color.fromARGB(0, 0, 0, 0),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(80))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(80))),
          prefixIcon: Icon(Icons.account_circle_outlined),
          hintText: "User",
          fillColor: Colors.white,
          filled: true),
    ),
  );
}

Widget campoContra(TextEditingController passc) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: passc,
      obscureText: true,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 10,
                color: Color.fromARGB(0, 0, 0, 0),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(80))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(80))),
          prefixIcon: Icon(Icons.lock_outline),
          hintText: "Password",
          fillColor: Colors.white,
          filled: true),
    ),
  );
}

Widget botonEntrar(f()) {
  return Container(
    // padding: EdgeInsets.only(bottom: 16),
    alignment: Alignment.topCenter,
    child: SizedBox(
      height: 50.0,
      width: 140.0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                stops: [
                  0.1,
                  0.6,
                  1
                ],
                colors: [
                  Color.fromARGB(255, 33, 2, 105),
                  Color.fromARGB(255, 31, 45, 167),
                  Color.fromARGB(255, 98, 96, 236)
                ])),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: f,
          child: Text(
            "Login",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
