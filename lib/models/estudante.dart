class Estudante {
  int _id;
  String _nome;
  String _numero;
  String _email;

  Estudante({
    required int id,
    required String nome,
    required String numero,
    required String email,
  })
      : _id = id,
        _nome = nome,
        _numero = numero,
        _email = email;

  // Getters
  int get id => _id;

  String get nome => _nome;

  String get numero => _numero;

  String get email => _email;

  // Setters com validação
  set nome(String Nome) {
    if (Nome
        .trim()
        .isEmpty) throw ArgumentError('Nome não pode ser vazio');
    _nome = Nome;
  }

  set email(String Email) {
    if (!Email.contains('@')) throw ArgumentError('Email inválido');
    _email = Email;
  }

  Map<String, dynamic> toJson() =>
      {
        'id': _id,
        'nome': _nome,
        'numero': _numero,
        'email': _email,
      };

  factory Estudante.fromJson(Map<String, dynamic> json){
    return Estudante(
        id: json['id'],
        nome: json['nome'],
        numero: json['numero'],
        email: json['email'],
    );
  }

  @override
  String toString() {
    return 'Estudante(id: $_id, nome: $_nome, numero: $_numero, email: $_email)';
  }
}
