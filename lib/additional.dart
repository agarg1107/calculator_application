import 'package:calculator_application/color.dart';
import 'package:calculator_application/converter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class additional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return(

     MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Additional features",
      home: Scaffold(
        backgroundColor: background,
        body: Container(
            margin: const EdgeInsets.fromLTRB(20,50,20,30),
            decoration: BoxDecoration(
              color: operatorcolor,
              borderRadius: BorderRadius.all(Radius.circular(15),
              ),
            ),
          child: Row(
            children: [
          Expanded(child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,PageTransition(type: PageTransitionType.rightToLeft, child: converter()));

            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)
                ),
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.all(22)),
            child:Text("Area",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
          ),
        )),
            ],

          ),
          ),
        ),

    )
    );

  }

}
