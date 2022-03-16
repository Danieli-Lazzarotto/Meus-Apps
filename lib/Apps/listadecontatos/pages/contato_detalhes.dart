// ignore_for_file: avoid_print

import 'dart:io';

import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos.dart';
import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos_api.dart';
import 'package:conversormoedas/Apps/listadecontatos/pages/contato_editar.dart';

import 'package:conversormoedas/utils/nav.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContatoDetalhe extends StatefulWidget {
  Contatos contato;

  ContatoDetalhe(this.contato, {Key? key}) : super(key: key);

  @override
  _ContatoDetalheState createState() => _ContatoDetalheState();
}

// ignore: recursive_getters

class _ContatoDetalheState extends State<ContatoDetalhe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _edit(),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    print(widget.contato.nome);
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 140.0,
              height: 140.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: widget.contato.foto == "assets/images/imc0.jpeg"
                        ? AssetImage("assets/images/imc0.jpeg")
                        : img(),
                    fit: BoxFit.cover),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 35,
              color: Colors.blue,
            ),
            title: Text(widget.contato.nome),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              size: 35,
              color: Colors.green,
            ),
            title: Text(widget.contato.numero),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(
              Icons.house_outlined,
              size: 35,
              color: Colors.brown,
            ),
            title: Text(widget.contato.numero2),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(
              Icons.mail_outline,
              size: 35,
              color: Colors.purple,
            ),
            title: Text(widget.contato.email),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(
              Icons.location_on_outlined,
              size: 35,
              color: Colors.red,
            ),
            title: Text(widget.contato.endereco),
          ),
        ],
      ),
    );
  }

  _edit() {
    if (widget.contato.tipo == TipoContato.ativo) {
      return AppBar(
        title: Text(widget.contato.nome),
        actions: [
          IconButton(
              onPressed: () => push(context, ContatoEditar(widget.contato))
                  .then((contatoEditado) => {
                        setState(() {
                          widget.contato = contatoEditado;
                        })
                      }),
              icon: const Icon(Icons.edit))
        ],
      );
    } else {
      return AppBar(title: Text(widget.contato.nome));
    }
  }

  img() {
    return FileImage(File(widget.contato.foto));
  }
}
