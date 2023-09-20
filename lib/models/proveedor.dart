import 'dart:convert';

DataModel4 dataModelFromJson(String str) =>
    DataModel4.fromJson(json.decode(str));

String dataModelToJson(DataModel4 data) => json.encode(data.toJson());

class DataModel4 {
  DataModel4({required this.proveedores});

  List<Proveedor> proveedores;

  factory DataModel4.fromJson(Map<String, dynamic> json) => DataModel4(
      proveedores: List<Proveedor>.from(
          json["proveedores"].map((x) => Proveedor.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {"proveedores": List<dynamic>.from(proveedores.map((x) => x.toJson()))};
}

class Proveedor {
  final String id;
  int nit;
  String nombre;
  int telefono;
  String factura;
  int cantidad;
  String fecha;
  String categoria;
  String estado;

  Proveedor({
    required this.id,
    required this.nit,
    required this.nombre,
    required this.telefono,
    required this.factura,
    required this.cantidad,
    required this.fecha,
    required this.categoria,
    required this.estado,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        id: json["_id"],
        nit: json["Nit"],
        nombre: json["Nombre"],
        telefono: json["Telefono"],
        factura: json["Factura"],
        cantidad: json["Cantidad"],
        fecha: json["Fecha"],
        categoria: json["Categoria"],
        estado: json["Estado"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Nit": nit,
        "Nombre": nombre,
        "Telefono": telefono,
        "Factura": factura,
        "Cantidad": cantidad,
        "Fecha": fecha,
        "Categoria": categoria,
        "Estado": estado,
      };
}
