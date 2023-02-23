import 'dart:convert';
import 'dart:typed_data';

import 'package:aisoneaccess/Screens/vi_LedgerPDF.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ClassModules/cmGlobalVariables.dart';
import '../Models/EModel/ModAccLedger.dart';
import '../Models/EModel/ModUserAccountsQuery.dart';
import '../ServiceLayer/SlAisoneERP/SLEAaccLedgerTest.dart';
import '../ServiceLayer/SlAisoneERP/SlEAccountLedger.dart';
import '../ServiceLayer/SlAisoneERP/SleRptPdf.dart';
import '../UserWidgets/Labels/Ulabels.dart';

class vi_AccountLedger extends StatefulWidget {
  const vi_AccountLedger({Key? key}) : super(key: key);

  @override
  State<vi_AccountLedger> createState() => _vi_AccountLedgerState();
}

class _vi_AccountLedgerState extends State<vi_AccountLedger> {
  bool isFolded = true;
  ModUserAccountsQuery? _selectedObject;

  //late RxList<ModI_AccountLedger> l_ListAccountLedger =
  //Get.find(tag: "Rx_ListAccountLegdger");

  var SelectedDID;
  List<ModI_AccountLedger> l_List_Elements = <ModI_AccountLedger>[];
  List<ModI_AccountLedger>? l_listtDateRange = <ModI_AccountLedger>[];

  //UserWidgets
  ULabels lblCompanyList = new ULabels();
  ULabels lblCompanyName = new ULabels();
  ULabels lblAppBar = new ULabels();
  ULabels lblDropDown = new ULabels();

  //Controller
  TextEditingController _textController = TextEditingController();
  final G_currencyFormat = new NumberFormat("#,##0", "en_US");
  final DateFormat G_DateTimeFormat = DateFormat('dd-MMM-yy');

  DateTimeRange l_DateRange = DateTimeRange(
      start: DateTime.parse("2021-01-01"), end: DateTime.parse("2021-03-31"));

  @override
  void initState() {
    super.initState();
    l_List_Elements.addAll(cmGlobalVariables.Pbl_AccountLedger);
    FncstartupSettings();
    super.initState();
    _selectedObject = cmGlobalVariables.Pb_ListUserAccountsQuery[0];

    //FncReport();
  }

  @override
  Widget build(BuildContext context) {
    final start = l_DateRange.start;
    final end = l_DateRange.end;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.picture_as_pdf_sharp),
              onPressed:() async {
                if (await FncReport() == true) {
                Get.to(() => Controll());
                } else {
                Get.snackbar(
                "Alert", "No DATA, Please Contact Your Administrator");
                }
              }





          ),
        ],

        centerTitle: true,
        toolbarHeight: 42,


        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFD1FFFF),
                Color(0xFFD1FFFF),
                Color(0xFF88ECF8),
              ],
            ),
          ),
        ),
        title: Shimmer.fromColors(
            baseColor: Colors.black38,
            highlightColor: Colors.cyanAccent,
            child: lblAppBar),

        // backgroundColor: Colors.transparent,
        elevation: 7.0,
      ),
      bottomNavigationBar: SizedBox(
        height: 32,
        child: BottomAppBar(
            elevation: 10.0,
            color: Colors.cyan.shade200,
            child: ResponsiveWrapper(
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: const [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: '4K'),
              ],
              child: Stack(
                children: [
                  Container(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: InkWell(
                        onTap: () =>
                            launchUrl(
                                Uri.parse('https://www.aisonesystems.com/')),
                        child: Text(
                          'Powered by - aisonesystems.com',
                          style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  letterSpacing: .5)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, left: 415),
                    child: IconButton(
                      icon: Icon(
                        Icons.phone_forwarded_outlined,
                        size: 25,
                        color: Colors.indigoAccent,
                      ),
                      onPressed: () async {
                        Uri phoneno = Uri.parse('tel:+923214457734');
                        if (await launchUrl(phoneno)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, left: 22),
                    child: IconButton(
                      icon: Icon(
                        MdiIcons.whatsapp,

                        size: 25,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        var whatsapp = "+923214457734";
                        Uri whatsappopen =
                        Uri.parse("whatsapp://send?phone=$whatsapp");
                        if (await launchUrl(whatsappopen)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFD1FFFF),
              Color(0xFF88ECF8),
              Color(0xFF65DCDC),
            ],
            stops: [0.0, 0.5, 0.7, 0.9],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 0, left: 0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 122,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 2)
                  ],
                  color: Color.fromRGBO(101, 227, 227, 1),
                  border: Border.all(
                    color: Color.fromRGBO(101, 227, 227, 1),
                    width: 1,
                  ),
                )),

            //image
            Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 0,
                ),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.06274509803921569),
                        offset: Offset(1, 1),
                        blurRadius: 2)
                  ],
                  border: Border.all(
                    color: Color.fromRGBO(101, 227, 227, 1),
                    width: 1,
                  ),
                  image: DecorationImage(
                      image: AssetImage("assets/ledger.gif"),
                      fit: BoxFit.fitWidth),
                )),
//DropDown
            Container(
              margin: EdgeInsets.only(top: 10, left: 95),
              child: DropdownButton<ModUserAccountsQuery>(
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .5)),
                hint: Text("Tap For Accounts Details"),
                elevation: 5,
                value: _selectedObject,
                onChanged: (newValue) {
                  setState(() {
                    _selectedObject = newValue!;
                    var Index =
                    cmGlobalVariables.Pb_ListUserAccountsQuery.indexOf(
                        newValue);
                    cmGlobalVariables.Pb_SelectedDID = cmGlobalVariables
                        .Pb_ListUserAccountsQuery[Index].Pr_AccountsDID;
                    print(cmGlobalVariables.Pb_SelectedDID);
                    print(cmGlobalVariables.Pb_SelectedDID);
                    // Fnc_AccountLedger3();
                  });

                  print(newValue);
                  print(newValue);
                },
                items: cmGlobalVariables.Pb_ListUserAccountsQuery.map(
                        (ModUserAccountsQuery object) {
                      return DropdownMenuItem<ModUserAccountsQuery>(
                        value: object,
                        child: Text(object.Pr_AccountID),
                      );
                    }).toList(),
              ),
            ),

//DateTime
            Container(
              margin: EdgeInsets.only(top: 47, left: 45),
              child: SizedBox(
                width: 130,
                child: TextButton(
                  onPressed: () {
                    Event_pickDaterange();
                    //Fnc_FromDate(context);
                  },
                  child: SizedBox(
                    height: 35,
                    child: Image.asset("assets/calendar.png"),
                  ),
                ),
              ),
            ),
//Sperrator
            Container(
              margin: EdgeInsets.only(top: 53, left: 157),
              child: SizedBox(
                width: 130,
                child: TextButton(
                  onPressed: () {
                    //Event_pickDaterange();
                    //Fnc_FromDate(context);
                  },
                  child: SizedBox(
                    height: 28,
                    child: Image.asset("assets/line.png"),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 53, left: 133),
              child: Text(
                "From Date",
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                        fontSize: 12, color: Colors.black, letterSpacing: .5)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 64, left: 133),
              child: InkWell(
                onTap: () {
                  Event_pickDaterange();
                },
                child: Text(
                  '${start.day}/${start.month}/${start.year}',
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          letterSpacing: .5)),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 53, left: 225),
              child: Text(
                "To Date",
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                        fontSize: 12, color: Colors.black, letterSpacing: .5)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 64, left: 225),
              child: InkWell(
                onTap: () {
                  Event_pickDaterange();
                },
                child: Text(
                  '${end.day}/${end.month}/${end.year}',
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          letterSpacing: .5)),
                ),
              ),
            ),

//Search bar

            AnimatedContainer(
              duration: Duration(milliseconds: 370),
              margin: EdgeInsets.only(top: 103, left: 30),
              width: isFolded ? 40 : 320,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 2)
                ],
                borderRadius: BorderRadius.circular(32),
                color: Colors.grey.shade50,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 16),
                          child: !isFolded
                              ? TextField(
                            controller: _textController,
                            onChanged: FncfilterSearchResults,
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                            ),
                          )
                              : null)),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 370),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(isFolded ? 32 : 0),
                            topRight: Radius.circular(32),
                            bottomLeft: Radius.circular(isFolded ? 32 : 0),
                            bottomRight: Radius.circular(32),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              size: 20,
                              isFolded ? Icons.search : Icons.close,
                              color: Colors.black87,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isFolded = !isFolded;
                            });
                          }),
                    ),
                  )
                ],
              ),
            ),

//PDF

//ListBuilder
            Container(
                margin: EdgeInsets.only(top: 147, left: 0),
                child: ListView.builder(
                  itemCount: l_List_Elements.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {},
                          child: SizedBox(
                            width: 360,
                            height: 100,
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ResponsiveWrapper(
                                maxWidth: 1200,
                                minWidth: 480,
                                defaultScale: true,
                                breakpoints: const [
                                  ResponsiveBreakpoint.resize(480,
                                      name: MOBILE),
                                  ResponsiveBreakpoint.autoScale(800,
                                      name: TABLET),
                                  ResponsiveBreakpoint.resize(1000,
                                      name: DESKTOP),
                                  ResponsiveBreakpoint.autoScale(2460,
                                      name: '4K'),
                                ],
                                child: Stack(
                                  children: [
                                    Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  (cmGlobalVariables
                                                      .Pbl_AccountLedger[
                                                  index]
                                                      .Pr_Credit ==
                                                      0)
                                                      ? Colors.white
                                                      : Colors.grey.shade300,
                                                  (cmGlobalVariables
                                                      .Pbl_AccountLedger[
                                                  index]
                                                      .Pr_Credit ==
                                                      0)
                                                      ? Colors.white
                                                      : Colors.grey.shade300,
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                            borderRadius:
                                            BorderRadius.circular(5.0),
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 4),
                                                color: Colors.teal,
                                                blurRadius: 10,
                                              )
                                            ])),
                                    Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  (cmGlobalVariables
                                                      .Pbl_AccountLedger[
                                                  index]
                                                      .Pr_Credit ==
                                                      0)
                                                      ? Colors.white
                                                      : Colors.grey.shade200,
                                                  (cmGlobalVariables
                                                      .Pbl_AccountLedger[
                                                  index]
                                                      .Pr_Credit ==
                                                      0)
                                                      ? Colors.white
                                                      : Colors.grey.shade200,
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight),
                                            borderRadius:
                                            BorderRadius.circular(5.0),
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 4),
                                                color: Colors.teal,
                                                blurRadius: 10,
                                              )
                                            ])),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 19, left: 35),
                                      child: Text(
                                        l_List_Elements[index].Pr_VNO,
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 32,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: .5)),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 25, left: 330),
                                      child: Text(
                                        G_DateTimeFormat.format(
                                            l_List_Elements[index].Pr_VDate),
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 22,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: .5)),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 66, left: 35),
                                      child: Text(
                                        'Debit',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                //fontWeight: FontWeight.w600,
                                                letterSpacing: .5)),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 90, left: 35),
                                      child: Text(
                                        G_currencyFormat.format(
                                            l_List_Elements[index].Pr_Debit),
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 19,
                                                color: Colors.lightBlueAccent,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: .5)),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 66, left: 180),
                                      child: Text(
                                        'Credit',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                //fontWeight: FontWeight.w600,
                                                letterSpacing: .5)),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 90, left: 180),
                                      child: Text(
                                        G_currencyFormat.format(
                                            l_List_Elements[index].Pr_Credit),
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 19,
                                                color:
                                                Colors.greenAccent.shade400,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: .5)),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 66, left: 330),
                                      child: Text(
                                        'Balance',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black26,
                                                //fontWeight: FontWeight.w600,
                                                letterSpacing: .5)),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 90, left: 330),
                                      child: Text(
                                        G_currencyFormat.format(
                                            l_List_Elements[index].Pr_Balance),
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: .5)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                )),
          ],
        ),
      ),
    );
  }

//============================DART=================================

  FncstartupSettings() {
    //Labels
    lblCompanyList.TxtText = "L E D G E R";
    lblCompanyList.TxtFontSize = 30;
    lblCompanyList.color = Colors.black38;

    lblCompanyName.TxtText = "Details";
    lblCompanyName.TxtFontSize = 21;
    lblCompanyName.color = Colors.black87;

    lblAppBar.TxtText = "L E D G E R";
    lblAppBar.TxtFontSize = 24;
    lblAppBar.color = Colors.black87;

    lblDropDown.TxtText = "Tap For Accounts Details";
    lblDropDown.TxtFontSize = 24;
    lblDropDown.color = Colors.black87;
  }

  void FncfilterSearchResults(String UserInput) {
    List<ModI_AccountLedger> dummySearchList = <ModI_AccountLedger>[];
    dummySearchList.addAll(cmGlobalVariables.Pbl_AccountLedger);
    List<ModI_AccountLedger> l_SearchedListItems = [];

    List<ModI_AccountLedger> l_dummyListData = <ModI_AccountLedger>[];
    if (UserInput.isNotEmpty) {
      UserInput.split(' ').forEach((s) {
        l_SearchedListItems.addAll(cmGlobalVariables.Pbl_AccountLedger.where(
                (l_listelement) =>
                l_listelement.Pr_VNO.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(cmGlobalVariables.Pbl_AccountLedger.where(
                (l_listelement) =>
                l_listelement.Pr_VNO.toString().toUpperCase().contains(s)));
        l_SearchedListItems.addAll(cmGlobalVariables.Pbl_AccountLedger.where(
                (l_listelement) =>
                l_listelement.Pr_Debit.toString().contains(s)));
        l_SearchedListItems.addAll(cmGlobalVariables.Pbl_AccountLedger.where(
                (l_listelement) =>
                l_listelement.Pr_Credit.toString().contains(s)));
        l_SearchedListItems.addAll(cmGlobalVariables.Pbl_AccountLedger.where(
                (l_listelement) =>
                l_listelement.Pr_Balance.toString().contains(s)));

        l_dummyListData = l_SearchedListItems.toSet().toList();
      });

      setState(() {
        l_List_Elements.clear();

        l_List_Elements.addAll(l_dummyListData);
      });

      return;
    } else {
      setState(() {
        l_List_Elements.clear();

        l_List_Elements.addAll(cmGlobalVariables.Pbl_AccountLedger);
      });
    }
  }

  Future Event_pickDaterange() async {
    String hint = "Ledger Filter";
    List<ModI_AccountLedger>? l_dummyListData = <ModI_AccountLedger>[];
    DateTimeRange? l_EvDateRange = await showDateRangePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.cyanAccent, // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.cyan, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.cyanAccent, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialEntryMode: DatePickerEntryMode.input,
        helpText: hint,
        context: context,
        initialDateRange: l_DateRange,
        firstDate: DateTime(2015),
        lastDate: DateTime(2024));

    if (l_EvDateRange != null) {
      setState(() {
        l_DateRange = l_EvDateRange!;
      });

      Fnc_AccountLedger2();
    } else {
      print("NoDATA");
    }
  }

  Future<bool> Fnc_AccountLedger() async {
    List<ModI_AccountLedger>? l_listI_AccountLedger =
    new List<ModI_AccountLedger>.empty(growable: true);

    final l_start = l_DateRange.start;
    final l_end = l_DateRange.end;

    //Assigned Branches Api Call
    l_listI_AccountLedger = await SlEAccountLedger().Fnc_AccountLedger(
      l_start,
      l_end,
      //cmGlobalVariables.Pb_SelectedDID
    );
    {
      if (l_listI_AccountLedger == null) {
        Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
        return false;
      }

      l_listtDateRange?.addAll(l_listI_AccountLedger);
      //cmGlobalVariables.Pbl_AccountLedgerDates?.addAll(l_listI_AccountLedger);

      print(l_listtDateRange);
      //Get.put(Rx_ListAccountLegdger, tag: "Rx_ListAccountLegdger");
    }

    return true;
  }

  Fnc_AccountLedger2() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    List<ModI_AccountLedger>? l_listI_AccountLedger =
    new List<ModI_AccountLedger>.empty(growable: true);

    final l_start = l_DateRange.start;
    final l_end = l_DateRange.end;

    //Assigned Branches Api Call
    l_listI_AccountLedger = await SlEAccountLedgerTest()
        .Fnc_AccountLedgerTest(l_start, l_end, cmGlobalVariables.Pb_SelectedDID
      //cmGlobalVariables.Pb_SelectedDID
    );
    {
      if (l_listI_AccountLedger == null) {
        Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
      }

      setState(() {
        l_List_Elements?.addAll(l_listI_AccountLedger!);
      });

      //cmGlobalVariables.Pbl_AccountLedgerDates?.addAll(l_listI_AccountLedger);

      print(l_listtDateRange);
      //Get.put(Rx_ListAccountLegdger, tag: "Rx_ListAccountLegdger");
    }
    Navigator.of(context).pop();
  }

  Future<bool> FncReport() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    String? l_result;

    l_result = await SlERptPdf().Fnc_reportpdf();
    //print(l_result);

    if (l_result == null) {
      Get.snackbar("Alert", "Invalid Login Information");
      return false;
    } else {
      Uint8List decoded = base64.decode(l_result);
      cmGlobalVariables.Pb_Report = decoded;
    }
    //print(cmGlobalVariables.Pb_Report);
    Navigator.of(context).pop();
    return true;
  }
}
