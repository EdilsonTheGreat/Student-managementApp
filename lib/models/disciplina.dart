class Disciplina {
  int _id;
  String _nome;
  String _codigo;
  int _creditos;

  Disciplina({
    required int id,
    required String nome,
    required String codigo,
    required int creditos,
  }) : _id = id,
       _nome = nome,
       _codigo = codigo,
       _creditos = creditos;

  // Getters
  int get id => _id;

  String get nome => _nome;

  String get codigo => _codigo;

  int get creditos => _creditos;

  // Setters com validação
  set nome(String nome) {
    if (nome.trim().isEmpty) throw ArgumentError('Nome não pode ser vazio');
    _nome = nome;
  }

  set creditos(int creditos) {
    if (creditos <= 0) throw ArgumentError('Créditos devem ser maior que zero');
    _creditos = creditos;
  }

  @override
  String toString() {
    return 'Disciplina(id: $_id, nome: $_nome, codigo: $_codigo, creditos: $_creditos)';
  }
}
