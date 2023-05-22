// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solicitud/Models/Solicitud.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  late Future<List<Solicitu>> _listadosApi;

  Future<List<Solicitu>> _getApi() async {
    var url = Uri.parse('http://192.168.1.3:3000/solicitud');
    List<Solicitu> solis = [];
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var body = utf8.decode(response.bodyBytes);
      final data = jsonDecode(body);
      for (var item in data) {
        solis.add(Solicitu(
            item["id"],
            item["solicitud"],
            item["estado"],
            item["bloque"],
            item["aula"],
            item["tipo"],
            item["detalle"],
            item["idusuarioapp"]));
      }
      return solis;
    } else {
      throw Exception("Error peticion");
    }
  }

  List<Solicitu> datalist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listadosApi = _getApi();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 52, 64, 235),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: TabBar(
                // indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        0.6,
                        1
                      ],
                      colors: [
                        Color.fromARGB(255, 145, 182, 238),
                        Color.fromARGB(255, 58, 86, 146),
                        Color.fromARGB(255, 26, 66, 112)
                      ]),
                  borderRadius: BorderRadius.circular(50), // Creates border
                ),
                tabs: [
                  Tab(
                    child: Icon(
                      Icons.list,
                      size: 30.0,
                    ),
                  ),
                  Tab(icon: Icon(Icons.lens, color: Colors.green)),
                  Tab(icon: Icon(Icons.lens, color: Colors.yellow)),
                  Tab(
                    icon: Icon(Icons.lens, color: Colors.red),
                  )
                ]),
            title: Text("Solicitudes"),
            centerTitle: true,
          ),
          body: Container(
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
            child: TabBarView(
              children: elementS(),
            ),
          ),
        ));
  }

  _cambioEstado(context, Solicitu soli) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Color.fromARGB(255, 183, 186, 204),
              shadowColor: Colors.blueGrey,
              title: soli.estado.toLowerCase() == "espera"
                  ? Text("Cambio de estado?")
                  : soli.estado.toLowerCase() == "proceso"
                      ? Text("Cambio de estado?")
                      : Text("Estado completado"),
              content: soli.estado.toLowerCase() == "espera" ||
                      soli.estado.toLowerCase() == "proceso"
                  ? Text("Pulse el siguiente estado")
                  : Text("No requiere ningun cambio"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: soli.estado.toLowerCase() == "espera" ||
                            soli.estado.toLowerCase() == "proceso"
                        ? Text(
                            "Cancelar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 0, 47, 255)),
                          )
                        : Text("")),
                TextButton(
                  onPressed: () async {
                    if (soli.estado.toLowerCase() == "espera" ||
                        soli.estado.toLowerCase() == "proceso") {
                      String estadoN = soli.estado.toLowerCase() == "espera"
                          ? "Proceso"
                          : soli.estado.toLowerCase() == "proceso"
                              ? "Completado"
                              : "";
                      final url = 'http://192.168.1.3:3000/Usolicitud';
                      final data = {
                        "id": soli.id.toString(),
                        "estado": estadoN
                      };
                      final body = json.encode(data);

                      final response = await http.post(Uri.parse(url),
                          body: body,
                          headers: {'Content-Type': 'application/json'});

                      print(response.statusCode);
                      this.setState(() {
                        soli.estado = estadoN;
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: soli.estado.toLowerCase() == "espera"
                      ? Text(
                          "Proceso",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color.fromARGB(255, 0, 47, 255)),
                        )
                      : soli.estado.toLowerCase() == "proceso"
                          ? Text(
                              "Completado",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 0, 47, 255)),
                            )
                          : Text(
                              "Ok",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 0, 47, 255)),
                            ),
                )
              ],
            ));
  }

  sdetalle(context, Solicitu soli) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Color.fromARGB(255, 183, 186, 204),
              shadowColor: Colors.blueGrey,
              icon: Icon(Icons.description_rounded,
                  size: 50.0, color: Colors.blueAccent),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Bloque:",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    // SizedBox(
                    //   width: 10.0,
                    // ),
                    Text(soli.bloque)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Aula:",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(soli.aula.toString())
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Tipo:",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(soli.tipo)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Detalle:",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(soli.detalle)
                  ],
                )
              ]),
              actions: [
                FloatingActionButton(
                  tooltip: "salir",
                  elevation: 0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.exit_to_app_rounded),
                ),
              ],
            ));
  }

  List<Widget> elementS() {
    List<Widget> _widgetOptions = <Widget>[
      Soli(),
      FutureBuilder(
          future: _listadosApi,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              datalist = snapshot.data ?? List.empty();
              return Sespera();
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("error");
            }
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 92, 26, 1),
              ),
            );
          }),
      FutureBuilder(
          future: _listadosApi,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              datalist = snapshot.data ?? List.empty();
              return Sproceso();
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("error");
            }
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 92, 26, 1),
              ),
            );
          }),
      FutureBuilder(
          future: _listadosApi,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              datalist = snapshot.data ?? List.empty();
              return Scompletado();
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("error");
            }
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 92, 26, 1),
              ),
            );
          }),
    ];
    return _widgetOptions;
  }

  Widget Soli() {
    return FutureBuilder(
      future: _listadosApi,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          datalist = snapshot.data ?? List.empty();
          return ListView.builder(
              itemCount: datalist.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  // padding: EdgeInsets.symmetric(horizontal: 20),
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
                            Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(255, 192, 192, 192),
                            Color.fromARGB(255, 187, 187, 187)
                          ])),
                  child: ListTile(
                    onLongPress: () {
                      this.sdetalle(context, datalist[index]);
                    },
                    onTap: () {
                      this._cambioEstado(context, datalist[index]);
                    },
                    title: Text(datalist[index].solicitud,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600)),
                    subtitle: Text(
                      datalist[index].aula.toString(),
                      style: TextStyle(fontSize: 18.0),
                    ),
                    leading: CircleAvatar(
                        child: Text(
                          datalist[index].bloque,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        backgroundColor: Color.fromARGB(255, 255, 255, 255)),
                    trailing: Icon(Icons.lens,
                        color: datalist[index].estado.toLowerCase() == "espera"
                            ? Colors.green
                            : datalist[index].estado.toLowerCase() == "proceso"
                                ? Colors.amber
                                : Colors.red),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text("error");
        }

        return Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 92, 26, 1),
          ),
        );
      },
    );
  }

  Widget Sespera() {
    List<Solicitu> listag = datalist
        .where((datalist) => datalist.estado.toLowerCase() == "espera")
        .toList();
    return ListView.builder(
        itemCount: listag.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            // padding: EdgeInsets.symmetric(horizontal: 20),
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
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 192, 192, 192),
                      Color.fromARGB(255, 187, 187, 187)
                    ])),
            child: ListTile(
              onLongPress: () {
                this.sdetalle(context, listag[index]);
              },
              onTap: () {
                this._cambioEstado(context, listag[index]);
              },
              title: Text(listag[index].solicitud,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              subtitle: Text(
                listag[index].aula.toString(),
                style: TextStyle(fontSize: 18.0),
              ),
              leading: CircleAvatar(
                  child: Text(
                    listag[index].bloque,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
              trailing: Icon(Icons.lens, color: Colors.green),
            ),
          );
        });
  }

  Widget Sproceso() {
    List<Solicitu> listay = datalist
        .where((datalist) => datalist.estado.toLowerCase() == "proceso")
        .toList();
    return ListView.builder(
        itemCount: listay.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            // padding: EdgeInsets.symmetric(horizontal: 20),
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
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 192, 192, 192),
                      Color.fromARGB(255, 187, 187, 187)
                    ])),
            child: ListTile(
              onLongPress: () {
                this.sdetalle(context, listay[index]);
              },
              onTap: () {
                this._cambioEstado(context, listay[index]);
              },
              title: Text(listay[index].solicitud,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              subtitle: Text(
                listay[index].aula.toString(),
                style: TextStyle(fontSize: 18.0),
              ),
              leading: CircleAvatar(
                  child: Text(
                    listay[index].bloque,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
              trailing: Icon(Icons.lens, color: Colors.yellow),
            ),
          );
        });
  }

  Widget Scompletado() {
    List<Solicitu> listar = datalist
        .where((datalist) => datalist.estado.toLowerCase() == "completado")
        .toList();
    return ListView.builder(
        itemCount: listar.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            // padding: EdgeInsets.symmetric(horizontal: 20),
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
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 192, 192, 192),
                      Color.fromARGB(255, 187, 187, 187)
                    ])),
            child: ListTile(
              onLongPress: () {
                this.sdetalle(context, listar[index]);
              },
              onTap: () {
                this._cambioEstado(context, listar[index]);
              },
              title: Text(listar[index].solicitud,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
              subtitle: Text(
                listar[index].aula.toString(),
                style: TextStyle(fontSize: 18.0),
              ),
              leading: CircleAvatar(
                  child: Text(
                    listar[index].bloque,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255)),
              trailing: Icon(Icons.lens, color: Colors.red),
            ),
          );
        });
  }
}
