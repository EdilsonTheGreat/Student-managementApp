

import 'package:studente_managementapp/models/estudante.dart';
import 'package:studente_managementapp/services/storage_serv.dart';

class EstudanteCtr {
  final Storageserv _storage = Storageserv();

  Future<List<Estudante>> carregarEstudantes() async {
    return await _storage.carregarEstudante();
  }

  Future<void> adicionarEstudante(
      List<Estudante> estudantes,
      String nome,
      String numero,
      String email,
      ) async {
    final novo = Estudante(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: nome,
      numero: numero,
      email: email,
    );
    estudantes.add(novo);
    await _storage.salvarEstudante(estudantes);
  }

  Future<void> editarEstudante(
      List<Estudante> estudantes,
      Estudante editando,
      String nome,
      String numero,
      String email,
      ) async {
    final index = estudantes.indexWhere((e) => e.id == editando.id);
    estudantes[index] = Estudante(
      id: editando.id,
      nome: nome,
      numero: numero,
      email: email,
    );
    await _storage.salvarEstudante(estudantes);
  }

  Future<void> removerEstudante(List<Estudante> estudantes, int id) async {
    estudantes.removeWhere((e) => e.id == id);
    await _storage.salvarEstudante(estudantes);
  }

  List<Estudante> pesquisar(List<Estudante> estudantes, String texto) {
    if (texto.isEmpty) return estudantes;
    return estudantes
        .where((e) => e.nome.toLowerCase().contains(texto.toLowerCase()))
        .toList();
  }
}