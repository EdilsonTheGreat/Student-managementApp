class Avaliacao {
  int _id;
  String _nome;
  int _cotacao;
  int _disciplinaId;

  Avaliacao({
    required int id,
    required String nome,
    required int cotacao,
    required int disciplinaId,
  })
      : _id = id,
        _nome = nome,
        _cotacao = cotacao,
        _disciplinaId = disciplinaId;

  int get disciplinaId => _disciplinaId;

  int get cotacao => _cotacao;

  String get nome => _nome;

  int get id => _id;

  set cotacao(int cotacao) {
    if (cotacao < 0 || cotacao > 1)
      throw ArgumentError('O campo nao pode estar vazio');
    _cotacao = cotacao;
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
      'cotacao': _cotacao,
      'disciplinaId': _disciplinaId,
    };
  }

  factory Avaliacao.fromJson(Map<String, dynamic> json){
    return Avaliacao(id: json['id'],
        nome: json['nome'],
        cotacao: json['cotacao'],
        disciplinaId: json['disciplinaId'],
    );
  }

  @override
  String toString() {
    return 'Avaliacao{_id: $_id, _nome: $_nome, _cotacao: $_cotacao, _disciplinaId: $_disciplinaId}';
  }
}
