import 'dart:async';

class StreamPesquisa {
  final pesquisa = StreamController<String>.broadcast();

  get stream => pesquisa.stream.asBroadcastStream();

  change(String valor) {
    pesquisa.sink.add(valor);
  }

  // dispose() {
  //   pesquisa.sink.close();
  // }
}
