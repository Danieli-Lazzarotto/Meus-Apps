import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  _ImcPageState createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  double teste = 0;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final peso = TextEditingController();
  final altura = TextEditingController();

  String infoText = "Informe seus dados";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        actions: [
          IconButton(
            onPressed: reset,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: calculadora(context),
    );
  }

  calculadora(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: peso,
              onChanged: (peso) => peso.isEmpty ? limpa() : peso,
              validator: validatePeso,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  icon: Icon(
                    Icons.person_outline,
                    size: 50,
                    color: Colors.teal.shade400,
                  ),
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.teal.shade400)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal.shade400, fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: altura,
              onChanged: (altura) => altura.isEmpty ? limpa() : altura,
              validator: validateAltura,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.height_rounded,
                    size: 50,
                    color: Colors.teal.shade400,
                  ),
                  border: const OutlineInputBorder(),
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.teal.shade400)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal.shade400, fontSize: 20),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: ElevatedButton(
                onPressed: () => calcular(),
                child: const Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.teal.shade400,
                ),
              ),
            ),
            Text(
              infoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal.shade400, fontSize: 25),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              height: 260,
              child: (Card(
                child: _img(),
              )),
            )
          ],
        ),
      ),
    );
  }

  String? validatePeso(String? value) {
    if (value!.isEmpty) {
      return 'infomre o peso';
    }
    return null;
  }

  String? validateAltura(String? value) {
    if (value!.isEmpty) {
      return 'infomre a altura';
    }
    return null;
  }

  reset() {
    setState(() {
      teste = 0;
      peso.clear();
      altura.clear();
      infoText = "Informe seus dados";
      _formkey = GlobalKey<FormState>();
    });
  }

  calcular() async {
    if (!_formkey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 5));
      _formkey.currentState?.reset();
      setState(() {});
    }

    try {
      if (peso.text.isNotEmpty || altura.text.isNotEmpty) {
        setState(() {
          double pesoFinal = double.parse(peso.text);
          double alturaFinal = double.parse(altura.text) / 100;
          double imc = pesoFinal / (alturaFinal * alturaFinal);
          teste = imc;
          if (imc < 18.6) {
            infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
          } else if (imc >= 18.6 && imc < 24.9) {
            infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
          } else if (imc >= 24.9 && imc < 29.9) {
            infoText =
                "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
          } else if (imc >= 29.9 && imc < 34.9) {
            infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
          } else if (imc >= 34.9 && imc < 39.9) {
            infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
          } else if (imc >= 40) {
            infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
          }
        });
      }
    } catch (e) {
      setState(() {
        infoText = "Informe valores validos";
        peso.clear();
        altura.clear();
      });
    }
  }

  _img() {
    if (teste == 0) {
      return Image.asset(
        "assets/images/imc0.jpeg",
        fit: BoxFit.cover,
      );
    } else if (teste <= 18.5) {
      return Image.asset(
        "assets/images/imc1.jpeg",
        fit: BoxFit.scaleDown,
      );
    } else if (teste >= 18.6 && teste < 24.9) {
      return Image.asset(
        "assets/images/imc2.jpeg",
        fit: BoxFit.scaleDown,
      );
    } else if (teste >= 18.6 && teste < 24.9) {
      return Image.asset(
        "assets/images/imc2.jpeg",
        fit: BoxFit.scaleDown,
      );
    } else if (teste >= 25 && teste < 29.9) {
      return Image.asset(
        "assets/images/imc3.jpeg",
        fit: BoxFit.scaleDown,
      );
    } else if (teste >= 30 && teste < 34.9) {
      return Image.asset(
        "assets/images/imc4.jpeg",
        fit: BoxFit.scaleDown,
      );
    } else if (teste >= 35 && teste < 39.9) {
      return Image.asset(
        "assets/images/imc5.jpeg",
        fit: BoxFit.scaleDown,
      );
    } else if (teste >= 40) {
      return Image.asset(
        "assets/images/imc6.jpeg",
        fit: BoxFit.scaleDown,
      );
    }
  }

  limpa() {
    setState(() {
      teste = 0;
      infoText = "Informe valores validos";
    });
  }
}
