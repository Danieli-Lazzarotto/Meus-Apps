import 'dart:async';

import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos.dart';
import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos_api.dart';

class ContatosBloc {
  final _streamController = StreamController<List<Contatos>>();

  get stream => _streamController.stream;

  loadContatos(tipo, nome) async {
    List<Contatos> contatos = await ContatosApi.getContatos(tipo, nome);
    // ignore: avoid_print
    print("object");

    _streamController.add(contatos);
  }

  void dispose() {
    _streamController.close();
  }
}
