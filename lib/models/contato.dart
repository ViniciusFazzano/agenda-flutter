// lib/models/contato.dart
class Contato {
  String nome;
  String telefone;
  String email;

  Contato({required this.nome, required this.telefone, required this.email});

  // Para salvar como JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  // Para carregar do JSON
  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      nome: json['nome'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }
}
