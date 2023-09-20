import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());



class DataModel {
  DataModel({
    required this.insumos
  });
  
  List<Insumo> insumos;

  factory DataModel.fromJson(Map<String, dynamic> json)=> DataModel(
    insumos: List<Insumo>.from(json["insumos"].map((x)=> Insumo.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "insumos": List<dynamic>.from(insumos.map((x)=> x.toJson()))
  };
}

class Insumo {
    final String id;
    String nombre;
  String costoSaco;
     String cantidad;
     String categoria;
    String descripcion;


    Insumo({
        required this.id,
        required this.nombre,
        required this.costoSaco,
        required this.cantidad,
        required this.categoria,
        required this.descripcion,

    });

    factory Insumo.fromJson(Map<String, dynamic> json) => Insumo(
        id: json["_id"],
        nombre: json["nombre"],
        costoSaco: json["costoSaco"],
        cantidad: json["cantidad"],
        categoria: json["categoria"],
        descripcion: json["descripcion"],

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "costoSaco": costoSaco,
        "cantidad": cantidad,
        "categoria": categoria,
        "descripcion": descripcion,

    };
}