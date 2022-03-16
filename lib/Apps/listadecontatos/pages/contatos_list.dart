import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos.dart';
import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos_api.dart';
import 'package:conversormoedas/Apps/listadecontatos/Database/conection.dart';
import 'package:conversormoedas/Apps/listadecontatos/pages/contato_detalhes.dart';
import 'package:conversormoedas/Apps/listadecontatos/utils/session.dart';
import 'package:conversormoedas/utils/alert.dart';
import 'package:conversormoedas/utils/nav.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ContatosList extends StatefulWidget {
  String tipo;
  ContatosList(this.tipo, {Key? key}) : super(key: key);

  @override
  _ContatosListState createState() => _ContatosListState();
}

class _ContatosListState extends State<ContatosList> {
  // final _bloc = ContatosBloc();

  // @override
  // void initState() {
  //   super.initState();
  //   _bloc.loadContatos(widget.tipo, "");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(context) {
    return StreamBuilder<String>(
      stream: Session.streamPesquisa.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return FutureBuilder(
            future: ContatosApi.getContatos(widget.tipo, ""),
            builder: (BuildContext context, snapshotContatos) {
              if (snapshotContatos.hasData) {
                List<Contatos> contatos =
                    snapshotContatos.data as List<Contatos>;
                return _listView(contatos);
              }
              return loading();
            },
          );
        }
        if (snapshot.hasData) {
          String pesquisa = snapshot.data as String;
          return FutureBuilder(
            future: ContatosApi.getContatos(widget.tipo, pesquisa),
            builder: (BuildContext context, snapshotContatos) {
              if (snapshotContatos.hasData) {
                List<Contatos> contatos =
                    snapshotContatos.data as List<Contatos>;
                return _listView(contatos);
              }
              return loading();
            },
          );
        }
        return loading();
      },
    );
  }

  Widget loading() {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  Container _listView(List<Contatos> contatos) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: ListView.builder(
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            Contatos contato = contatos[index];

            Color cor = Colors.green;
            if (contato.tipo == TipoContato.bloqueado) {
              cor = Colors.red;
            }
            if (contato.tipo == TipoContato.removido) {
              cor = Colors.black;
            }

            if (contato.tipo == TipoContato.ativo) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: cor,
                  child: Text(contato.nome.toUpperCase().substring(0, 1)),
                ),
                onLongPress: () => push(context, ContatoDetalhe(contato)),
                onTap: () => _showOptions(context, contato),
                title: Text(contato.nome),
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.block, color: Colors.redAccent),
                      onPressed: () async => await ContatosDao()
                          .update(Contatos(
                              nome: contato.nome,
                              numero: contato.numero,
                              numero2: contato.numero2,
                              email: contato.email,
                              endereco: contato.endereco,
                              tipo: TipoContato.bloqueado,
                              id: contato.id,
                              foto: contato.foto))
                          .then((_) => {setState(() {})}),
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black),
                        onPressed: () => alert(
                            context, "Deseja mover o contato para a lixeira?",
                            callback: () async => {
                                  await ContatosDao()
                                      .update(Contatos(
                                          nome: contato.nome,
                                          numero: contato.numero,
                                          numero2: contato.numero2,
                                          email: contato.email,
                                          endereco: contato.endereco,
                                          tipo: TipoContato.removido,
                                          id: contato.id,
                                          foto: contato.foto))
                                      .then((_) => {setState(() {})}),
                                })),
                  ],
                ),
              );
            }
            if (contato.tipo == TipoContato.bloqueado) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: cor,
                  child: Text(contato.nome.toUpperCase().substring(0, 1)),
                ),
                onLongPress: () => push(context, ContatoDetalhe(contato)),
                title: Text(contato.nome),
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () async => await ContatosDao()
                          .update(Contatos(
                              nome: contato.nome,
                              numero: contato.numero,
                              numero2: contato.numero2,
                              email: contato.email,
                              endereco: contato.endereco,
                              tipo: TipoContato.ativo,
                              id: contato.id,
                              foto: contato.foto))
                          .then((_) => {setState(() {})}),
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black),
                        onPressed: () => alert(
                            context, "Deseja mover o contato para a lixeira?",
                            callback: () async => {
                                  await ContatosDao()
                                      .update(Contatos(
                                          nome: contato.nome,
                                          numero: contato.numero,
                                          numero2: contato.numero2,
                                          email: contato.email,
                                          endereco: contato.endereco,
                                          tipo: TipoContato.removido,
                                          id: contato.id,
                                          foto: contato.foto))
                                      .then((_) => {setState(() {})}),
                                })),
                  ],
                ),
              );
            }
            return ListTile(
                leading: CircleAvatar(
                  backgroundColor: cor,
                  child: Text(contato.nome.toUpperCase().substring(0, 1)),
                ),
                title: Text(contato.nome),
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.upload, color: Colors.green),
                      onPressed: () =>
                          alert(context, "Deseja restaurar este contato?",
                              callback: () async => {
                                    await ContatosDao()
                                        .update(Contatos(
                                            nome: contato.nome,
                                            numero: contato.numero,
                                            numero2: contato.numero2,
                                            email: contato.email,
                                            endereco: contato.endereco,
                                            tipo: TipoContato.ativo,
                                            id: contato.id,
                                            foto: contato.foto))
                                        .then((_) => {setState(() {})}),
                                  }),
                    )
                  ],
                ));
          }),
    );
  }

  _showOptions(BuildContext context, contato) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              launch("tel:${contato.numero2}");
                            },
                            icon: const Icon(
                              Icons.maps_home_work,
                              color: Colors.brown,
                            )),
                        IconButton(
                            onPressed: () {
                              launch("tel:${contato.numero}");
                            },
                            icon: const Icon(
                              Icons.phone_rounded,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () async {
                              var whatsappUrl =
                                  "whatsapp://send?phone=+${contato.numero}&text=Olá,tudo bem ?";

                              if (await canLaunch(whatsappUrl)) {
                                await launch(whatsappUrl);
                              } else {
                                throw 'Could not launch $whatsappUrl';
                              }
                            },
                            icon: const Icon(
                              Icons.chat_rounded,
                              color: Colors.green,
                            )),
                        IconButton(
                            onPressed: () async {
                              var teste = contato.email;
                              print(teste);
                              final Uri params = Uri(
                                scheme: 'mailto',
                                path: teste,
                                query:
                                    'subject=Reportar&body=Detalhe aqui qual bug você encontrou: ',
                              );
                              String url = params.toString();
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                print('Could not launch $url');
                              }
                            },
                            icon: const Icon(
                              Icons.mail,
                              color: Colors.purple,
                            )),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  void dispose() {
    super.dispose();

    // _bloc.dispose();
    // Session.streamPesquisa.dispose();
  }
}
