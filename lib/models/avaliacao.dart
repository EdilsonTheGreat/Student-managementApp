class Avaliacao {
  int _id;
  String _nome;
  double _peso;
  int _disciplinaId;

  Avaliacao({
    required int id,
    required String nome,
    required double peso,
    required int disciplinaId,
  })
      : _id = id,
        _nome = nome,
        _peso = peso,
        _disciplinaId = disciplinaId;

  int get disciplinaId => _disciplinaId;

  double get peso => _peso;

  String get nome => _nome;

  int get id => _id;

  set peso(double Peso) {
    if (Peso < 0 || Peso > 1)
      throw ArgumentError('O campo nao pode estar vazio');
    _peso = Peso;
  }

  set nome(String Nome) {
    if (Nome
        .trim()
        .isEmpty)
      throw ArgumentError('O campo nao pode estar vazio');
    _nome = Nome;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'nome': _nome,
      'peso': _peso,
      'disciplinaId': _disciplinaId,
    };
  }

  factory Avaliacao.fromJson(Map<String, dynamic> json){
    return Avaliacao(id: json['id'],
        nome: json['nome'],
        peso: json['peso'],
        disciplinaId: json['disciplinaId'],
    );
  }

  @override
  String toString() {
    return 'Avaliacao{_id: $_id, _nome: $_nome, _peso: $_peso, _disciplinaId: $_disciplinaId}';
  }
}
