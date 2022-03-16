// ignore_for_file: avoid_print

import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos_api.dart';
import 'package:conversormoedas/Apps/listadecontatos/Database/conection.dart';
import 'package:conversormoedas/Apps/listadecontatos/pages/contatos_list.dart';
import 'package:conversormoedas/Apps/listadecontatos/pages/novo_contato.dart';
import 'package:conversormoedas/Apps/listadecontatos/utils/session.dart';
import 'package:conversormoedas/utils/alert.dart';
import 'package:conversormoedas/utils/nav.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeContatos extends StatefulWidget {
  const HomeContatos({Key? key}) : super(key: key);

  @override
  _HomeContatosState createState() => _HomeContatosState();
}

class _HomeContatosState extends State<HomeContatos>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController!.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController!.removeListener(_handleTabIndex);
    _tabController!.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    // Session.streamPesquisa.dispose();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 8, 4),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              width: MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    onChanged: (value) => _pesquisar(value),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Pesquisar",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(28),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
          title: const Text(
            'Contatos',
            style: TextStyle(fontSize: 20),
          ),
          bottom: TabBar(controller: _tabController, tabs: const [
            Tab(
              text: "Contatos",
              icon: Icon(
                Icons.person,
                color: Colors.green,
              ),
            ),
            Tab(
              text: "Bloqueados",
              icon: Icon(
                Icons.block,
                color: Colors.red,
              ),
            ),
            Tab(
              text: "Removidos",
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          ContatosList(TipoContato.ativo),
          ContatosList(TipoContato.bloqueado),
          ContatosList(TipoContato.removido),
        ]),
        floatingActionButton: _bottomButtons(),
      ),
    );
  }

  void _onClickNew() {
    push(context, const ContatoNew()).then((_) => {setState(() {})});
  }

  Widget _bottomButtons() {
    int? index = _tabController?.index;

    if (index == 1) {
      return Container();
    }

    if (index == 0) {
      return _addButton();
    }
    return _deleteButton();
  }

  Widget _addButton() {
    return FloatingActionButton(
      shape: const StadiumBorder(),
      onPressed: () => _onClickNew(),
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.add,
        size: 20.0,
      ),
    );
  }

  Widget _deleteButton() {
    return FloatingActionButton(
      shape: const StadiumBorder(),
      onPressed: () => _deletar(),
      backgroundColor: Colors.red,
      child: const Icon(
        Icons.delete,
        size: 20.0,
      ),
    );
  }

  _deletar() async {
    if (await ContatosDao().existTipo(TipoContato.removido)) {
      alert(
        context,
        "Deseja realmente limpar a lixeira?, seus dados serão removidos permanentemente",
        callback: () => _deletarTodos(),
      );
    } else {
      Fluttertoast.showToast(
          msg: "SEM CONTATOS PARA REMOVER!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {});
    }
  }

  _deletarTodos() {
    ContatosDao().deleteBytipo('removido');
    Fluttertoast.showToast(
        msg: "TODOS OS CONTATOS REMOVIDOS!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {});
  }

  void _pesquisar(String value) {
    print('pesquisar: $value');

    Session.streamPesquisa.change(value);
  }
}
