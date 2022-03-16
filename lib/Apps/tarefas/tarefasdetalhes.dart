// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TarefaDetalde extends StatefulWidget {
  var todolist;

  // ListTarefas todolist;
  TarefaDetalde(this.todolist, {Key? key}) : super(key: key);

  @override
  _TarefaDetadjeState createState() => _TarefaDetadjeState();
}

// ignore: recursive_getters

class _TarefaDetadjeState extends State<TarefaDetalde> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: Text("Detalhes"),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    print(widget.todolist["title"]);
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          TextFormField(
            enabled: false,
            initialValue: widget.todolist["title"],
            decoration: InputDecoration(
                labelText: "Nome da Tarefa",
                labelStyle:
                    TextStyle(color: Colors.purple.shade800, fontSize: 20)),
          ),
          TextFormField(
            enabled: false,
            initialValue: widget.todolist["startDate"],
            decoration: InputDecoration(
                labelText: "Data inicio",
                labelStyle:
                    TextStyle(color: Colors.purple.shade800, fontSize: 20)),
          ),
          TextFormField(
            enabled: false,
            initialValue: widget.todolist["endDate"],
            decoration: InputDecoration(
              labelText: "Data fim",
              labelStyle:
                  TextStyle(color: Colors.purple.shade800, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Descrição",
            style: TextStyle(color: Colors.purple.shade800, fontSize: 15),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 250,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "      ${widget.todolist["description"]}",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
