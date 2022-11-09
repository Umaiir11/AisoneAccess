import 'dart:convert';
import 'dart:typed_data';

import 'package:aisoneaccess/Screens/vi_LedgerPDF.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shimmer/shimmer.dart';
import '../ClassModules/cmGlobalVariables.dart';
import '../Models/EModel/ModPendingSalOrder.dart';
import '../ServiceLayer/SlAisoneERP/SleRptPdf.dart';
import '../UserWidgets/Labels/Ulabels.dart';


class vi_PendingSaleOrderr extends StatefulWidget {
  const vi_PendingSaleOrderr({Key? key}) : super(key: key);

  @override
  State<vi_PendingSaleOrderr> createState() => _vi_PendingSaleOrderrState();
}

class _vi_PendingSaleOrderrState extends State<vi_PendingSaleOrderr> {
  bool isFolded = true;
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




  @override
  void initState() {
    super.initState();
    l_List_Elements.addAll(l_ListPendingSO);
    FncstartupSettings();
    FncReport();
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
    elevation: 4.0,),

      bottomNavigationBar:
      SizedBox(
        height: 23,
        child: BottomAppBar(elevation: 4.0,
            color: Colors.black,
            child: Marquee(fadingEdgeEndFraction: .2,
              text: 'Powered by - aisonesystems.com',
              style: TextStyle( fontSize:18,color: Colors.white),
              scrollAxis: Axis.horizontal, //scroll direction
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 50.0, //speed
              //pauseAfterRound: Duration(seconds: 5),
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 5),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 1000),
              decelerationCurve: Curves.easeOut,
            )

        ),
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
          child: SingleChildScrollView(
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
                children: <Widget>[
                  Container(
                    height: 500,
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20, left: 398),
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => Controll());
                      },
                      child: SizedBox(
                        height: 38,
                        child: Image.asset("assets/pdf.png"),
                      ),
                    ),
                  ),


                  //Cards and Decorated Containers

                  AnimatedContainer(duration: Duration(milliseconds: 370),
                    margin: EdgeInsets.only(top: 20, left:27),
                    width: isFolded ? 52 :320 ,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.grey.shade200,

                    ),
                    child:  Row(children: [

                      Expanded(child: Container(
                          padding: EdgeInsets.only(left: 16),
                          child:  ! isFolded ? TextField(
                            controller: _textController,
                            onChanged: FncfilterSearchResults,
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color:Colors.black),
                              border: InputBorder.none,


                            ),)
                              :null

                      )
                      ),
                      AnimatedContainer(duration: Duration(milliseconds: 370),

                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(isFolded? 32:0),
                                topRight: Radius.circular(32),
                                bottomLeft:Radius.circular(isFolded? 32:0),
                                bottomRight: Radius.circular(32),


                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(size: 20, isFolded? Icons.search : Icons.close,
                                  color: Colors.black87,

                                ),
                              ),

                              onTap:(){
                                setState(() {
                                  isFolded =! isFolded;
                                });
                              }
                          ),
                        ),



                      )

                    ],),
                  ),



                  Container(
                      margin: EdgeInsets.only(top: 75, left: 0),
                      child:  ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
          )),
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


        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) => l_listelement.Pr_VoucherNo.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) => l_listelement.Pr_VoucherNo.toString().toUpperCase().contains(s)));
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) => l_listelement.Pr_CustomerRefNo.toString().toUpperCase().contains(s)));
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) => l_listelement.Pr_CustomerRefNo.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListPendingSO.where((l_listelement) => l_listelement.Pr_FGrandTotal.toString().contains(s)));




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
