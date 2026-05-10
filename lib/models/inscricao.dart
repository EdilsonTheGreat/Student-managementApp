class Inscricao {
  int _id;
  int _estudanteId;
  int _disciplinaId;

  Inscricao({
    required int id,
    required int estudanteId,
    required int disciplinaId,
  })
      : _id = id,
        _estudanteId = estudanteId,
        _disciplinaId = disciplinaId;

  int get disciplinaId => _disciplinaId;

  int get estudanteId => _estudanteId;

  int get id => _id;

  Map<String, dynamic> toJson() =>
      {
        'id': _id,
        'estudanteId': _estudanteId,
        'disciplinaId': _disciplinaId,
      };

  factory Inscricao.fromJson(Map<String, dynamic>json){
    return Inscricao(id: json['id'],
        estudanteId: json['estudanteId'],
        disciplinaId: json['diciplinaId'],
    );
  }

  @override
  String toString() {
    return 'Inscricao{_id: $_id, _estudanteId: $_estudanteId, _disciplinaId: $_disciplinaId}';
  }
}
