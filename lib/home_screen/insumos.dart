import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Componentes/input.dart';
import 'package:flutter_application_2/models/insumo.dart';

import 'package:http/http.dart' as http;

Future<Album> createAlbum(String nombre, String costoSaco, String cantidad,
    String categoria, String descripcion) async {
  final response = await http.post(
    Uri.parse('https://coff-v-art-api.onrender.com/api/insumo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nombre': nombre,
      'costoSaco': costoSaco,
      'cantidad': cantidad,
      'categoria': categoria,
      'descripcion': descripcion,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

class Album {
  final String id;
  final String nombre;
  final String costoSaco;
  final String cantidad;
  final String categoria;
  final String descripcion;

  Album({
    required this.id,
    required this.nombre,
    required this.costoSaco,
    required this.cantidad,
    required this.categoria,
    required this.descripcion,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json['id'],
        nombre: json['nombre'],
        costoSaco: json['costoSaco'],
        cantidad: json['cantidad'],
        categoria: json['categoria'],
        descripcion: json['descripcion']);
  }
}

class InsumosApp extends StatefulWidget {
  const InsumosApp({super.key});

  @override
  State<InsumosApp> createState() {
    return _InsumosAppState();
  }
}

class _InsumosAppState extends State<InsumosApp> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _costoSacoController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  Future<Album>? _futureAlbumI;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Categoria'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: (_futureAlbumI == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InputCampo(
          label: "Nombre: ",
          controller: _nombreController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese el nombre" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Descripción: ",
          controller: _costoSacoController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese el costo" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Descripción: ",
          controller: _cantidadController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese la cantidad" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Descripción: ",
          controller: _categoriaController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese la categoria" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Descripción: ",
          controller: _descripcionController,
          obscureText: false,
          validator: (value) =>
              value!.isEmpty ? "Ingrese la descripcion" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbumI = createAlbum(
                _nombreController.text,
                _costoSacoController.text,
                _cantidadController.text,
                _categoriaController.text,
                _descripcionController.text,
              );
            });
          },
          child: const Text('Crear Insumos'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbumI,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.nombre);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class InsumosList extends StatefulWidget {
  const InsumosList({super.key});

  @override
  State<InsumosList> createState() => _InsumosListState();
}

class _InsumosListState extends State<InsumosList> {
  bool _isLoading = true;

  List<Insumo> insumos = [];

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _costoSacoController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      String url = 'https://coff-v-art-api.onrender.com/api/insumo';
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          _isLoading = false;
          insumos = DataModel.fromJson(json.decode(res.body)).insumos;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _crearInsumo() async {
    try {
      final response = await http.post(
        Uri.parse('https://coff-v-art-api.onrender.com/api/insumo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': _nombreController.text,
          'costoSaco': _costoSacoController.text,
          'cantidad': _cantidadController.text,
          'categoria': _categoriaController.text,
          'descripcion': _descripcionController.text,
        }),
      );

      if (response.statusCode == 201) {
        final nuevoInsumo = Insumo.fromJson(jsonDecode(response.body));
        setState(() {
          insumos.add(nuevoInsumo);
          _nombreController.clear();
          _costoSacoController.clear();
          _cantidadController.clear();
          _categoriaController.clear();
          _descripcionController.clear();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _editarInsumo(Insumo insumo) async {
    try {
      final response = await http.put(
        Uri.parse('https://coff-v-art-api.onrender.com/api/insumo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "_id": insumo.id,
          'nombre': _nombreController.text,
          'costoSaco': _costoSacoController.text,
          'cantidad': _cantidadController.text,
          'categoria': _categoriaController.text,
          'descripcion': _descripcionController.text,
        }),
      );

      if (response.statusCode == 200) {
        final insumoActualizado = Insumo.fromJson(jsonDecode(response.body));
        setState(() {
          insumo.nombre = insumoActualizado.nombre;
          insumo.costoSaco = insumoActualizado.costoSaco;
          insumo.cantidad = insumoActualizado.cantidad;
          insumo.categoria = insumoActualizado.categoria;
          insumo.descripcion = insumoActualizado.descripcion;
          _nombreController.clear();
          _costoSacoController.clear();
          _cantidadController.clear();
          _categoriaController.clear();
          _descripcionController.clear();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _eliminarInsumo(Insumo insumo) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'https://coff-v-art-api.onrender.com/api/insumo/${insumo.id}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          insumos.remove(insumo);
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
        title: const Text('Gestión de Insumos'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Nombre')),
                    DataColumn(label: Text('Costo por Saco')),
                    DataColumn(label: Text('Cantidad')),
                    DataColumn(label: Text('Categoría')),
                    DataColumn(label: Text('Descripción')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  rows: [
                    for (var insumo in insumos)
                      DataRow(
                        cells: [
                          DataCell(Text(insumo.nombre)),
                          DataCell(Text(insumo.costoSaco.toString())),
                          DataCell(Text(insumo.cantidad.toString())),
                          DataCell(Text(insumo.categoria)),
                          DataCell(Text(insumo.descripcion)),
                          DataCell(
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Editar insumo
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        _nombreController.text = insumo.nombre;
                                        _costoSacoController.text =
                                            insumo.costoSaco;
                                        _cantidadController.text =
                                            insumo.cantidad;
                                        _categoriaController.text =
                                            insumo.categoria;
                                        _descripcionController.text =
                                            insumo.descripcion;
                                        return AlertDialog(
                                          title: const Text('Editar Insumo'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller: _nombreController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Nombre'),
                                              ),
                                              TextFormField(
                                                controller:
                                                    _costoSacoController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Costo por Saco'),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              TextFormField(
                                                controller: _cantidadController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Cantidad'),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              TextFormField(
                                                controller:
                                                    _categoriaController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Categoría'),
                                              ),
                                              TextFormField(
                                                controller:
                                                    _descripcionController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Descripción'),
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
                                                primary:
                                                    Colors.red, // Fondo rojo
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                _editarInsumo(insumo);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Guardar'),
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    Colors.red, // Fondo rojo
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
                                  child: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Eliminar insumo
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Eliminar Insumo'),
                                          content: const Text(
                                              '¿Estás seguro de que deseas eliminar este insumo?'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancelar'),
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    Colors.red, // Fondo rojo
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                _eliminarInsumo(insumo);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Eliminar'),
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    Colors.red, // Fondo rojo
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              _nombreController.clear();
              _costoSacoController.clear();
              _cantidadController.clear();
              _categoriaController.clear();
              _descripcionController.clear();
              return AlertDialog(
                title: const Text('Crear Insumo'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    TextFormField(
                      controller: _costoSacoController,
                      decoration:
                          const InputDecoration(labelText: 'Costo por Saco'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _cantidadController,
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _categoriaController,
                      decoration: const InputDecoration(labelText: 'Categoría'),
                    ),
                    TextFormField(
                      controller: _descripcionController,
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
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
