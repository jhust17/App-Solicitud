import 'package:flutter/material.dart';

class Solicitu {
  int id = 0;
  String solicitud = "";
  String estado = "";
  String bloque = "";
  int aula = 0;
  String tipo = "";
  String detalle = "";
  int idusuarioapp = 0;
  Solicitu(id, solicitud, estado, bloque, aula, tipo, detalle, idusuarioapp) {
    this.id = id;
    this.solicitud = solicitud;
    this.estado = estado;
    this.bloque = bloque;
    this.aula = aula;
    this.tipo = tipo;
    this.detalle = detalle;
    this.idusuarioapp = idusuarioapp;
  }
}
