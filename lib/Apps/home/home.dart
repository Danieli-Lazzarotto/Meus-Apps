import 'package:conversormoedas/Apps/calculadora/calc_page.dart';
import 'package:conversormoedas/Apps/chat/chatscreen.dart';
import 'package:conversormoedas/Apps/gifs/homegifs.dart';

import 'package:conversormoedas/Apps/imc/imc.dart';
import 'package:conversormoedas/Apps/listadecontatos/pages/home_contatos.dart';
import 'package:conversormoedas/Apps/moedas/moedas.dart';
import 'package:conversormoedas/Apps/tarefas/homelist.dart';
import 'package:conversormoedas/utils/nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _gridView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Meus Apps'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              setState(() {
                _gridView = false;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.grid_on),
            onPressed: () {
              setState(() {
                _gridView = true;
              });
            },
          )
        ],
      ),
      body: body(context),
    );
  }

  body(BuildContext context) {
    if (_gridView) {
      return Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Icon(
              Icons.cloud,
              size: 110,
              color: Colors.white,
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(30),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    child: buildDashboardButton(
                      icon: Icons.monetization_on,
                      text: "Conversor",
                      color: Colors.amber,
                      function: () => push(
                        context,
                        const Conversor(),
                      ),
                    ),
                  ),
                  Card(
                    child: buildDashboardButton(
                      icon: Icons.calculate_outlined,
                      text: "Calculadora",
                      color: Colors.orange,
                      function: () => push(
                        context,
                        const CalcPage(),
                      ),
                    ),
                  ),
                  Card(
                    child: buildDashboardButton(
                      icon: Icons.people_alt_rounded,
                      text: "IMC",
                      color: Colors.teal.shade400,
                      function: () => push(
                        context,
                        const ImcPage(),
                      ),
                    ),
                  ),
                  Card(
                    child: buildDashboardButton(
                      icon: Icons.list_alt,
                      text: "Contatos",
                      color: Colors.blue,
                      function: () => push(
                        context,
                        const HomeContatos(),
                      ),
                    ),
                  ),
                  Card(
                    child: buildDashboardButton(
                      icon: Icons.task,
                      text: "Tarefas",
                      color: Colors.purple,
                      function: () => push(
                        context,
                        const ListTarefas(),
                      ),
                    ),
                  ),
                  Card(
                    child: buildDashboardButton(
                      icon: Icons.gif,
                      text: "Tarefas",
                      color: Colors.white,
                      function: () => push(
                        context,
                        const HomeGifs(),
                      ),
                    ),
                  ),
                  Card(
                    child: buildDashboardButton(
                      icon: Icons.chat_rounded,
                      text: "CHAT",
                      color: Colors.red,
                      function: () => push(
                        context,
                        const ChatScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Icon(
              Icons.cloud,
              size: 110,
              color: Colors.white,
            ),
            SizedBox(
              height: 250,
              child: PageView(
                children: [
                  Card(
                    margin: const EdgeInsets.all(30),
                    child: buildDashboardButton(
                      icon: Icons.monetization_on,
                      text: "Conversor",
                      color: Colors.amber,
                      function: () => push(
                        context,
                        const Conversor(),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(30),
                    child: buildDashboardButton(
                      icon: Icons.calculate_outlined,
                      text: "Calculadora",
                      color: Colors.orange,
                      function: () => push(
                        context,
                        const CalcPage(),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(30),
                    child: buildDashboardButton(
                      icon: Icons.people_alt_rounded,
                      text: "IMC",
                      color: Colors.teal.shade400,
                      function: () => push(
                        context,
                        const ImcPage(),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(30),
                    child: buildDashboardButton(
                      icon: Icons.list_alt,
                      text: "Contatos",
                      color: Colors.blue,
                      function: () => push(
                        context,
                        const HomeContatos(),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(30),
                    child: buildDashboardButton(
                      icon: Icons.task,
                      text: "Tarefas",
                      color: Colors.purple,
                      function: () => push(
                        context,
                        const ListTarefas(),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(30),
                    child: buildDashboardButton(
                      icon: Icons.gif,
                      text: "Tarefas",
                      color: Colors.white,
                      function: () => push(
                        context,
                        const HomeGifs(),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(30),
                    child: buildDashboardButton(
                      icon: Icons.chat_rounded,
                      text: "CHAT",
                      color: Colors.red,
                      function: () => push(
                        context,
                        const ChatScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  ElevatedButton buildDashboardButton(
      {required final function,
      required IconData icon,
      required String text,
      required Color color}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 150),
        primary: color,
      ),
      onPressed: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 60,
            color: Colors.black,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
