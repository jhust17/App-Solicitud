// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solicitud/providers/Puser.dart';

// class Soporte extends StatelessWidget {
//   const Soporte({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Dsoporte(context),
//     );
//   }
// }

class Dsoporte extends StatefulWidget {
  const Dsoporte({super.key});

  @override
  State<Dsoporte> createState() => _DsoporteState();
}

class _DsoporteState extends State<Dsoporte> {
  String dropvalB = 'A';
  String dropvalA = '100';
  String dropvalT = 'Soporte tecnico';
  TextEditingController inputD = new TextEditingController();
  String valueTextf = '';

  fBloque(valueIn) {
    setState(() {
      dropvalB = valueIn.toString();
    });
  }

  fAula(valueIn) {
    setState(() {
      dropvalA = valueIn.toString();
    });
  }

  fTipo(valueIn) {
    setState(() {
      dropvalT = valueIn.toString();
    });
  }

  _postsoli() async {
    valueTextf = inputD.text != '' ? inputD.text : 'Ninguno';
    final url = 'http://192.168.1.3:3000/solicitud';
    final data = {
      "solicitud": "Soporte",
      "estado": "Espera",
      "bloque": dropvalB,
      "aula": dropvalA.toString(),
      "tipo": dropvalT,
      "detalle": valueTextf,
      "idusuarioapp": listdata[0].id.toString(),
    };
    final body = json.encode(data);

    final response = await http.post(Uri.parse(url),
        body: body, headers: {'Content-Type': 'application/json'});

    print(response.statusCode);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
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
      print("Solicitud creada");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpoS(context, dropvalB, fBloque, dropvalA, fAula, dropvalT,
          fTipo, inputD, _postsoli),
    );
  }
}

Widget cuerpoS(
  BuildContext context,
  String dropvalB,
  b(valueIn),
  String dropvalA,
  a(valuein),
  String dropvalT,
  t(valuein),
  TextEditingController id,
  text(),
) {
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
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        textoT(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bloque(dropvalB, b),
            aula(dropvalA, a),
          ],
        ),
        tipo(dropvalT, t),
        detalle(id),
        botonS(text),
        botonR(context)
      ],
    ),
  );
}

Widget textoT() {
  return Container(
    padding: EdgeInsets.only(top: 48, left: 9),
    alignment: Alignment.topLeft,
    child: Text(
      "Indique lugar",
      style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255)),
      textAlign: TextAlign.center,
    ),
  );
}

Widget bloque(String dropval, f(valuein)) {
  List listaBloque = ['A', 'B', 'C', 'D', 'E'];
  // List al = [];
  // al.add(listaBloque);
  return Container(
    // ignore: prefer_const_literals_to_create_immutables
    width: 180,
    height: 140,
    margin: EdgeInsets.all(0.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
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

Widget aula(String dropavalA, a(valuein)) {
  List listaAula = ['100', '101', '102', '103', '104'];
  return Container(
    width: 180,
    height: 140,
    // ignore: prefer_const_literals_to_create_immutables
    margin: EdgeInsets.all(0.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
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
              items: listaAula.map((aula) {
                return DropdownMenuItem(
                  value: aula,
                  child: Text(aula),
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

Widget tipo(String dropval, f(valuein)) {
  List listaTipo = ['Soporte tecnico', 'Mantenimiento', 'Instalacion'];
  // List al = [];
  // al.add(listaBloque);
  return Container(
    // ignore: prefer_const_literals_to_create_immutables
    width: 240,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
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
              "Tipo",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: DropdownButtonFormField(
              dropdownColor: Color.fromARGB(255, 142, 145, 194),
              items: listaTipo.map((valuet) {
                return DropdownMenuItem(
                  value: valuet,
                  child: Text(valuet),
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

Widget detalle(TextEditingController id) {
  return Container(
    // ignore: prefer_const_literals_to_create_i
    width: 380,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
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
    padding: EdgeInsets.all(5.0),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: TextField(
              minLines: 1,
              maxLines: 5,
              // keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  labelText: 'Detalle',
                  labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true),
              // onSubmitted: ftext,
              controller: id,
            ),
          )
        ]),
  );
}

Widget botonS(Fdatos()) {
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
          onPressed: Fdatos,
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
