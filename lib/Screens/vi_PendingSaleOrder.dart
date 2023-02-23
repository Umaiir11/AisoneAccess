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
import '../Models/EModel/ModPendingSalOrder.dart';
import '../Models/EModel/ModUserAccountsQuery.dart';
import '../ServiceLayer/SlAisoneERP/SleRptPdf.dart';
import '../UserWidgets/Labels/Ulabels.dart';

class vi_PendingSaleOrderr extends StatefulWidget {
  const vi_PendingSaleOrderr({Key? key}) : super(key: key);

  @override
  State<vi_PendingSaleOrderr> createState() => _vi_PendingSaleOrderrState();
}

class _vi_PendingSaleOrderrState extends State<vi_PendingSaleOrderr> {
  bool G_isFolded = true;
  late RxList<ModI_PendingSaleOrder> l_ListPendingSO =
      Get.find(tag: "Rx_l_listIPendingSaleOrder");

  List<ModI_PendingSaleOrder> l_List_Elements = <ModI_PendingSaleOrder>[];

  //UserWidgets
  ULabels lblCompanyList = new ULabels();
  ULabels lblCompanyName = new ULabels();
  ULabels lblAppBar = new ULabels();

  //Controller
  TextEditingController _textController = TextEditingController();
  final G_currencyFormat = new NumberFormat("#,##0", "en_US");
  final DateFormat G_DateTimeFormat = DateFormat('dd-MMM-yy');
  var SelectedDID;
  ModUserAccountsQuery? _selectedObject;

  @override
  void initState() {
    super.initState();
    l_List_Elements.addAll(l_ListPendingSO);
    FncstartupSettings();
    FncReport();
    _selectedObject = cmGlobalVariables.Pb_ListUserAccountsQuery[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,

      appBar: AppBar(
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
        elevation: 4.0,
      ),

      bottomNavigationBar: SizedBox(
        height: 33,
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
                    height: 100,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7.5, left: 84),
                    child: InkWell(
                      onTap: () => launchUrl(
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
                  Container(
                    margin: EdgeInsets.only(top: 0, left: 385),
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
                width: MediaQuery.of(context).size.width,
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

//Search bar

            AnimatedContainer(
              duration: Duration(milliseconds: 370),
              margin: EdgeInsets.only(top: 103, left: 30),
              width: G_isFolded ? 40 : 320,
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
                          child: !G_isFolded
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
                            topLeft: Radius.circular(G_isFolded ? 32 : 0),
                            topRight: Radius.circular(32),
                            bottomLeft: Radius.circular(G_isFolded ? 32 : 0),
                            bottomRight: Radius.circular(32),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              size: 20,
                              G_isFolded ? Icons.search : Icons.close,
                              color: Colors.black87,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              G_isFolded = !G_isFolded;
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
                child:  ListView.builder(

                  itemCount: l_List_Elements.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {


                          },

                          child: SizedBox(
                            width: 395,
                            height: 110,
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0)),
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
                                        height:130,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [

                                                  (index % 2 == 0)
                                                      ? Colors.white
                                                      : Colors
                                                      .grey.shade300 ,
                                                  (index % 2 == 0)
                                                      ? Colors.white
                                                      : Colors
                                                      .grey.shade300 ,
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

                                                  (index % 2 == 0)
                                                      ? Colors.white
                                                      : Colors
                                                      .white,
                                                  (index % 2 == 0)
                                                      ? Colors.white
                                                      : Colors
                                                      .white,
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
                                        l_List_Elements[index].Pr_VoucherNo,
                                        style:
                                        GoogleFonts.ubuntu(textStyle:
                                        TextStyle(
                                            fontSize: 32,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: .5)
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 25, left: 330),
                                      child: Text(
                                        G_DateTimeFormat.format(
                                            l_List_Elements[index]
                                                .Pr_VDate),
                                        style:
                                        GoogleFonts.ubuntu(textStyle:
                                        TextStyle(
                                            fontSize: 22,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: .5)
                                        ),
                                      ),
                                    ),


                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 66, left: 35),
                                      child: Text(
                                        'Cust Ref.No', style:
                                      GoogleFonts.ubuntu(textStyle:
                                      TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          //fontWeight: FontWeight.w600,
                                          letterSpacing: .5)
                                      ),

                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 90, left: 35),
                                      child: Text(


                                        l_List_Elements[index]
                                            .Pr_CustomerRefNo,

                                        style:
                                        GoogleFonts.ubuntu(textStyle:
                                        TextStyle(
                                            fontSize: 19,
                                            color: Colors.lightBlueAccent,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: .5)
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 66, left: 326),
                                      child: Text(
                                        'Grand Total', style:
                                      GoogleFonts.ubuntu(textStyle:
                                      TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          //fontWeight: FontWeight.w600,
                                          letterSpacing: .5)
                                      ),

                                      ),
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(top: 90, left: 329),
                                      child: Text(
                                        G_currencyFormat.format(
                                            l_List_Elements[index]
                                                .Pr_FGrandTotal),

                                        style: GoogleFonts.ubuntu(textStyle:
                                        TextStyle(
                                            fontSize: 19,
                                            color: Colors.greenAccent.shade400,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: .5)
                                        ),
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
    lblCompanyList.TxtText = "Pending SaleOrder";
    lblCompanyList.TxtFontSize = 30;
    lblCompanyList.color = Colors.black38;

    lblCompanyName.TxtText = "Details";
    lblCompanyName.TxtFontSize = 21;
    lblCompanyName.color = Colors.black87;

    lblAppBar.TxtText = "Pending Sale Order";
    lblAppBar.TxtFontSize = 24;
    lblAppBar.color = Colors.black87;
  }

  FncReport() async {
    String? l_result;

    l_result = await SlERptPdf().Fnc_reportpdf();
    print(l_result);

    if (l_result == null) {
      Get.snackbar("Alert", "Invalid Login Information");
    } else {
      Uint8List decoded = base64.decode(l_result);

      cmGlobalVariables.Pb_Report = decoded;

      print(cmGlobalVariables.Pb_Report);
    }
  }

  void FncfilterSearchResults(String UserInput) {
    List<ModI_PendingSaleOrder> dummySearchList = <ModI_PendingSaleOrder>[];
    dummySearchList.addAll(l_ListPendingSO);
    List<ModI_PendingSaleOrder> l_SearchedListItems = [];

    List<ModI_PendingSaleOrder> l_dummyListData = <ModI_PendingSaleOrder>[];
    if (UserInput.isNotEmpty) {
      UserInput.split(' ').forEach((s) {
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) =>
            l_listelement.Pr_VoucherNo.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) =>
            l_listelement.Pr_VoucherNo.toString().toUpperCase().contains(s)));
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) =>
            l_listelement.Pr_CustomerRefNo.toString()
                .toUpperCase()
                .contains(s)));
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) =>
            l_listelement.Pr_CustomerRefNo.toString()
                .toLowerCase()
                .contains(s)));
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) =>
            l_listelement.Pr_FGrandTotal.toString().contains(s)));

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
        l_List_Elements.addAll(l_ListPendingSO);
      });
    }
  }
}
