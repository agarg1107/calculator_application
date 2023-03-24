import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color.dart';

class setting extends StatelessWidget {
  final String text;

  // receive data from the FirstScreen as a parameter
  setting({required this.text});

  @override

  Widget build(BuildContext context) {
    Color main_back_col = background;
    Color block_back_col = operatorcolor;
    if(text == "N"){
      main_back_col = background;
      block_back_col = operatorcolor;
    }
    else{
      main_back_col = Colors.white;
      block_back_col = Color(0xFF98DEFE);
    }
    return(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting",
      home: Scaffold(
        backgroundColor: main_back_col,
        body: Container(
          height: 150,
          margin: const EdgeInsets.fromLTRB(20,50,20,30),
          decoration: BoxDecoration(
            color: block_back_col,
            borderRadius: BorderRadius.all(Radius.circular(15),
            ),
          ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [SizedBox(height: 20,),
          Text("     Version",style: TextStyle(fontSize: 22,color: Colors.white)),
          Text("        1.0.0",style: TextStyle(fontSize: 15,color: Colors.white)),

              Expanded(
                  child: Container(


                margin: const EdgeInsets.all(8),

                child: ElevatedButton(

                  onPressed: () {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'agarg1107@gmail.com',
                      query: encodeQueryParameters(<String, String>{
                        'subject': 'Please Fix this Bug',
                      }),
                    );
                    launchUrl(emailLaunchUri);
                  },

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)
                      ),
                      backgroundColor: block_back_col,

                      padding: const EdgeInsets.all(22)),
                  child:Align(
                    alignment: Alignment.topLeft,
                    child:Text("Report Bug",
                      style: TextStyle(

                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),

                ),
              )),
          ],

          ),
        ),
      ),
    )

    );
  }
  launchem(){

  }
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
}
