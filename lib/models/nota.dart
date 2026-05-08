import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';

class Nota {
  int _id;
  int _estudanteId;
  int _disciplinaId;
  double _valor;

  Nota({
    required int id,
    required int estudanteId,
    required int disciplinaId,
    required double valor,
  }) : _id = id,
       _estudanteId = estudanteId,
       _disciplinaId = disciplinaId,
       _valor = valor;

  double get valor => _valor;

  int get disciplinaId => _disciplinaId;

  int get estudanteId => _estudanteId;

  int get id => _id;

  set valor(double Valor) {
    if (Valor < 0 || valor > 20)
      throw ArgumentError('A nota deve ser maior ou igual a 0 e menor que 20');
    _valor = Valor;
  }

  bool get aprovado => _valor >= 10;

  String detalhes(Estudante estudante, Disciplina disciplina) {
    return 'Nota de ${estudante.nome} em ${disciplina.nome}: $_valor(${aprovado ? 'Aprovado' : 'Reprovado'}';
  }

  @override
  String toString() {
    return 'Nota{_id: $_id, _estudanteId: $_estudanteId, _disciplinaId: $_disciplinaId, _valor: $_valor}';
  }
}
