class Inscricao {
  int _id;
  int _estudanteId;
  int _disciplinaId;

  Inscricao({
    required int id,
    required int estudanteId,
    required int disciplinaId,
  })  : _id = id,
        _estudanteId = estudanteId,
        _disciplinaId = disciplinaId;

  int get id => _id;
  int get estudanteId => _estudanteId;
  int get disciplinaId => _disciplinaId;

  Map<String, dynamic> toJson() => {
    'id': _id,
    'estudanteId': _estudanteId,
    'disciplinaId': _disciplinaId,
  };

  factory Inscricao.fromJson(Map<String, dynamic> json) {
    return Inscricao(
      id: json['id'] as int,
      estudanteId: json['estudanteId'] as int,
      disciplinaId: json['disciplinaId'] as int,
    );
  }

  @override
  String toString() {
    return 'Inscricao(id: $_id, estudanteId: $_estudanteId, disciplinaId: $_disciplinaId)';
  }
}