import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

alert(BuildContext context, String msg, {Function? callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text("ATENÇÃO"),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("SIM"),
              onPressed: () {
                Navigator.pop(context);
                if (callback != null) {
                  callback();
                }
              },
            ),
            ElevatedButton(
              child: const Text("NÃO"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

alertAndClose(BuildContext context, String msg) {
  alert(context, msg, callback: () => Navigator.pop(context));
}

alertOk(BuildContext context, String msg, {Function? callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text("ATENÇÃO"),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                if (callback != null) {
                  callback();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

alertTask(BuildContext context, String msg,
    callback(title, startDate, endDate, description)) {
  final toDoController = TextEditingController();
  final description = TextEditingController();
  final endDate = TextEditingController();
  final startDate = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var maksDate = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: toDoController,
                        validator: validateName,
                        decoration: InputDecoration(
                            labelText: "Nova Tarefa",
                            labelStyle:
                                TextStyle(color: Colors.purple.shade800)),
                      ),
                      TextFormField(
                        inputFormatters: [maksDate],
                        validator: validateDate,
                        controller: startDate,
                        decoration: InputDecoration(
                            labelText: "Data inicio",
                            labelStyle:
                                TextStyle(color: Colors.purple.shade800)),
                      ),
                      TextFormField(
                        inputFormatters: [maksDate],
                        controller: endDate,
                        validator: validateDate,
                        decoration: InputDecoration(
                            labelText: "Data fim",
                            labelStyle:
                                TextStyle(color: Colors.purple.shade800)),
                      ),
                      SizedBox(
                        height: 300,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 50),
                          child: TextFormField(
                            maxLength: 200,
                            controller: description,
                            maxLines: null,
                            decoration: InputDecoration(
                                labelText: "Descrição",
                                labelStyle:
                                    TextStyle(color: Colors.purple.shade800)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  callback(toDoController.text, startDate.text, endDate.text,
                      description.text);
                  Navigator.pop(context);
                }
              },
            ),
            ElevatedButton(
                child: const Text("Sair"),
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.pop(context);
                }),
          ],
        ),
      );
    },
  );
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return 'Tarefa Invalida';
  }
  return null;
}

String? validateDate(String? value) {
  if (value!.length != 10) {
    return 'Data invalida';
  }
  var teste = value.substring(3, 5).toString();

  double teste1 = double.parse(teste);
  if (teste1 > 12) {
    return 'Data invalida';
  }
  var teste2 = value.substring(0, 2).toString();

  double teste3 = double.parse(teste2);
  if (teste3 > 31) {
    return 'Data invalida';
  }
  if ((teste1 == 01 ||
          teste1 == 03 ||
          teste1 == 05 ||
          teste1 == 07 ||
          teste1 == 08 ||
          teste1 == 10 ||
          teste1 == 12) &&
      teste3 > 31) {
    return 'Data invalida';
  }

  if ((teste1 == 04 || teste1 == 06 || teste1 == 09 || teste1 == 11) &&
      teste3 > 30) {
    return 'Data invalida';
  }

  if (teste1 == 02 && teste3 > 29) {
    return "Data invalida";
  }
  return null;
}
