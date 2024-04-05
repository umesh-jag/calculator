import 'package:calculator/buttons.dart';
import 'package:calculator/history.dart';
import 'package:calculator/historypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 10, 7, 15)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = "";
  var userAnswer = "";
  final List<String> buttons = [
    "AC",
    "⌫",
    "%",
    "÷",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "( )",
    "=",
  ];
  bool isBracketOpen = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 3, 2, 2),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryPage()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "History",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ))
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // const SizedBox(
                  //   height: 50,
                  // ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 30),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion,
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer,
                        style:
                            const TextStyle(fontSize: 45, color: Colors.white)),
                  ),
                ],
              ),
            )),
            Expanded(
                flex: 2,
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width ~/ 80,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      //clear btn
                      if (index == 0) {
                        return Mybutton(
                            buttonText: buttons[index],
                            color: const Color.fromARGB(255, 61, 60, 60),
                            textColor: Colors.white,
                            buttonTapped: () {
                              setState(() {
                                userQuestion = '';
                                userAnswer = '';
                              });
                            });
                      }

                      //new dlt btn
                      if (index == 1) {
                        return Mybutton(
                            buttonText: buttons[index],
                            color: const Color.fromARGB(255, 61, 60, 60),
                            textColor: const Color.fromARGB(255, 245, 242, 242),
                            buttonTapped: () {
                              setState(() {
                                if (userQuestion.isNotEmpty) {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                } else {
                                  if (userQuestion.isEmpty) {
                                    userAnswer = " ";
                                  }
                                }
                              });
                            });
                      }

                      //% btn color
                      if (index == 2) {
                        return Mybutton(
                            buttonText: buttons[index],
                            color: const Color.fromARGB(255, 245, 127, 9),
                            textColor: Colors.white,
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            });
                      }

                      //equal  btn
                      if (index == buttons.length - 1) {
                        return Mybutton(
                            buttonText: buttons[index],
                            color: const Color.fromARGB(255, 245, 127, 9),
                            textColor: Colors.white,
                            buttonTapped: () {
                              setState(() {
                                equalPressed();
                              });
                            });
                      }

                      //others
                      return Expanded(
                        child: Mybutton(
                            buttonTapped: () {
                              setState(() {
                                if (buttons[index] == "( )") {
                                  if (!isBracketOpen) {
                                    userQuestion += '(';
                                    isBracketOpen = true;
                                  } else {
                                    userQuestion += ')';
                                    isBracketOpen = false;
                                  }
                                } else {
                                  userQuestion += buttons[index];
                                }
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? const Color.fromARGB(255, 245, 127, 9)
                                : const Color.fromARGB(255, 61, 60, 60),
                            textColor:
                                const Color.fromARGB(255, 255, 255, 255)),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '÷' || x == 'x' || x == '-' || x == '+' || x == '=' || x == '±') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion.trim();
    if (finalQuestion.isEmpty) {
      return;
    }
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    ContextModel cm = ContextModel();
    try {
      Expression exp = p.parse(finalQuestion);
      var eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval is int) {
        userAnswer = eval.toString();
      } else if (eval is double) {
        userAnswer = eval.toString();
        if (userAnswer.contains('.')) {
          // Remove trailing zeros for doubles
          userAnswer = userAnswer.replaceAll(RegExp(r'0*$'), '');
          // Remove trailing decimal point if no decimal value remaining
          userAnswer = userAnswer.replaceAll(RegExp(r'\.$'), '');
        }
      }
    } catch (e) {
      userQuestion = '';
      userAnswer = finalQuestion
          .replaceAll('+', ' ')
          .replaceAll('-', ' ')
          .replaceAll('*', ' ')
          .replaceAll('÷', ' ')
          .replaceAll('%', ' ');
    }
    // Add calculation to history
    history.add(Calculation(expression: finalQuestion, result: userAnswer));
  }
}
