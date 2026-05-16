import 'package:flutter/material.dart';
import 'universidad.dart';
import 'universidad_service.dart';

class UniversidadesScreen extends StatelessWidget {
  final UniversidadService _service = UniversidadService();

  UniversidadesScreen({super.key});

  void _mostrarFormulario(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FormularioUniversidad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universidades')),
      body: StreamBuilder<List<Universidad>>(
        stream: _service.obtenerUniversidadesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          final universidades = snapshot.data ?? [];
          
          if (universidades.isEmpty) {
            return const Center(child: Text('No hay universidades registradas.'));
          }

          return ListView.builder(
            itemCount: universidades.length,
            itemBuilder: (context, index) {
              final uni = universidades[index];
              return ListTile(
                title: Text(uni.nombre),
                subtitle: Text('${uni.direccion}\nNIT: ${uni.nit}'),
                trailing: const Icon(Icons.school),
                isThreeLine: true,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Formulario
class FormularioUniversidad extends StatefulWidget {
  const FormularioUniversidad({super.key});

  @override
  State<FormularioUniversidad> createState() => _FormularioUniversidadState();
}

class _FormularioUniversidadState extends State<FormularioUniversidad> {
  final _formKey = GlobalKey<FormState>();
  final UniversidadService _service = UniversidadService();
  
  String nit = '';
  String nombre = '';
  String direccion = '';
  String telefono = '';
  String paginaWeb = '';

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final nuevaUni = Universidad(
        nit: nit,
        nombre: nombre,
        direccion: direccion,
        telefono: telefono,
        paginaWeb: paginaWeb,
      );
      
      _service.agregarUniversidad(nuevaUni).then((_) {
        Navigator.pop(context); // Cerrar modal al guardar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Universidad agregada exitosamente')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16, right: 16, top: 16,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text('Nueva Universidad', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'NIT'),
              validator: (val) => val!.isEmpty ? 'Requerido' : null,
              onSaved: (val) => nit = val!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (val) => val!.isEmpty ? 'Requerido' : null,
              onSaved: (val) => nombre = val!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Dirección'),
              validator: (val) => val!.isEmpty ? 'Requerido' : null,
              onSaved: (val) => direccion = val!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Teléfono'),
              validator: (val) => val!.isEmpty ? 'Requerido' : null,
              onSaved: (val) => telefono = val!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Página Web'),
              validator: (val) {
                if (val!.isEmpty) return 'Requerido';
                final urlPattern = r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$';
                if (!RegExp(urlPattern).hasMatch(val)) return 'Ingrese una URL válida (ej. https://www.ejemplo.com)';
                return null;
              },
              onSaved: (val) => paginaWeb = val!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardar,
              child: const Text('Guardar'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}