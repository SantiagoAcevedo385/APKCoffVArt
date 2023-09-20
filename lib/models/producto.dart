// To parse this JSON data, do
//
//     final producto = productoFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());



class DataModel {
  DataModel({
    required this.products
  });
  
  List<Product> products;

  factory DataModel.fromJson(Map<String, dynamic> json)=> DataModel(
    products: List<Product>.from(json["products"].map((x)=> Product.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "productos": List<dynamic>.from(products.map((x)=> x.toJson()))
  };
}

class Product {
    final String id;
    String name;
    String valorU;
    String insumo;
    String stockMin;
    String stockMax;
    String descripcion;


    Product({
        required this.id,
        required this.name,
        required this.valorU,
        required this.insumo,
        required this.stockMin,
        required this.stockMax,
        required this.descripcion,

    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        valorU: json["valorU"],
        insumo: json["insumo"],
        stockMin: json["stockMin"],
        stockMax: json["stockMax"],
        descripcion: json["descripcion"],

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "valorU": valorU,
        "insumo": insumo,
        "stockMin": stockMin,
        "stockMax": stockMax,
        "descripcion": descripcion,

    };
}
