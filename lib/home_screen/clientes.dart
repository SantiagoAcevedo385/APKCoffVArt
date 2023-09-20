import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Componentes/input.dart';
import 'package:flutter_application_2/models/cliente.dart';

import 'package:http/http.dart' as http;

Future<AlbumClientes> createAlbum(
    String Nombre,
    String Apellido,
    String Documento,
    String Email,
    String Telefono,
    String Direccion,
    String Estado) async {
  final response = await http.post(
    Uri.parse('https://coffevart.onrender.com/api/clientes'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Nombre': Nombre,
      'Apellido': Apellido,
      'Documento': Documento,
      'Email': Email,
      'Telefono': Telefono,
      'Direccion': Direccion,
      'Estado': Estado,
    }),
  );

  if (response.statusCode == 201) {
    return AlbumClientes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

class AlbumClientes {
  final String Id;
  final String Nombre;
  final String Apellido;
  final String Documento;
  final String Email;
  final String Telefono;
  final String Direccion;
  final String Estado;

  AlbumClientes({
    required this.Id,
    required this.Nombre,
    required this.Apellido,
    required this.Documento,
    required this.Email,
    required this.Telefono,
    required this.Direccion,
    required this.Estado,
  });

  factory AlbumClientes.fromJson(Map<String, dynamic> json) {
    return AlbumClientes(
        Id: json["_Id"],
        Nombre: json["Nombre"],
        Apellido: json["Apellido"],
        Documento: json["Documento"],
        Email: json["Email"],
        Telefono: json["Telefono"],
        Direccion: json["Direccion"],
        Estado: json["Estado"]);
  }
}

class ClientesApp extends StatefulWidget {
  const ClientesApp({super.key});

  @override
  State<ClientesApp> createState() {
    return _ClientesAppState();
  }
}

class _ClientesAppState extends State<ClientesApp> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _documentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  Future<AlbumClientes>? _futureAlbumCliente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cliente'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: (_futureAlbumCliente == null)
            ? buildColumn()
            : buildFutureBuilder(),
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
          label: "Apellido: ",
          controller: _apellidoController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese el apellido" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Documento: ",
          controller: _documentoController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese el documento" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Email: ",
          controller: _emailController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese el email" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        InputCampo(
          label: "Telefono: ",
          controller: _telefonoController,
          obscureText: false,
          validator: (value) =>
              value!.isEmpty ? "Ingrese la descripcion" : null,
          keyboardType: TextInputType.text,
        ),
        InputCampo(
          label: "Direccion: ",
          controller: _direccionController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese la direccion" : null,
          keyboardType: TextInputType.text,
        ),
        InputCampo(
          label: "Estado: ",
          controller: _estadoController,
          obscureText: false,
          validator: (value) => value!.isEmpty ? "Ingrese el estado" : null,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbumCliente = createAlbum(
                  _nombreController.text,
                  _apellidoController.text,
                  _documentoController.text,
                  _emailController.text,
                  _telefonoController.text,
                  _direccionController.text,
                  _estadoController.text);
            });
          },
          child: const Text('Crear Clientes'),
        ),
      ],
    );
  }

  FutureBuilder<AlbumClientes> buildFutureBuilder() {
    return FutureBuilder<AlbumClientes>(
      future: _futureAlbumCliente,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.Nombre);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class ClientesList extends StatefulWidget {
  const ClientesList({super.key});

  @override
  State<ClientesList> createState() => _ClientesListState();
}

class _ClientesListState extends State<ClientesList> {
  bool _isLoading = true;

  List<Clientes> clientes = [];

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _documentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      String url = 'https://coffevart.onrender.com/api/clientes';
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          _isLoading = false;
          clientes = DataModel3.fromJson(json.decode(res.body)).clientes;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _crearInsumo() async {
    try {
      final response = await http.post(
        Uri.parse('https://coffevart.onrender.com/api/clientes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'Nombre': _nombreController.text,
          'Apellido': _apellidoController.text,
          'Documento': _documentoController.text,
          'Email': _emailController.text,
          'Telefono': _telefonoController.text,
          'Direccion': _direccionController.text,
          'Estado': _estadoController.text
        }),
      );

      if (response.statusCode == 201) {
        final nuevoCliente = Clientes.fromJson(jsonDecode(response.body));
        setState(() {
          clientes.add(nuevoCliente);
          _nombreController.clear();
          _apellidoController.clear();
          _documentoController.clear();
          _emailController.clear();
          _telefonoController.clear();
          _direccionController.clear();
          _estadoController.clear();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _editarInsumo(Clientes clientes) async {
    try {
      final response = await http.put(
        Uri.parse('https://coffevart.onrender.com/api/clientes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "_id": clientes.Id,
          'Nombre': _nombreController.text,
          'Apellido': _apellidoController.text,
          'Documento': _documentoController.text,
          'Email': _emailController.text,
          'Telefono': _telefonoController.text,
          'Direccion': _direccionController.text,
          'Estado': _estadoController.text
        }),
      );

      if (response.statusCode == 200) {
        final clienteActualizado = Clientes.fromJson(jsonDecode(response.body));
        setState(() {
          clientes.Nombre = clienteActualizado.Nombre;
          clientes.Apellido = clienteActualizado.Apellido;
          clientes.Documento = clienteActualizado.Documento;
          clientes.Email = clienteActualizado.Email;
          clientes.Telefono = clienteActualizado.Telefono;
          clientes.Direccion = clienteActualizado.Direccion;
          clientes.Estado = clienteActualizado.Estado;
          _nombreController.clear();
          _apellidoController.clear();
          _documentoController.clear();
          _emailController.clear();
          _telefonoController.clear();
          _direccionController.clear();
          _estadoController.clear();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _eliminarInsumo(Clientes cliente) async {
    try {
      final response = await http.delete(
          Uri.parse('https://coffevart.onrender.com/api/clientes/'),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode({'_id': cliente.Id}));

      if (response.statusCode == 200) {
        setState(() {
          clientes.remove(cliente);
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
        title: const Text('Gestión de Clientes'),
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
                    DataColumn(label: Text('Apellido')),
                    DataColumn(label: Text('Documento')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Telefono')),
                    DataColumn(label: Text('Direccion')),
                    DataColumn(label: Text('Estado')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  rows: [
                    for (var cliente in clientes)
                      DataRow(
                        cells: [
                          DataCell(Text(cliente.Nombre)),
                          DataCell(Text(cliente.Apellido)),
                          DataCell(Text(cliente.Documento.toString())),
                          DataCell(Text(cliente.Email)),
                          DataCell(Text(cliente.Telefono.toString())),
                          DataCell(Text(cliente.Direccion)),
                          DataCell(Text(cliente.Estado)),
                          DataCell(
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Editar insumo
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        _nombreController.text = cliente.Nombre;
                                        _apellidoController.text =
                                            cliente.Apellido;
                                        _documentoController.text =
                                            cliente.Documento;
                                        _emailController.text = cliente.Email;
                                        _telefonoController.text =
                                            cliente.Telefono;
                                        _direccionController.text =
                                            cliente.Direccion;
                                        _estadoController.text = cliente.Estado;
                                        return AlertDialog(
                                          title: const Text('Editar Cliente'),
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
                                                controller: _apellidoController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Apellido'),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              TextFormField(
                                                controller:
                                                    _documentoController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Documento'),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              TextFormField(
                                                controller: _emailController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Email'),
                                              ),
                                              TextFormField(
                                                controller: _telefonoController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Telefono'),
                                              ),
                                              TextFormField(
                                                controller:
                                                    _direccionController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Direccion'),
                                              ),
                                              TextFormField(
                                                controller: _estadoController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Estado'),
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
                                                _editarInsumo(cliente);
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
                                    primary: Colors.red,
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
                                          title: const Text('Eliminar Cliente'),
                                          content: const Text(
                                              '¿Estás seguro de que deseas eliminar este cliente?'),
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
                                                _eliminarInsumo(cliente);
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
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
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
              _apellidoController.clear();
              _documentoController.clear();
              _emailController.clear();
              _telefonoController.clear();
              _direccionController.clear();
              _estadoController.clear();
              return AlertDialog(
                title: const Text('Crear Cliente'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    TextFormField(
                      controller: _apellidoController,
                      decoration: const InputDecoration(labelText: 'Apellido'),
                    ),
                    TextFormField(
                      controller: _documentoController,
                      decoration: const InputDecoration(labelText: 'Documento'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: _telefonoController,
                      decoration: const InputDecoration(labelText: 'Telefono'),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: _direccionController,
                      decoration: const InputDecoration(labelText: 'Direccion'),
                    ),
                    TextFormField(
                      controller: _estadoController,
                      decoration: const InputDecoration(labelText: 'Estado'),
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
