import 'package:cloud_firestore/cloud_firestore.dart';
import 'universidad.dart';

class UniversidadService {
  final CollectionReference _coleccion = 
      FirebaseFirestore.instance.collection('universidades');

  // Stream para obtener los datos en tiempo real
  Stream<List<Universidad>> obtenerUniversidadesStream() {
    return _coleccion.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Universidad.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Método para crear una nueva universidad
  Future<void> agregarUniversidad(Universidad universidad) async {
    try {
      await _coleccion.add(universidad.toMap());
    } catch (e) {
      throw Exception('Error al agregar universidad: $e');
    }
  }
}