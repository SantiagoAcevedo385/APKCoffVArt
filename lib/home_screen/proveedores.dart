// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/Componentes/input.dart';
// import 'package:flutter_application_2/models/proveedor.dart';
// import 'package:http/http.dart' as http;

// Future<AlbumProveedores> createAlbum(
//     String nit,
//     String nombre,
//     String telefono,
//     String factura,
//     String cantidad,
//     String fecha,
//     String categoria,
//     String estado) async {
//   final response = await http.post(
//     Uri.parse('https://coffevart.onrender.com/api/proveedores'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       "Nit": nit,
//       "Nombre": nombre,
//       "Telefono": telefono,
//       "Factura": factura,
//       "Cantidad": cantidad,
//       "Fecha": fecha,
//       "Categoria": categoria,
//       "Estado": estado,
//     }),
//   );

//   if (response.statusCode == 201) {
//     return AlbumProveedores.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception(response.body);
//   }
// }

// class AlbumProveedores {
//   final String id;
//   final String nit;
//   final String nombre;
//   final String telefono;
//   final String factura;
//   final String cantidad;
//   final String fecha;
//   final String categoria;
//   final String estado;

//   AlbumProveedores({
//     required this.id,
//     required this.nit,
//     required this.nombre,
//     required this.telefono,
//     required this.factura,
//     required this.cantidad,
//     required this.fecha,
//     required this.categoria,
//     required this.estado,
//   });

//   factory AlbumProveedores.fromJson(Map<String, dynamic> json) {
//     return AlbumProveedores(
//         id: json["_id"],
//         nit: json["Nit"],
//         nombre: json["Nombre"],
//         telefono: json["Telefono"],
//         factura: json["Factura"],
//         cantidad: json["Cantidad"],
//         fecha: json["Fecha"],
//         categoria: json["Categoria"],
//         estado: json["Estado"]);
//   }
// }

// class ProveedoresApp extends StatefulWidget {
//   const ProveedoresApp({Key? key}) : super(key: key);

//   @override
//   State<ProveedoresApp> createState() {
//     return _ProveedoresAppState();
//   }
// }

// class _ProveedoresAppState extends State<ProveedoresApp> {
//   final TextEditingController _nitController = TextEditingController();
//   final TextEditingController _nombreController = TextEditingController();
//   final TextEditingController _telefonoController = TextEditingController();
//   final TextEditingController _facturaController = TextEditingController();
//   final TextEditingController _cantidadController = TextEditingController();
//   final TextEditingController _fechaController = TextEditingController();
//   final TextEditingController _categoriaController = TextEditingController();
//   final TextEditingController _estadoController = TextEditingController();

//   Future<AlbumProveedores>? _futureAlbumProveedores;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Crear Proveedor'),
//         backgroundColor: Colors.red,
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(8),
//         child: (_futureAlbumProveedores == null)
//             ? buildColumn()
//             : buildFutureBuilder(),
//       ),
//     );
//   }

//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         InputCampo(
//           label: "Nit: ",
//           controller: _nitController,
//           obscureText: false,
//           validator: (value) => value!.isEmpty ? "Ingrese el nit" : null,
//           keyboardType: TextInputType.text,
//         ),
//         const SizedBox(height: 10),
//         InputCampo(
//           label: "Nombre: ",
//           controller: _nombreController,
//           obscureText: false,
//           validator: (value) => value!.isEmpty ? "Ingrese el nombre" : null,
//           keyboardType: TextInputType.text,
//         ),
//         const SizedBox(height: 10),
//         InputCampo(
//           label: "Telefono: ",
//           controller: _telefonoController,
//           obscureText: false,
//           validator: (value) => value!.isEmpty ? "Ingrese el telefono" : null,
//           keyboardType: TextInputType.text,
//         ),
//         const SizedBox(height: 10),
//         InputCampo(
//           label: "Factura: ",
//           controller: _facturaController,
//           obscureText: false,
//           validator: (value) => value!.isEmpty ? "Ingrese la factura" : null,
//           keyboardType: TextInputType.text,
//         ),
//         const SizedBox(height: 10),
//         InputCampo(
//           label: "Cantidad: ",
//           controller: _cantidadController,
//           obscureText: false,
//           validator: (value) => value!.isEmpty ? "Ingrese la cantidad" : null,
//           keyboardType: TextInputType.text,
//         ),
//         InputCampo(
//           label: "Fecha: ",
//           controller: _fechaController,
//           obscureText: false,
//           validator: (value) => value!.isEmpty ? "Ingrese la fecha" : null,
//           keyboardType: TextInputType.text,
//         ),
//         InputCampo(
//           label: "Categoria: ",
//           controller: _categoriaController,
//           obscureText: false,
//           validator: (value) => value!.isEmpty ? "Ingrese la categoria" : null,
//           keyboardType: TextInputType.text,
//         ),
//         InputCampo(
//           label: "Estado: ",
//           controller: _estadoController,
//           obscureText: false,
//           validator: (value) => value!.isEmpty ? "Ingrese el estado" : null,
//           keyboardType: TextInputType.text,
//         ),
//         const SizedBox(height: 10),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _futureAlbumProveedores = createAlbum(
//                   _nitController.text,
//                   _nombreController.text,
//                   _telefonoController.text,
//                   _facturaController.text,
//                   _cantidadController.text,
//                   _fechaController.text,
//                   _categoriaController.text,
//                   _estadoController.text);
//             });
//           },
//           child: const Text('Crear Proveedor'),
//         ),
//       ],
//     );
//   }

//   FutureBuilder<AlbumProveedores> buildFutureBuilder() {
//     return FutureBuilder<AlbumProveedores>(
//       future: _futureAlbumProveedores,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.nombre);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }

// class ProveedoresList extends StatefulWidget {
//   const ProveedoresList({Key? key}) : super(key: key);

//   @override
//   State<ProveedoresList> createState() => _ProveedoresListState();
// }

// class _ProveedoresListState extends State<ProveedoresList> {
//   bool _isLoading = false;

//   DataModel4? proveedoresList;
//   List<Proveedor> proveedores = [];
//   final TextEditingController _nitController = TextEditingController();
//   final TextEditingController _nombreController = TextEditingController();
//   final TextEditingController _telefonoController = TextEditingController();
//   final TextEditingController _facturaController = TextEditingController();
//   final TextEditingController _cantidadController = TextEditingController();
//   final TextEditingController _fechaController = TextEditingController();
//   final TextEditingController _categoriaController = TextEditingController();
//   final TextEditingController _estadoController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }

//   _getData() async {
//     _isLoading = true;
//     try {
//       String url = 'https://coffevart.onrender.com/api/proveedores';
//       http.Response res = await http.get(Uri.parse(url));
//       if (res.statusCode == 200) {
//         _isLoading = false;
//         // proveedores = DataModel4.fromJson(json.decode(res.body)).proveedores;
//         proveedoresList = DataModel4.fromJson(json.decode(res.body));
//         proveedores = proveedoresList!.proveedores;
//         setState(() {});
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   _crearInsumo() async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://coffevart.onrender.com/api/proveedores'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'Nit': _nitController.text,
//           'Nombre': _nombreController.text,
//           'Telefono': _telefonoController.text,
//           'Factura': _facturaController.text,
//           'Fecha': _fechaController.text,
//           'Cantidad': _cantidadController.text,
//           'Categoria': _categoriaController.text,
//           'Estado': _estadoController.text
//         }),
//       );

//       if (response.statusCode == 201) {
//         final nuevoProveedor = Proveedor.fromJson(jsonDecode(response.body));
//         setState(() {
//           proveedores.add(nuevoProveedor);
//           _nitController.clear();
//           _nombreController.clear();
//           _telefonoController.clear();
//           _facturaController.clear();
//           _fechaController.clear();
//           _cantidadController.clear();
//           _categoriaController.clear();
//           _estadoController.clear();
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   _editarInsumo(Proveedor proveedor) async {
//     try {
//       final response = await http.put(
//         Uri.parse('https://coffevart.onrender.com/api/proveedores'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           "_id": proveedor.id,
//           'Nit': _nitController.text,
//           'Nombre': _nombreController.text,
//           'Telefono': _telefonoController.text,
//           'Factura': _facturaController.text,
//           'Fecha': _fechaController.text,
//           'Cantidad': _cantidadController.text,
//           'Categoria': _categoriaController.text,
//           'Estado': _estadoController.text
//         }),
//       );

//       if (response.statusCode == 200) {
//         final proveedorActualizado =
//             Proveedor.fromJson(jsonDecode(response.body));
//         setState(() {
//           proveedor.nit = proveedorActualizado.nit;
//           proveedor.nombre = proveedorActualizado.nombre;
//           proveedor.telefono = proveedorActualizado.telefono;
//           proveedor.factura = proveedorActualizado.factura;
//           proveedor.fecha = proveedorActualizado.fecha;
//           proveedor.cantidad = proveedorActualizado.cantidad;
//           proveedor.categoria = proveedorActualizado.categoria;
//           proveedor.estado = proveedorActualizado.estado;
//           _nitController.clear();
//           _nombreController.clear();
//           _telefonoController.clear();
//           _facturaController.clear();
//           _fechaController.clear();
//           _cantidadController.clear();
//           _categoriaController.clear();
//           _estadoController.clear();
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   _eliminarInsumo(Proveedor proveedor) async {
//     try {
//       final response = await http.delete(
//         Uri.parse(
//             'https://coffevart.onrender.com/api/proveedores/${proveedor.nit}'),
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           // proveedores.remove(proveedor);
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gestión de Proveedores'),
//         backgroundColor: Colors.red,
//       ),
//       body: SingleChildScrollView(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   columns: const [
//                     DataColumn(label: Text('Nit')),
//                     DataColumn(label: Text('Nombre')),
//                     DataColumn(label: Text('Telefono')),
//                     DataColumn(label: Text('Factura')),
//                     DataColumn(label: Text('Cantidad')),
//                     DataColumn(label: Text('Categoria')),
//                     DataColumn(label: Text('Fecha')),
//                     DataColumn(label: Text('Estado')),
//                     DataColumn(label: Text('Acciones')),
//                   ],
//                   rows: [
//                     for (var prove in proveedores)
//                       DataRow(
//                         cells: [
//                           DataCell(Text('${prove.nit}')),
//                           DataCell(Text(prove.nombre)),
//                           DataCell(Text(prove.telefono.toString())),
//                           DataCell(Text(prove.factura)),
//                           DataCell(Text(prove.cantidad.toString())),
//                           DataCell(Text(prove.categoria)),
//                           DataCell(Text(prove.fecha)),
//                           DataCell(Text(prove.estado)),
//                           DataCell(
//                             Row(
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Editar insumo
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         _nitController.text = '${prove.nit}';
//                                         _nombreController.text = prove.nombre;
//                                         _telefonoController.text =
//                                             prove.telefono.toString();
//                                         _facturaController.text = prove.factura;
//                                         _cantidadController.text =
//                                             prove.cantidad.toString();
//                                         _categoriaController.text =
//                                             prove.categoria;
//                                         _fechaController.text = prove.fecha;
//                                         _estadoController.text = prove.estado;
//                                         return AlertDialog(
//                                           title: const Text('Editar Proveedor'),
//                                           content: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               TextFormField(
//                                                 controller: _nitController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText: 'Nit'),
//                                               ),
//                                               TextFormField(
//                                                 controller: _nombreController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText: 'Nombre'),
//                                               ),
//                                               TextFormField(
//                                                 controller: _telefonoController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText: 'Telefono'),
//                                                 keyboardType:
//                                                     TextInputType.number,
//                                               ),
//                                               TextFormField(
//                                                 controller: _facturaController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText: 'Factura'),
//                                               ),
//                                               TextFormField(
//                                                 controller: _cantidadController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText: 'Cantidad'),
//                                                 keyboardType:
//                                                     TextInputType.number,
//                                               ),
//                                               TextFormField(
//                                                 controller: _fechaController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText: 'Fecha'),
//                                               ),
//                                               TextFormField(
//                                                 controller:
//                                                     _categoriaController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText: 'Categoria'),
//                                               ),
//                                               TextFormField(
//                                                 controller: _estadoController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText: 'Estado'),
//                                               ),
//                                             ],
//                                           ),
//                                           actions: [
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text('Cancelar'),
//                                             ),
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 _editarInsumo(prove);
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text('Guardar'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                   child: const Icon(Icons.edit),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Eliminar insumo
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           title:
//                                               const Text('Eliminar Proveedor'),
//                                           content: const Text(
//                                               '¿Estás seguro de que deseas eliminar este proveedor?'),
//                                           actions: [
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text('Cancelar'),
//                                             ),
//                                             ElevatedButton(
//                                               onPressed: () {
//                                                 _eliminarInsumo(prove);
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text('Eliminar'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                   child: const Icon(Icons.delete),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               _nitController.clear();
//               _nombreController.clear();
//               _telefonoController.clear();
//               _facturaController.clear();
//               _cantidadController.clear();
//               _fechaController.clear();
//               _categoriaController.clear();
//               _estadoController.clear();
//               return AlertDialog(
//                 title: const Text('Crear Proveedor'),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextFormField(
//                       controller: _nitController,
//                       decoration: const InputDecoration(labelText: 'Nit'),
//                     ),
//                     TextFormField(
//                       controller: _nombreController,
//                       decoration: const InputDecoration(labelText: 'Nombre'),
//                     ),
//                     TextFormField(
//                       controller: _telefonoController,
//                       decoration: const InputDecoration(labelText: 'Telefono'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     TextFormField(
//                       controller: _facturaController,
//                       decoration: const InputDecoration(labelText: 'Factura'),
//                     ),
//                     TextFormField(
//                       controller: _cantidadController,
//                       decoration: const InputDecoration(labelText: 'Cantidad'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     TextFormField(
//                       controller: _fechaController,
//                       decoration: const InputDecoration(labelText: 'Fecha'),
//                     ),
//                     TextFormField(
//                       controller: _categoriaController,
//                       decoration: const InputDecoration(labelText: 'Categoria'),
//                     ),
//                     TextFormField(
//                       controller: _estadoController,
//                       decoration: const InputDecoration(labelText: 'Estado'),
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('Cancelar'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       _crearInsumo();
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text('Crear'),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
