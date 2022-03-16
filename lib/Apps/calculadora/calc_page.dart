import 'package:conversormoedas/Apps/calculadora/calc_page2.dart';
import 'package:conversormoedas/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalcPage extends StatefulWidget {
  const CalcPage({Key? key}) : super(key: key);

  @override
  _CalcPageState createState() => _CalcPageState();
}

var apagaDigito = [1];

String resultado = "0";
String lastResult = '';
bool bol = false;

class _CalcPageState extends State<CalcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.calculate)],
        backgroundColor: Colors.black,
        title: const Text("Calculadora"),
      ),
      body: _body(),
    );
  }

  _body() {
    var _corResultado = Colors.blue;
    if (resultado == "Erro") {
      _corResultado = Colors.red;
    }
    return Column(
      children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(15, 1, 15, 25),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                lastResult,
                maxLines: 1,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Text(
                resultado,
                maxLines: 4,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 35, color: _corResultado),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              botao("AC", operacao: "limpar", cor: "orange"),
              botao("DEL", operacao: "remover", cor: "orange"),
              botao("^", operacao: "acao", cor: "orange"),
              botao("/", operacao: "acao", cor: "orange")
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              botao('7', operacao: "add", cor: "grey800"),
              botao('8', operacao: "add", cor: "grey800"),
              botao('9', operacao: "add", cor: "grey800"),
              botao('*', operacao: "acao", cor: "orange"),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              botao('4', operacao: "add", cor: "grey800"),
              botao('5', operacao: "add", cor: "grey800"),
              botao('6', operacao: "add", cor: "grey800"),
              botao('+', operacao: "acao", cor: "orange")
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              botao('1', operacao: "add", cor: "grey800"),
              botao('2', operacao: "add", cor: "grey800"),
              botao('3', operacao: "add", cor: "grey800"),
              botao('-', operacao: "acao", cor: "orange"),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              botaomais(),
              botao('0', operacao: "add", cor: "grey800"),
              botao(".", operacao: "acao", cor: "grey800"),
              botao("=", operacao: "final", cor: "orange")
            ],
          ),
        ),
      ],
    );
  }

  Widget botao(String label, {String? operacao, String? cor}) {
    var _corBotao = Colors.grey.shade400;
    if (cor == "orange") {
      _corBotao = Colors.orange;
    }
    if (cor == "grey800") {
      _corBotao = Colors.grey.shade800;
    }

    return Expanded(
      child: ElevatedButton(
        style: TextButton.styleFrom(
            backgroundColor: _corBotao, shape: const RoundedRectangleBorder()),
        onPressed: () => _funcao(label, operacao),
        child: Text(label),
      ),
    );
  }

  Widget botaomais() {
    return Expanded(
      child: ElevatedButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.red, shape: const RoundedRectangleBorder()),
        onPressed: () => push(context, const CalcPage2(), replace: true),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  _funcao(String label, operacao) {
    if ((resultado.substring(resultado.length - 1) == "/" ||
            resultado.substring(resultado.length - 1) == "+" ||
            resultado.substring(resultado.length - 1) == "-" ||
            resultado.substring(resultado.length - 1) == "." ||
            resultado.substring(resultado.length - 1) == "*" ||
            resultado.substring(resultado.length - 1) == "^") &&
        operacao == 'acao') {
      setState(() {
        var trocaOperacao = resultado.substring(0, resultado.length - 1);
        resultado = trocaOperacao;
      });
    }

    if (operacao == "limpar") {
      apagaDigito = [1];
      setState(() {
        resultado = "0";
        lastResult = "";
      });
    }
    if (resultado == 'Erro' && operacao == "remover") {
      setState(() {
        resultado = "0";
      });
    }
    if (resultado == "0" && operacao == "add") {
      setState(() {
        resultado = "";
      });
    }

    if (resultado == "Erro" && operacao == "add") {
      setState(() {
        resultado = "";
      });
    }
    if (resultado == "Erro" && operacao == "acao") {
      setState(() {
        resultado = "0";
      });
    }

    if (operacao == "add" || operacao == "acao") {
      apagaDigito.add(label.length);
      setState(() {
        resultado += label;
      });
      if (resultado.length > 64) {
        resultado = resultado.substring(0, resultado.length - 2);
        setState(() {
          resultado += label;
        });
      }
    }
    if (operacao == "remover" && resultado != "") {
      setState(() {
        int apagaFinal = apagaDigito.last;
        var attResultado =
            resultado.substring(0, resultado.length - apagaFinal);

        if (apagaDigito.length > 1) {
          apagaDigito.removeLast();
        }
        setState(() {
          resultado = attResultado;
        });
      });
    }
    if (resultado == "") {
      setState(() {
        resultado = "0";
      });
    }

    if (operacao == "final") {
      try {
        setState(() {
          resultado = resultado.interpret().toString();
        });
        if (resultado.contains('e+')) {
          var expResultado = resultado.replaceAll(r'e+', '*(10^');
          expResultado += ')';

          setState(() {
            resultado = expResultado;
          });
        }
        if (resultado.contains('e-')) {
          var expResultado = resultado.replaceAll(r'e-', '*(10^(-');
          expResultado += '))';

          setState(() {
            resultado = expResultado;
          });
        }

        if (bol = true && operacao == "acao") {
          resultado += label;
          bol = false;
        }
      } catch (_) {
        setState(() {
          resultado = "Erro";
        });
      }
      bol = true;

      lastResult = "= $resultado";
    }
    if (bol == true && operacao == "add") {
      bol = false;
      setState(() {
        resultado = "";
        resultado = label;
      });
    }
    if (bol == true && operacao == "acao") {
      bol = false;
      resultado = resultado.substring(0, resultado.length - 1);
      setState(() {
        resultado += label;
      });
    }
  }
}
