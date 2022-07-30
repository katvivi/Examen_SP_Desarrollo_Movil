import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String calcText = "";
  int count = 0;
  String dob = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff22252D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height / 15,
                  //color: Colors.amber,
                  child: Text(
                    calcText,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          Container(
            height: size.height / 1.7,
            decoration: const BoxDecoration(
                color: Color(0xff2A2D36),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    blocks("AC", Colors.green),
                    blocks("CC", Colors.green),
                    blocks("%", Colors.green),
                    blocks("/", Colors.red)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    blocks("1"),
                    blocks("2"),
                    blocks("3"),
                    blocks("x", Colors.red)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    blocks("4"),
                    blocks("5"),
                    blocks("6"),
                    blocks("+", Colors.red)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    blocks("7"),
                    blocks("8"),
                    blocks("9"),
                    blocks("-", Colors.red)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    blocks(":"),
                    blocks("0"),
                    blocks("."),
                    blocks(
                        "=", count == 0 ? Colors.red : Colors.lightBlueAccent)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget blocks(String texto, [Color? color]) {
    return GestureDetector(
      onTap: () {
        if (texto == "AC") {
          setState(() {
            calcText = "";
          });
        } else if (texto == "=") {
          if (count == 0) {
            setState(() {
              //Realizar el cálculo
              String valorActual = calcText;

              print(valorActual);
              String expression = valorActual;
              int lastPos = 0;
              List<double> exprVar = [];
              List<String> operator = [];
              for (int i = 0; i < expression.length; i++) {
                if (expression[i] == "+" ||
                    expression[i] == "-" ||
                    expression[i] == "/" ||
                    expression[i] == "x") {
                  operator.add(expression[i]);
                  exprVar.add(double.parse(expression.substring(lastPos, i)));
                  lastPos = i + 1;
                }
                if (i == expression.length - 1) {
                  exprVar
                      .add(double.parse(expression.substring(lastPos, i + 1)));
                }
              }
              for (int i = 0; i < operator.length; i++) {
                if (operator[i] == "-") {
                  exprVar[i + 1] = exprVar[i + 1] * -1;
                }
              }

              int i = 0;
              List<double> newValues = exprVar;
              while (operator.isNotEmpty) {
                if (operator.contains('/')) {
                  int opXIndex = operator.indexOf('/');
                  double firstNumber = exprVar[opXIndex];
                  double secondNumber = exprVar[opXIndex + 1];
                  double result = firstNumber / secondNumber;
                  newValues.removeAt(exprVar.indexOf(secondNumber));
                  newValues[exprVar.indexOf(firstNumber)] = result;
                  operator.removeAt(opXIndex);
                  continue;
                }
                if (operator.contains('x')) {
                  int opXIndex = operator.indexOf('x');
                  double firstNumber = exprVar[opXIndex];
                  double secondNumber = exprVar[opXIndex + 1];
                  double result = firstNumber * secondNumber;
                  newValues.removeAt(exprVar.indexOf(secondNumber));
                  newValues[exprVar.indexOf(firstNumber)] = result;
                  operator.removeAt(opXIndex);
                  continue;
                }
                if (operator.contains('+')) {
                  int opXIndex = operator.indexOf('+');
                  double firstNumber = exprVar[opXIndex];
                  double secondNumber = exprVar[opXIndex + 1];
                  double result = firstNumber + secondNumber;
                  newValues.removeAt(exprVar.indexOf(secondNumber));
                  newValues[exprVar.indexOf(firstNumber)] = result;
                  operator.removeAt(opXIndex);
                  continue;
                }
                if (operator.contains('-')) {
                  int opXIndex = operator.indexOf('-');
                  double firstNumber = exprVar[opXIndex];
                  double secondNumber = exprVar[opXIndex + 1];
                  double result = firstNumber + secondNumber;
                  newValues.removeAt(exprVar.indexOf(secondNumber));
                  newValues[exprVar.indexOf(firstNumber)] = result;
                  operator.removeAt(opXIndex);
                  continue;
                }
                i++;
              }
              print("Resultado: $newValues");
              double result = newValues[0];
              calcText = result.toString();
            });
          } else {
            setState(() {
              calcText = dob;
              count -= 1;
            });
          }
        } else {
          setState(() {
            calcText = calcText + texto;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Color(0xff22252D),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Center(
            child: Text(
              texto,
              style: TextStyle(
                  color: color ?? Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
