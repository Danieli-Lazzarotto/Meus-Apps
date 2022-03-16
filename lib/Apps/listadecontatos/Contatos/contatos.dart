class Contatos {
  late int id;
  late String nome;
  late String numero;
  late String numero2;
  late String email;
  late String endereco;
  late String tipo;
  late String foto;

  Contatos(
      {required this.id,
      required this.nome,
      required this.numero,
      required this.numero2,
      required this.email,
      required this.endereco,
      required this.tipo,
      required this.foto});

  Contatos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    numero = json['numero'];
    numero2 = json['numero2'];
    email = json['email'];
    endereco = json['endereco'];
    tipo = json['tipo'] ?? 'ativo';
    foto = json["foto"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['numero'] = numero;
    data['numero2'] = numero2;
    data['email'] = email;
    data['endereco'] = endereco;
    data['tipo'] = tipo;
    data['foto'] = foto;
    return data;
  }
}
