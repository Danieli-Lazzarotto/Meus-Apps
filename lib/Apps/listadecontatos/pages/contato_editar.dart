// ignore_for_file: avoid_print

import 'dart:io';

import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos.dart';
import 'package:conversormoedas/Apps/listadecontatos/Database/conection.dart';
import 'package:conversormoedas/utils/alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContatoEditar extends StatefulWidget {
  Contatos contato;

  ContatoEditar(this.contato, {Key? key}) : super(key: key);

  @override
  _ContatoEditarState createState() => _ContatoEditarState();
}

class _ContatoEditarState extends State<ContatoEditar> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? tNome;
  TextEditingController? tNumero;
  TextEditingController? tNumero2;
  TextEditingController? tEmail;
  TextEditingController? tEndereco;
  String? tfoto;

  @override
  void initState() {
    super.initState();
    tNome = TextEditingController(text: widget.contato.nome);
    tNumero = TextEditingController(text: widget.contato.numero);
    tNumero2 = TextEditingController(text: widget.contato.numero2);
    tEmail = TextEditingController(text: widget.contato.email);
    tEndereco = TextEditingController(text: widget.contato.endereco);
    tfoto = widget.contato.foto;
  }

  var maskCell = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

  var maskTel = MaskTextInputFormatter(
      mask: '(##) ####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _editarContato(),
              icon: const Icon(Icons.download))
        ],
        title: Text(widget.contato.nome),
        leading: BackButton(
          onPressed: _voltarTela,
        ),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
                          ? const AssetImage("assets/images/imc0.jpeg")
                          : img(),
                      fit: BoxFit.cover),
                ),
              ),
              onTap: () {
                ImagePicker()
                    .pickImage(source: ImageSource.camera)
                    .then((file) {
                  if (file == null) return;
                  setState(() {
                    widget.contato.foto = file.path;
                  });
                });
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: tNome,
              keyboardType: TextInputType.text,
              validator: _validateNome,
              style: const TextStyle(color: Colors.blue, fontSize: 20),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  hintText: 'Digite o nome',
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              validator: _validateNumber,
              controller: tNumero,
              keyboardType: TextInputType.number,
              inputFormatters: [maskCell],
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                  hintText: 'Digitite o numero',
                  labelText: 'Numero',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              validator: _validateNumber2,
              controller: tNumero2,
              keyboardType: TextInputType.number,
              inputFormatters: [maskTel],
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.house_outlined,
                    color: Colors.brown,
                  ),
                  hintText: 'Digitite o numero',
                  labelText: 'Numero',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              validator: _validateEmail,
              controller: tEmail,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.mail,
                    color: Colors.purple,
                  ),
                  hintText: 'example@email.com',
                  labelText: 'email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: tEndereco,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.red,
                  ),
                  hintText: 'Digite o endereço',
                  labelText: 'endereço',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            const SizedBox(
              height: 12,
            ),
            // Container(
            //   height: 50,
            //   margin: const EdgeInsets.only(top: 20.0),
            //   child: ElevatedButton(
            //       child: const Text(
            //         "Editar Contato",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 22,
            //         ),
            //       ),
            //       onPressed: () => _editarContato()),
            // )
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    String mail =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(mail);
    if (!regex.hasMatch(value!)) {
      return 'Entre com um email valido';
    }
    return null;
  }

  String? _validateNome(String? value) {
    if (value!.isEmpty) {
      return 'Informe o nome';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value!.length < 15) {
      return 'Infomre um número valido';
    }
    return null;
  }

  String? _validateNumber2(String? value) {
    if (value == "") {
      return null;
    }
    if (value!.length < 14) {
      return 'Infomre um número valido';
    }
    return null;
  }

  void _voltarTela() {
    alertAndClose(context, "Seus dados serão perdidos, deseja mesmo sair?");
  }

  _editarContato() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final contatoEditado = Contatos(
        nome: tNome!.text,
        numero: tNumero!.text,
        numero2: tNumero!.text,
        email: tEmail!.text,
        endereco: tEndereco!.text,
        id: widget.contato.id,
        tipo: widget.contato.tipo,
        foto: widget.contato.foto);

    if (tNome!.text != widget.contato.nome ||
        tNumero!.text != widget.contato.numero ||
        tNumero2!.text != widget.contato.numero2 ||
        tEmail!.text != widget.contato.email ||
        tEndereco!.text != widget.contato.endereco ||
        tfoto != widget.contato.foto) {
      alert(context,
          "Os Dados do contato serão alterados, Deseja mesmo continuar?",
          callback: () async {
        await ContatosDao().update(contatoEditado);
        Navigator.pop(context, contatoEditado);
      });
    } else {
      Navigator.pop(context);
    }
  }

  img() {
    return FileImage(File(widget.contato.foto));
  }
}
