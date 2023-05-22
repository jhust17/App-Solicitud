// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solicitud/Models/Solicitud.dart';
import 'package:http/http.dart' as http;
import 'package:solicitud/providers/Puser.dart';

// class Pagesoc extends StatelessWidget {
//   const Pagesoc({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Pagesocd(),
//     );
//   }
// }

class Pagesocd extends StatefulWidget {
  final String solicitud;
  const Pagesocd(this.solicitud, {super.key});

  @override
  State<Pagesocd> createState() => _PagesocdState();
}

class _PagesocdState extends State<Pagesocd> {
  _postsoli() async {
    final url = 'http://192.168.1.3:3000/solicitud';
    final data = {
      "solicitud": widget.solicitud,
      "estado": "Espera",
      "bloque": dropvalB,
      "aula": dropvalA.toString(),
      "tipo": "Ninguno",
      "detalle": "Ninguno",
      "idusuarioapp": listdata[0].id.toString(),
    };
    final body = json.encode(data);

    final response = await http.post(Uri.parse(url),
        body: body, headers: {'Content-Type': 'application/json'});

    print(response.statusCode);
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Color.fromARGB(255, 183, 186, 204),
                title: Icon(
                  Icons.sim_card_alert_outlined,
                  color: Colors.redAccent,
                  size: 50.0,
                ),
                content: Text(
                  "La solicitud fue enviada",
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
      print("Solicitud enviada");
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Color.fromARGB(255, 183, 186, 204),
                title: Icon(
                  Icons.sim_card_alert_outlined,
                  color: Colors.redAccent,
                  size: 50.0,
                ),
                content: Text(
                  "Solicitud no fue enviada",
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
  }

  String dropvalB = 'A';
  int dropvalA = 100;

  fBloque(valueIn) {
    setState(() {
      dropvalB = valueIn.toString();
    });
  }

  fAula(valueIn) {
    setState(() {
      dropvalA = int.parse(valueIn.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: cuerpoP(context, dropvalB, fBloque, dropvalA, fAula, _postsoli));
  }
}

Widget cuerpoP(BuildContext context, String dropvalB, b(valueIn), int dropvalA,
    a(valuein), post()) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
          0.1,
          0.6,
          1
        ],
            colors: [
          Color.fromARGB(255, 52, 64, 235),
          Color.fromARGB(255, 98, 125, 245),
          Color.fromARGB(255, 146, 154, 224)
        ])),
    padding: EdgeInsets.only(top: 90.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          bloque(dropvalB, b),
          aula(dropvalA, a),
          botonS(post),
          botonR(context)
        ]),
  );
}

Widget bloque(String dropval, f(valuein)) {
  List<String> listaBloque = ['A', 'B', 'C', 'D', 'E'];
  // List al = [];
  // al.add(listaBloque);
  return Container(
    // ignore: prefer_const_literals_to_create_immutables
    margin: EdgeInsets.all(20.0),
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
              Color.fromARGB(255, 102, 2, 105),
              Color.fromARGB(255, 167, 31, 155),
              Color.fromARGB(255, 236, 96, 218)
            ])),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(
              "Bloque",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: DropdownButtonFormField(
              dropdownColor: Color.fromARGB(255, 142, 145, 194),
              items: listaBloque.map((val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(val),
                );
              }).toList(),
              icon: Icon(Icons.view_compact),
              iconEnabledColor: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              isExpanded: true,
              iconSize: 25.0,
              elevation: 16,
              onChanged: f,
              value: dropval,
            ),
          )
        ]),
  );
}

Widget aula(int dropavalA, a(valuein)) {
  List<int> listaAula = [100, 101, 102, 103, 104];
  return Container(
    // ignore: prefer_const_literals_to_create_immutables
    margin: EdgeInsets.all(20.0),
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
              Color.fromARGB(255, 102, 2, 105),
              Color.fromARGB(255, 167, 31, 155),
              Color.fromARGB(255, 236, 96, 218)
            ])),
    padding: EdgeInsets.all(15.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(
              "Aula",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: DropdownButtonFormField(
              dropdownColor: Color.fromARGB(255, 142, 145, 194),
              items: listaAula.map((naula) {
                return DropdownMenuItem(
                  value: naula,
                  child: Text(naula.toString()),
                );
              }).toList(),
              icon: Icon(Icons.view_compact),
              iconEnabledColor: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              isExpanded: true,
              iconSize: 25.0,
              elevation: 16,
              onChanged: a,
              value: dropavalA,
            ),
          )
        ]),
  );
}

Widget botonS(post()) {
  return Container(
    padding: EdgeInsets.only(right: 32.0),
    alignment: Alignment.bottomRight,
    child: SizedBox(
      height: 40.0,
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
                  Color.fromARGB(255, 102, 2, 105),
                  Color.fromARGB(255, 167, 31, 155),
                  Color.fromARGB(255, 236, 96, 218)
                ])),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: post,
          child: Text(
            "Solicitar",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    ),
  );
}

Widget botonR(BuildContext context) {
  return Container(
    alignment: AlignmentDirectional.bottomStart,
    child: SizedBox(
      height: 44,
      width: MediaQuery.of(context).size.width / 2,
      // width: 180,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 146, 154, 224), elevation: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.arrow_back_ios_new_rounded),
            SizedBox(
              width: 15,
            ),
            Text(
              "Regresar",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
        onPressed: () => {Navigator.pop(context)},
      ),
    ),
  );
}
