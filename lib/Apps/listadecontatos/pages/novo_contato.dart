// ignore_for_file: avoid_print

import 'dart:io';

import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos.dart';
import 'package:conversormoedas/Apps/listadecontatos/Contatos/contatos_api.dart';
import 'package:conversormoedas/Apps/listadecontatos/Database/conection.dart';
import 'package:conversormoedas/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ContatoNew extends StatefulWidget {
  const ContatoNew({Key? key}) : super(key: key);

  @override
  _ContatoNewState createState() => _ContatoNewState();
}

String imgPadrao = "assets/images/imc0.jpeg";

class _ContatoNewState extends State<ContatoNew> {
  String novaFoto = "assets/images/imc0.jpeg";
  bool testeImg = false;

  final _formKey = GlobalKey<FormState>();
  final tNome = TextEditingController();
  final tnumber = TextEditingController();
  final tnumber2 = TextEditingController();
  final temail = TextEditingController();
  final tender = TextEditingController();
  var maskCell = MaskTextInputFormatter(
      mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});

  var maskTel = MaskTextInputFormatter(
      mask: '(##) ####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _novoContato, icon: const Icon(Icons.download))
        ],
        title: const Text("Novo Contato"),
        leading: BackButton(
          onPressed: _voltarTela,
        ),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    // var mascara = MaskTextInputFormatter(
    //     mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});
    // if (imgPadrao == 15) {
    //   print("DSASDASDSADADADsADSDSADSDSDSDASDASDsaDASDASDSADSAD");
    //   mascara = MaskTextInputFormatter(
    //       mask: '(##) ####-####', filter: {"#": RegExp(r'[0-9]')});
    // }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: testeImg == false ? AssetImage(novaFoto) : img(),
                      fit: BoxFit.cover),
                ),
              ),
              onTap: () {
                ImagePicker()
                    .pickImage(source: ImageSource.camera)
                    .then((file) {
                  if (file == null) return;
                  setState(() {
                    testeImg = true;
                    imgPadrao = file.path;
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
              controller: tnumber,
              validator: _validateNumber,
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
              controller: tnumber2,
              validator: _validateNumber2,
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
              validator: validateEmail,
              controller: temail,
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
                  hintText: 'exemple@email.com',
                  labelText: 'email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: tender,
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
            //       child: _showProgress
            //           ? const CircularProgressIndicator(
            //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //             )
            //           : const Text(
            //               "Criar Novo Contato",
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 22,
            //               ),
            //             ),
            //       onPressed: () => _novoContato()),
            // ),
          ],
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
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

  _novoContato() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    int novoContato = await ContatosDao().insertEL(Contatos(
        nome: tNome.text,
        numero: tnumber.text,
        numero2: tnumber2.text,
        email: temail.text,
        endereco: tender.text,
        id: 0,
        tipo: TipoContato.ativo,
        foto: imgPadrao));
    print(novoContato);
    Navigator.pop(context);
  }

  img() {
    return FileImage(File(imgPadrao));
  }
}
