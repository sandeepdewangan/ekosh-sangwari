import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class TransactionDetailPage extends StatefulWidget {
  final String deptCode;
  final String deptRefNo;

  TransactionDetailPage(this.deptCode, this.deptRefNo);

  @override
  _TransactionDetailPageState createState() =>
      _TransactionDetailPageState(deptCode, deptRefNo);
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final String deptCode;
  final String deptRefNo;
  _TransactionDetailPageState(this.deptCode, this.deptRefNo);

  String _PAYEE = "";
  String _DEPT = "";
  String _TIN_CIN = "";
  String _ADDRESS1 = "";
  String _ADDRESS2 = "";
  String _PURPOSE = "";
  String _FROM_PERIOD = "";
  String _TO_PERIOD = "";
  String _BANK = "";
  String _TR_REFNO = "";
  String _TR_REFNO_OLD = "";
  String _AMOUNT = "";
  String _ENTRYDATE = "";
  String _SC_SLNO = "";
  String _USERID = "";
  String _DATE_AC = "";
  String _MAJORHEAD = "";
  String _SUBMAJORHEAD = "";
  String _MINORHEAD = "";
  String _SUBHEAD = "";
  String _R_BANKREFNO = "";
  String _R_AMOUNT = "";
  String _status = "";

  String _comment = "";

  late Map<String, String> myDataMap;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    callTreasuryWebService();
  }

  void callTreasuryWebService() async {
    var body = '<?xml version="1.0" encoding="utf-8"?>' +
        '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
        '<soap:Body>' +
        '<eChallandept_srv xmlns="http://tempuri.org/">' +
        '<tr_refno>$deptRefNo</tr_refno>' +
        '<dpt>$deptCode</dpt>' +
        '</eChallandept_srv>' +
        '</soap:Body>' +
        '</soap:Envelope>';

    var url = Uri.https("ekoshonline.cg.nic.in", "/echws/echallan.asmx");
    var response = await http.post(
      url,
      headers: {
        'Host': 'ekoshonline.cg.nic.in',
        'Content-Type': 'text/xml',
        'SOAPAction': 'http://tempuri.org/eChallandept_srv'
      },
      body: body,
    );

    var treasuryResponse = xml.XmlDocument.parse(response.body);
    // print(response.body);
    //_comment = treasuryResponse.findAllElements("comment").single.text;
    try {
      _PAYEE = treasuryResponse.findAllElements("PAYEE").single.text;
      _DEPT = treasuryResponse.findAllElements("DEPT").single.text;
      _TIN_CIN = treasuryResponse.findAllElements("TIN_CIN").single.text;
      _ADDRESS1 = treasuryResponse.findAllElements("ADDRESS1").single.text;
      _ADDRESS2 = treasuryResponse.findAllElements("ADDRESS2").single.text;
      _PURPOSE = treasuryResponse.findAllElements("PURPOSE").single.text;
      _FROM_PERIOD =
          treasuryResponse.findAllElements("FROM_PERIOD").single.text;
      _TO_PERIOD = treasuryResponse.findAllElements("TO_PERIOD").single.text;
      _BANK = treasuryResponse.findAllElements("BANK").single.text;
      _TR_REFNO = treasuryResponse.findAllElements("TR_REFNO").single.text;
      _TR_REFNO_OLD =
          treasuryResponse.findAllElements("TR_REFNO_OLD").single.text;
      _AMOUNT = treasuryResponse.findAllElements("AMOUNT").single.text;
      _ENTRYDATE = treasuryResponse.findAllElements("ENTRYDATE").single.text;
      _SC_SLNO = treasuryResponse.findAllElements("SC_SLNO").single.text;
      _USERID = treasuryResponse.findAllElements("USERID").single.text;
      _DATE_AC = treasuryResponse.findAllElements("DATE_AC").single.text;
      _MAJORHEAD = treasuryResponse.findAllElements("MAJORHEAD").single.text;
      _SUBMAJORHEAD =
          treasuryResponse.findAllElements("SUBMAJORHEAD").single.text;
      _MINORHEAD = treasuryResponse.findAllElements("MINORHEAD").single.text;
      _SUBHEAD = treasuryResponse.findAllElements("SUBHEAD").single.text;
      _R_BANKREFNO =
          treasuryResponse.findAllElements("R_BANKREFNO").single.text;
      _R_AMOUNT = treasuryResponse.findAllElements("R_AMOUNT").single.text;
      _status = treasuryResponse.findAllElements("status").single.text;
    } catch (e) {
      try {
        _comment = treasuryResponse.findAllElements("comment").single.text;
      } catch (e) {
        _comment = "Something went wrong!";
      } finally {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: $_comment"),
        ));
      }
    }
    // Construct Map
    myDataMap = {
      "Payee": _PAYEE,
      "Department": _DEPT,
      "TIN/CIN": _TIN_CIN,
      "Address Line 1": _ADDRESS1,
      "Address Line 2": _ADDRESS2,
      "Purpose": _PURPOSE,
      "Period From": _FROM_PERIOD,
      "Period To": _TO_PERIOD,
      "Bank Code": _BANK,
      "Treasury Ref. No.": _TR_REFNO,
      "Treasury Ref. No. OLD": _TR_REFNO_OLD,
      "Amount": _AMOUNT,
      "Entry Date": _ENTRYDATE,
      "SC SL NO.": _SC_SLNO,
      "User Id": _USERID,
      "Date of Accounting": _DATE_AC,
      "Major Head": _MAJORHEAD,
      "Sub Major Head": _SUBMAJORHEAD,
      "Minor Head": _MINORHEAD,
      "Sub Head": _SUBHEAD,
      "R Bank Reference No.": _R_BANKREFNO,
      "R Amount": _R_AMOUNT,
      "Status": _status,
    };

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: myDataMap.length,
                itemBuilder: (context, index) {
                  String key = myDataMap.keys.elementAt(index);
                  return Column(
                    children: [
                      index == 0
                          ? Column(
                              children: [
                                Card(
                                  elevation: 10.0,
                                  color: Colors.orangeAccent,
                                  child: ListTile(
                                    title: Text(
                                      _PAYEE.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "Department Ref. No.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  subtitle: Text(
                                    deptRefNo,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListTile(
                              title: Text(
                                key,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              subtitle: Text(
                                myDataMap[key].toString().toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ),
                    ],
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
