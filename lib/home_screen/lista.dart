import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_screen/camara.dart';
import 'package:flutter_application_2/home_screen/categorias.dart';
import 'package:flutter_application_2/home_screen/clientes.dart';
import 'package:flutter_application_2/home_screen/gps.dart';
import 'package:flutter_application_2/home_screen/insumos.dart';
import 'package:flutter_application_2/home_screen/productos.dart';
import 'package:flutter_application_2/home_screen/proveedores.dart';

class MyList extends StatelessWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          _buildListItem(
            title: 'Lista de Insumos',
            icon: Icons.water_drop_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InsumosList()),
              );
            },
          ),
          _buildListItem(
            title: 'Lista de Categorías',
            icon: Icons.list_alt,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoriaList()),
              );
            },
          ),
          _buildListItem(
            title: 'Lista de Productos',
            icon: Icons.production_quantity_limits,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductosList()),
              );
            },
          ),
          _buildListItem(
            title: 'Lista de Clientes',
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ClientesList()),
              );
            },
          ),
          _buildListItem(
            title: 'Camara',
            icon: Icons.camera,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            },
          ),
          _buildListItem(
            title: 'Gps',
            icon: Icons.camera,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapSample(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black, // Cambia el color del texto
          fontSize: 16, // Tamaño de fuente
          fontWeight: FontWeight.bold, // Negrita
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.blue, // Cambia el color del icono
      ),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}
