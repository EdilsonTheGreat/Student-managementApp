import 'package:studente_managementapp/models/disciplina.dart';
import 'package:studente_managementapp/models/estudante.dart';

class Nota {
  int _id;
  int _estudanteId;
  int _disciplinaId;
  int _avaliacaoId;
  double _valor;

  Nota({
    required int id,
    required int estudanteId,
    required int disciplinaId,
    required int avaliacaoId,
    required double valor,
  })
      : _id = id,
        _estudanteId = estudanteId,
        _disciplinaId = disciplinaId,
        _avaliacaoId = avaliacaoId,
        _valor = valor;

  double get valor => _valor;

  int get disciplinaId => _disciplinaId;

  int get estudanteId => _estudanteId;

  int get id => _id;

  int get avaliacaoId => _avaliacaoId;

  set valor(double Valor) {
    if (Valor < 0 || valor > 20)
      throw ArgumentError('A nota deve ser maior ou igual a 0 e menor que 20');
    _valor = Valor;
  }

  bool get aprovado => _valor >= 10;

  String detalhes(Estudante estudante, Disciplina disciplina) {
    return 'Nota de ${estudante.nome} em ${disciplina.nome}: $_valor(${aprovado
        ? 'Aprovado'
        : 'Reprovado'}';
  }

  static double calcularMedia(List<Nota>notas){
    if(notas.isEmpty)return 0;
    final soma = notas.fold(0.0, (total,n) => total +n.valor);
    return soma/notas.length;

  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'estudanteId': _estudanteId,
      'disciplinaId': _disciplinaId,
      'avaliacaoId': _avaliacaoId,
      'valor': _valor,
    };
  }

  factory Nota.fromJson(Map<String, dynamic> json){
    return Nota(id: json['id'],
        estudanteId: json['estudanteId'],
        disciplinaId: json['disciplinaId'],
        avaliacaoId: json['avaliacaoId'],
        valor: json['valor'],
    );
  }

  @override
  String toString() {
    return 'Nota{_id: $_id, _estudanteId: $_estudanteId, _disciplinaId: $_disciplinaId, _avalicaoId: $_avaliacaoId, _valor: $_valor}';
  }
}
