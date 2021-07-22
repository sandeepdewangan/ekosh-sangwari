import 'package:ekosh_sangwari/pages/transaction_detail_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
        fontFamily: 'NotoSans',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  late final _depCodeController = TextEditingController();
  late final _depRefNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: height,
            ),
            child: Container(
              //height: height,
              width: double.infinity,
              color: Color(0xFFC41A3B),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height / 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Text(
                            "ई-कोष संगवारी",
                            style:
                                TextStyle(color: Colors.white, fontSize: 31.0),
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Developed by Sandeep Dewangan",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.0),
                        topRight: Radius.circular(100.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50.0,
                        left: 25,
                        right: 25,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: TextField(
                              controller: _depCodeController,
                              cursorColor: Color(0xFFC41A3B),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter Department Code",
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF1B1F32),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: TextField(
                              controller: _depRefNoController,
                              cursorColor: Color(0xFFC41A3B),
                              textInputAction: TextInputAction.send,
                              decoration: InputDecoration(
                                hintText:
                                    "Enter Department Transaction Ref. No.",
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF1B1F32),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_depCodeController.text.isEmpty) {
                                return;
                              }
                              if (_depRefNoController.text.isEmpty) {
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionDetailPage(
                                    _depCodeController.text,
                                    _depRefNoController.text,
                                  ),
                                ),
                              );
                            },
                            child: Text("Get Details"),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
