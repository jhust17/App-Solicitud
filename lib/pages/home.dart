// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:solicitud/pages/pagesoc.dart';
import 'package:solicitud/pages/solicitudes.dart';
import 'package:solicitud/pages/soporte.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Home(),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  var texto = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
      texto = "Home";
    } else {
      texto = "Solicitud";
    }
    return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Color.fromARGB(255, 52, 64, 235),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            texto,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
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
            child: elementS(context).elementAt(_selectedIndex)),
        bottomNavigationBar: naveg(context, _selectedIndex, _onItemTapped));
  }
}

List<Widget> elementS(BuildContext context) {
  List<Widget> _widgetOptions = <Widget>[
    cuerpoH(context),
    SolicitudesP(context)
  ];
  return _widgetOptions;
}

Widget SolicitudesP(BuildContext context) {
  return Container(child: Solicitudesp());
}

Widget naveg(BuildContext context, int i, f(int index)) {
  return Container(
    color: Color.fromARGB(255, 146, 154, 224),
    padding: EdgeInsets.all(30.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Color.fromARGB(255, 255, 255, 255)),
      // padding: EdgeInsets.all(20.0),
      child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                // backgroundColor: Color.fromARGB(255, 83, 61, 185),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                // backgroundColor: Color.fromARGB(255, 4, 1, 151),
                label: "Solicitud"),
          ],
          unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedFontSize: 15,
          selectedLabelStyle: TextStyle(fontSize: 20),
          selectedIconTheme: IconThemeData(
            size: 42,
          ),
          currentIndex: i,
          selectedItemColor: Color.fromARGB(238, 16, 0, 235),
          iconSize: 36,
          onTap: f,
          elevation: 0),
    ),
  );
}

Widget cuerpoH(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      // decoration: BoxDecoration(color: Colors.blueAccent),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                abrir(context),
                cerrar(context),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            soporte(context)
          ],
        ),
      ),
    ),
  );
}

Widget abrir(BuildContext context) {
  final String texto = "Abrir Pantalla";
  return Container(
    // color: Colors.cyanAccent,
    child: Column(
      children: [
        Text("Abrir",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            width: 100.0,
            height: 80.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(210, 1, 79, 148)),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pagesocd(texto),
                          ))
                    },
                child: Icon(
                  Icons.meeting_room,
                  size: 50.0,
                )),
          ),
        )
      ],
    ),
  );
}

Widget cerrar(BuildContext context) {
  final String texto = "Cerrar Pantalla";
  return Container(
    child: Column(
      children: [
        Text("Cerrar",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            width: 100.0,
            height: 80.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(210, 1, 79, 148)),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pagesocd(texto),
                          ))
                    },
                child: Icon(
                  Icons.no_meeting_room,
                  size: 50.0,
                )),
          ),
        )
      ],
    ),
  );
}

Widget soporte(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Text(
          "Soporte",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            width: 100.0,
            height: 80.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(210, 1, 79, 148)),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dsoporte(),
                          ))
                    },
                child: Icon(
                  Icons.room_preferences,
                  size: 50.0,
                )),
          ),
        )
      ],
    ),
  );
}
