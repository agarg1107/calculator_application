import 'package:calculator_application/setting.dart';
import 'package:calculator_application/theme/thememanagers.dart';
import 'package:flutter/material.dart';
import 'package:calculator_application/theme/themecon.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:page_transition/page_transition.dart';
import 'additional.dart';
import 'color.dart';
import 'dart:developer' as devlog;


void main() {
  runApp(MyApp());
}

thememanagers thememanager = thememanagers();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    thememanager.removeListener((themeListener));
    super.dispose();
  }

  @override
  void initState() {
    thememanager.addListener((themeListener));
// TODO: implement initState
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: thememanager.themeMode,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  var input = '0';
  var output = '';
  var previousinput = '';
  var operation = '';
  var hiddenInput = false;
  var outputsize = 34.0;
  var flag = 1;

  onbuttonclick(value) {
    if (value == "AC") {
      hiddenInput = false;
      outputsize = 34.0;
      input = '0';
      output = '';
      previousinput = '';
      flag = 1;
    } else if (value == "del") {
      if (input.isNotEmpty && input != '0') {
        input = input.substring(0, input.length - 1);
        output = input;
      }
      previousinput = '';
    } else if (value == "=") {
      if (input.isNotEmpty) {
        input = input.replaceAll('log', 'LAGA');
        devlog.log(input, name: "okcheck");
        var maininput = input;
        var userinput = input;

        Parser p = Parser();
        if (userinput.indexOf('π') >= 0) {
          while (input.indexOf('π') >= 0) {
            var maindataroot = input.indexOf('π');

            var nuumrootdata = input[maindataroot + 1];

            input = input.replaceAll('π', '3.14');
            devlog.log(input, name: "test");
          }
          userinput = input;
        }
        if (userinput.indexOf('√') >= 0) {
          while (input.indexOf('√') >= 0) {
            var maindataroot = input.indexOf('√');

            var nuumrootdata = input[maindataroot + 1];

            input = input.replaceAll(
                '√' + nuumrootdata.toString(), 'nrt($nuumrootdata,10)');
            devlog.log(input, name: "test");
          }
          userinput = input;
        }
        if (userinput.indexOf('LAGA') >= 0) {
          while (input.indexOf('LAGA') >= 0) {
            var maindataroot = input.indexOf('LAGA');

            var nuumrootdata = input[maindataroot + 4];

            input = input.replaceAll(
                'LAGA' + nuumrootdata.toString(), 'log(10,$nuumrootdata)');
            devlog.log(input, name: "test");
          }
          userinput = input;
        }

        devlog.log(userinput, name: "test");
        input = maininput;
        devlog.log(input + "ok", name: "test" + "ok");
        input = input.replaceAll('LAGA', 'log');
        devlog.log(input + "ok", name: "test" + "ok");


        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);



        var finalvaluetoint = finalvalue.toInt();

        var afterdec = finalvalue - finalvaluetoint;

        var stringsfterdec = afterdec.toString();

        var afterdeclength = stringsfterdec.length;

        if (afterdeclength > 4) {
          stringsfterdec = stringsfterdec.substring(1, 6);

          if (stringsfterdec.startsWith('0')) {
            stringsfterdec = stringsfterdec.substring(1, 5);
          }
        }
        var finaldata = finalvaluetoint.toString() + stringsfterdec;

        if (afterdeclength > 4) {
          output = finaldata;
        } else {
          output = finalvalue.toString();
        }

        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hiddenInput = true;
        outputsize = 52.0;
        if(output.length > 18){
          output = output.substring(0,18);
        }

      }
    } else {
      devlog.log(previousinput.toString(), name: "check");
      if (flag == 1) {
        input = '';
        flag = 0;
      }
      hiddenInput = false;
      outputsize = 34.0;
      if ((value == '+' ||
              value == '*' ||
              value == '/' ||
              value == '%' ||
              value == '^' ||
              value == '!' ||
              value == '.') &&
          input.isEmpty) {
        input = '0';
      } else if (input.isEmpty &&
          (value != '+' ||
              value != '*' ||
              value != '/' ||
              value != '%' ||
              value != '^' ||
              value != '!' ||
              value != '.')) {
        input = input + value;
      } else if (input.isNotEmpty &&
          (((previousinput == '+' ||
                      previousinput == '-' ||
                      previousinput == '*' ||
                      previousinput == '%' ||
                      previousinput == '/' ||
                      previousinput == 'π' ||
                      previousinput == 'e' ||
                      previousinput == '^' ||
                      previousinput == '!' ||
                      previousinput == 'log' ||
                      previousinput == 'sin' ||
                      previousinput == 'deg' ||
                      previousinput == 'rad' ||
                      previousinput == 'ln' ||
                      previousinput == 'tan' ||
                      previousinput == 'cos' ||
                      previousinput == 'inv' ||
                      previousinput == '.' ||
                      previousinput == '√') &&
                  (value != '+' &&
                      value != '*' &&
                      value != '-' &&
                      value != '/' &&
                      value != '%' &&
                      value != 'e' &&
                      value != '^' &&
                      value != '!' &&
                      value != "log" &&
                      value != 'sin' &&
                      value != 'cos' &&
                      value != 'tan' &&
                      value != 'rad' &&
                      value != 'deg' &&
                      value != 'ln' &&
                      value != 'inv' &&
                      value != '√' &&
                      value != '.')) ||
              ((previousinput != '+' &&
                      previousinput != '-' &&
                      previousinput != '*' &&
                      previousinput != '%' &&
                      previousinput != '/' &&
                      previousinput != 'π' &&
                      previousinput != 'e' &&
                      previousinput != '^' &&
                      previousinput != '!' &&
                      previousinput != 'log' &&
                      previousinput != 'sin' &&
                      previousinput != 'deg' &&
                      previousinput != 'rad' &&
                      previousinput != 'ln' &&
                      previousinput != 'tan' &&
                      previousinput != 'cos' &&
                      previousinput != 'inv' &&
                      previousinput != '.' &&
                      previousinput != '√') &&
                  (value == '+' ||
                      value == '*' ||
                      value == '-' ||
                      value == '/' ||
                      value == '%' ||
                      value == 'π' ||
                      value == 'e' ||
                      value == '^' ||
                      value == '!' ||
                      value == "log" ||
                      value == 'sin' ||
                      value == 'cos' ||
                      value == 'tan' ||
                      value == 'rad' ||
                      value == 'deg' ||
                      value == 'ln' ||
                      value == 'inv' ||
                      value == '√' ||
                      value == '.')) ||
              ((previousinput != '+' &&
                      previousinput != '-' &&
                      previousinput != '*' &&
                      previousinput != '%' &&
                      previousinput != '/' &&
                      previousinput != 'π' &&
                      previousinput != 'e' &&
                      previousinput != '^' &&
                      previousinput != '!' &&
                      previousinput != 'log' &&
                      previousinput != 'sin' &&
                      previousinput != 'deg' &&
                      previousinput != 'rad' &&
                      previousinput != 'ln' &&
                      previousinput != 'tan' &&
                      previousinput != 'cos' &&
                      previousinput != 'inv' &&
                      previousinput != '.' &&
                      previousinput != '√') &&
                  (value != '+' &&
                      value != '*' &&
                      value != '-' &&
                      value != '/' &&
                      value != '%' &&
                      value != 'π' &&
                      value != 'e' &&
                      value != '^' &&
                      value != '!' &&
                      value != "log" &&
                      value != 'sin' &&
                      value != 'cos' &&
                      value != 'tan' &&
                      value != 'rad' &&
                      value != 'deg' &&
                      value != 'ln' &&
                      value != 'inv' &&
                      value != '√' &&
                      value != '.')))) {
        if(input.length <= 18){
          input = input + value;
        }

      } else if (input.isNotEmpty &&
              ((previousinput == 'π' && value == '*') ||
                  (previousinput == 'e' && value == '^')) ||
          ((previousinput == '*' ||
                      previousinput == '+' ||
                      previousinput == '-' ||
                      previousinput == '/' ||
                      previousinput == '%') &&
                  (value == '√' ||
              value == 'cos' ||
              value == 'sin' ||
              value == 'tan' ||
              value == 'ln' ||
              value == 'π' ||
              value == 'log')) ||
          previousinput == "!" &&
              (value == "+" || value == "-" || value == "*" || value == "/")) {
        if(input.length <= 18){
          input = input + value;
        }
      }
      output = input;
      previousinput = value;
      devlog.log(previousinput.toString(), name: "check");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    IconData _iconlight = Icons.wb_sunny;
    IconData _iconderk = Icons.nights_stay;
    Color spebutton_backcol;
    Color normalbutton_backcol;
    Color operatorbutton_backcol;
    Color operator_text;
    Color all_text;
    Color keypadcol_back;
    Color Screen_col;
    Color main_output_text_col;

    String textdata = "";
    if (Theme.of(context).brightness == Brightness.dark) {
      spebutton_backcol = orangecolor;
      normalbutton_backcol = buttoncolor;
      operatorbutton_backcol = operatorcolor;
      operator_text = orangecolor;
      all_text = Colors.white;
      keypadcol_back = background;
      Screen_col = operatorcolor;
      textdata = "N";
      main_output_text_col = Colors.white;
    } else {
      spebutton_backcol = Color(0xC8FF7C00);
      normalbutton_backcol = Color(0xFF6692EC);
      operatorbutton_backcol = Color(0xFF98DEFE);
      operator_text = Colors.white;
      all_text = Colors.black;
      keypadcol_back = Colors.white;
      Screen_col = Color(0xFFD6F9FF);
      textdata = "D";
      main_output_text_col = Colors.black;
    }

    double width1 = MediaQuery.of(context).size.width;
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: keypadcol_back,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(

            children: [
              IconButton(
                alignment: Alignment.centerLeft,
                icon: thememanager.themeMode == ThemeMode.dark
                    ? Icon(_iconlight)
                    : Icon(_iconderk),
                onPressed: () {
                  thememanager.toggleTheme(
                      thememanager.themeMode == ThemeMode.dark ? false : true);
                },
              ),
               SizedBox(
                height: 30,
                width: width1 - 100 ,
              ),
              // buttonuitop(text: "+", buttonBgColor: spebutton_backcol),
              PopupMenuButton(

                itemBuilder: (context) => [

                  PopupMenuItem<int>(

                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Settings", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
                color: operatorcolor,
                position: PopupMenuPosition.under,

                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(9)),
                onSelected: (item) => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: setting(
                          text: textdata,
                        ))),

              )
            ],
          ),
          Expanded(
              child: Container(
            color: Screen_col,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hiddenInput ? '' : input,
                  style: TextStyle(
                    fontSize: 48,
                    color: main_output_text_col,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                    fontSize: outputsize,
                    color: main_output_text_col.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
          Row(
            children: [
              buttonui(
                text: "log",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(
                text: "ln",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(
                text: "(",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(
                text: ")",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(
                text: "e",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
            ],
          ),
          Row(
            children: [
              buttonui(
                text: "!",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(
                text: "AC",
                buttonBgColor: spebutton_backcol,
              ),
              buttonui(
                text: "del",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(
                text: "%",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(
                text: "/",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
            ],
          ),
          Row(
            children: [
              buttonui(
                text: "^",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(text: "7", buttonBgColor: normalbutton_backcol),
              buttonui(text: "8", buttonBgColor: normalbutton_backcol),
              buttonui(text: "9", buttonBgColor: normalbutton_backcol),
              buttonui(
                text: "*",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
            ],
          ),
          Row(
            children: [
              buttonui(
                text: "√",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(text: "4", buttonBgColor: normalbutton_backcol),
              buttonui(text: "5", buttonBgColor: normalbutton_backcol),
              buttonui(text: "6", buttonBgColor: normalbutton_backcol),
              buttonui(
                text: "-",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
            ],
          ),
          Row(
            children: [
              buttonui(
                text: "sin",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(text: "1", buttonBgColor: normalbutton_backcol),
              buttonui(text: "2", buttonBgColor: normalbutton_backcol),
              buttonui(text: "3", buttonBgColor: normalbutton_backcol),
              buttonui(
                text: "+",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
            ],
          ),
          Row(
            children: [
              buttonui(
                text: "cos",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(
                text: "tan",
                buttonBgColor: operatorbutton_backcol,
                tcolor: operator_text,
              ),
              buttonui(text: "0", buttonBgColor: normalbutton_backcol),
              buttonui(text: ".", buttonBgColor: normalbutton_backcol),
              buttonui(text: "=", buttonBgColor: spebutton_backcol),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonui({text, tcolor = Colors.white, buttonBgColor = buttoncolor}) {
    return Expanded(
        child: Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () {
          onbuttonclick(text);
        },
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            backgroundColor: buttonBgColor,
            padding: const EdgeInsets.all(10)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: tcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }

  Widget buttonuitop({text, tcolor, buttonBgColor = buttoncolor}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: additional()));
        },
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            backgroundColor: buttonBgColor,
            padding: const EdgeInsets.all(5)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: tcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
