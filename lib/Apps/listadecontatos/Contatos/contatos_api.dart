// ignore_for_file: avoid_print

import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos.dart';
import 'package:conversormoedas/Apps/listadecontatos/Database/conection.dart';

class TipoContato {
  static const String ativo = "ativo";
  static const String bloqueado = "bloqueado";
  static const String removido = "removido";
}

class ContatosApi {
  static Future<List<Contatos>> getContatos(String tipo, String nome) async {
    List<Contatos> contatos = await ContatosDao().findAllByTipo(tipo, nome);
    contatos
        .sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    return contatos;
  }
}
