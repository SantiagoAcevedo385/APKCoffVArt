import 'dart:convert';

DataModel3 dataModelFromJson(String str) =>
    DataModel3.fromJson(json.decode(str));

String dataModelToJson(DataModel3 data) => json.encode(data.toJson());

class DataModel3 {
  DataModel3({required this.clientes});

  List<Clientes> clientes;

  factory DataModel3.fromJson(Map<String, dynamic> json) => DataModel3(
      clientes: List<Clientes>.from(
          json["clientes"].map((x) => Clientes.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {"clientes": List<dynamic>.from(clientes.map((x) => x.toJson()))};
}

class Clientes {
  final String Id;
  String Nombre;
  String Apellido;
  String Documento;
  String Email;
  String Telefono;
  String Direccion;
  String Estado;

  Clientes({
    required this.Id,
    required this.Nombre,
    required this.Apellido,
    required this.Documento,
    required this.Email,
    required this.Telefono,
    required this.Direccion,
    required this.Estado,
  });

  factory Clientes.fromJson(Map<String, dynamic> json) => Clientes(
        Id: json["_id"],
        Nombre: json["Nombre"],
        Apellido: json["Apellido"],
        Documento: json["Documento"].toString(),
        Email: json["Email"],
        Telefono: json["Telefono"].toString(),
        Direccion: json["Direccion"],
        Estado: json["Estado"],
      );

  Map<String, dynamic> toJson() => {
        "_id": Id,
        "Nombre": Nombre,
        "Apellido": Apellido,
        "Documento": Documento,
        "Email": Email,
        "Telefono": Telefono,
        "Direccion": Direccion,
        "Estado": Estado
      };
}
