import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Componentes/input.dart';
import 'package:flutter_application_2/models/producto.dart';

import 'package:http/http.dart' as http;

//https://frontendhbs.onrender.com/
Future<Album> createAlbum(String name, String valorU, String insumo,
    String stockMin, String stockMax, String descripcion) async {
  final response = await http.post(
    Uri.parse('https://coff-v-art-api.onrender.com/api/product'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'valorU': valorU,
      'insumo': insumo,
      'stockMin': stockMin,
      'stockMax': stockMax,
      'descripcion': descripcion
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(response.body);
  }
}

class Album {
  final String id;
  final String name;
  final double valorU;
  final String insumo;
  final int stockMin;
  final int stockMax;
  final String descripcion;

  const Album(
      {required this.id,
      required this.name,
      required this.valorU,
      required this.insumo,
      required this.stockMin,
      required this.stockMax,
      required this.descripcion});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json['id'],
        name: json['name'],
        valorU: json['valorU'],
        insumo: json['insumo'],
        stockMin: json['stockMin'],
        stockMax: json['stockMax'],
        descripcion: json['descripcion']);
  }
}

class CrearProducto extends StatefulWidget {
  const CrearProducto({super.key});

  @override
  State<CrearProducto> createState() {
    return _CrearProductoState();
  }
}

class _CrearProductoState extends State<CrearProducto> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _valorU = TextEditingController();
  final TextEditingController _insumo = TextEditingController();
  final TextEditingController _stockMin = TextEditingController();
  final TextEditingController _stockMax = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Producto'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InputCampo(
          label: "Nombre del Producto: ",
          controller: _name,
          obscureText: false,
          validator: (value) =>
              value!.isEmpty ? "Ingrese el nombre del producto" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Valor Unitario del producto: ",
          controller: _valorU,
          obscureText: false,
          validator: (value) =>
              value!.isEmpty ? "Ingrese el valor unitario" : null,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Insumo asociado al producto: ",
          controller: _insumo,
          obscureText: false,
          validator: (value) =>
              value!.isEmpty ? "Ingrese el insumo asociado al producto" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Stock Minimo: ",
          controller: _stockMin,
          obscureText: false,
          validator: (value) =>
              value!.isEmpty ? "Ingrese el stock minimo" : null,
          keyboardType: TextInputType.number,
        ),
        InputCampo(
          label: "Stock Máximo: ",
          controller: _stockMax,
          obscureText: false,
          validator: (value) =>
              value!.isEmpty ? "Ingrese el stock máximo" : null,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Descripción del Producto: ",
          controller: _descripcion,
          obscureText: false,
          validator: (value) =>
              value!.isEmpty ? "Ingrese la descripción del Producto" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_name.text, _valorU.text, _insumo.text,
                  _stockMin.text, _stockMax.text, _descripcion.text);
            });
          },
          child: const Text('Crear Producto'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class ProductosList extends StatefulWidget {
  const ProductosList({super.key});

  @override
  State<ProductosList> createState() => _ProductosListState();
}

class _ProductosListState extends State<ProductosList> {
  bool _isLoading = true;

  List<Product> products = [];

  final TextEditingController _name = TextEditingController();
  final TextEditingController _valorU = TextEditingController();
  final TextEditingController _insumo = TextEditingController();
  final TextEditingController _stockMin = TextEditingController();
  final TextEditingController _stockMax = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      String url = 'https://coff-v-art-api.onrender.com/api/product';
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          _isLoading = false;
          products = DataModel.fromJson(json.decode(res.body)).products;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _crearInsumo() async {
    try {
      final response = await http.post(
        Uri.parse('https://coff-v-art-api.onrender.com/api/product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': _name.text,
          'valorU': _valorU.text,
          'insumo': _insumo.text,
          'stockMin': _stockMin.text,
          'stockMax': _stockMax.text,
          'descripcion': _descripcion.text,
        }),
      );

      if (response.statusCode == 201) {
        final nuevoProducto = Product.fromJson(jsonDecode(response.body));
        setState(() {
          products.add(nuevoProducto);
          _name.clear();
          _valorU.clear();
          _insumo.clear();
          _stockMin.clear();
          _stockMax.clear();
          _descripcion.clear();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _editarInsumo(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('https://coff-v-art-api.onrender.com/api/product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "_id": product.id,
          'name': _name.text,
          'valorU': _valorU.text,
          'insumo': _insumo.text,
          'stockMin': _stockMin.text,
          'stockMax': _stockMax.text,
          'descripcion': _descripcion.text,
        }),
      );

      if (response.statusCode == 200) {
        final productActualizado = Product.fromJson(jsonDecode(response.body));
        setState(() {
          product.name = productActualizado.name;
          product.valorU = productActualizado.valorU;
          product.insumo = productActualizado.insumo;
          product.stockMin = productActualizado.stockMin;
          product.stockMax = productActualizado.stockMax;
          product.descripcion = productActualizado.descripcion;
          _name.clear();
          _valorU.clear();
          _insumo.clear();
          _stockMin.clear();
          _stockMax.clear();
          _descripcion.clear();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _eliminarInsumo(Product product) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'https://coff-v-art-api.onrender.com/api/product/${product.id}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          products.remove(product);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        backgroundColor: Colors.red,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Valor Unitario')),
                  DataColumn(label: Text('Insumo asociado')),
                  DataColumn(label: Text('Stock Minimo')),
                  DataColumn(label: Text('Stock Máximo')),
                  DataColumn(label: Text('Descripción')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: [
                  for (var product in products)
                    DataRow(
                      cells: [
                        DataCell(Text(product.name)),
                        DataCell(Text(product.valorU.toString())),
                        DataCell(Text(product.insumo.toString())),
                        DataCell(Text(product.stockMin.toString())),
                        DataCell(Text(product.stockMax.toString())),
                        DataCell(Text(product.descripcion)),
                        DataCell(
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Editar insumo
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      _name.text = product.name;
                                      _valorU.text = product.valorU;
                                      _insumo.text = product.insumo;
                                      _stockMin.text = product.stockMin;
                                      _stockMax.text = product.stockMax;
                                      _descripcion.text = product.descripcion;
                                      return AlertDialog(
                                        title: const Text('Editar Producto'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller: _name,
                                              decoration: const InputDecoration(
                                                  labelText: 'Nombre'),
                                            ),
                                            TextFormField(
                                              controller: _valorU,
                                              decoration: const InputDecoration(
                                                  labelText: 'Valor Unitario'),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            TextFormField(
                                              controller: _insumo,
                                              decoration: const InputDecoration(
                                                  labelText: 'Insumo'),
                                              keyboardType: TextInputType.text,
                                            ),
                                            TextFormField(
                                              controller: _stockMin,
                                              decoration: const InputDecoration(
                                                  labelText: 'Stock Minimo'),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            TextFormField(
                                              controller: _stockMin,
                                              decoration: const InputDecoration(
                                                  labelText: 'Stock Máximo'),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            TextFormField(
                                              controller: _descripcion,
                                              decoration: const InputDecoration(
                                                  labelText: 'Descripción'),
                                              keyboardType: TextInputType.text,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancelar'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red, // Fondo rojo
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              _editarInsumo(product);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Guardar'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red, // Fondo rojo
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // Fondo rojo
                                ),
                                child:
                                    const Icon(Icons.edit, color: Colors.white),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Eliminar insumo
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Eliminar Producto'),
                                        content: const Text(
                                            '¿Estás seguro de que deseas eliminar este producto?'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancelar'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red, // Fondo rojo
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              _eliminarInsumo(product);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Eliminar'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red, // Fondo rojo
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // Fondo rojo
                                ),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              _name.clear();
              _valorU.clear();
              _insumo.clear();
              _stockMin.clear();
              _stockMax.clear();
              _descripcion.clear();
              return AlertDialog(
                title: const Text('Crear Producto'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    TextFormField(
                      controller: _valorU,
                      decoration:
                          const InputDecoration(labelText: 'Valor Unitario'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _insumo,
                      decoration: const InputDecoration(labelText: 'Insumo'),
                      keyboardType: TextInputType.text,
                    ),
                    TextFormField(
                      controller: _stockMin,
                      decoration:
                          const InputDecoration(labelText: 'Stock Minimo'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _stockMax,
                      decoration:
                          const InputDecoration(labelText: 'Stock Máximo'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _descripcion,
                      decoration:
                          const InputDecoration(labelText: 'Descripción'),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Fondo rojo
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _crearInsumo();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Crear'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Fondo rojo
                    ),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
