import 'dart:convert';
import 'dart:typed_data';

import 'package:aisoneaccess/Screens/vi_AccountLedger.dart';
import 'package:aisoneaccess/Screens/vi_ItemQuery.dart';
import 'package:aisoneaccess/Screens/vi_PendingCheques.dart';
import 'package:aisoneaccess/Screens/vi_PendingSaleOrder.dart';
import 'package:aisoneaccess/Screens/vi_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ClassModules/cmGlobalVariables.dart';
import '../Models/EModel/DTO.dart';
import '../Models/EModel/ModAccLedger.dart';
import '../Models/EModel/ModBranchSetting.dart';
import '../Models/EModel/ModPendingCheques.dart';
import '../Models/EModel/ModPendingSalOrder.dart';
import '../Models/EModel/ModUserAccountsQuery.dart';
import '../ServiceLayer/SlAisoneERP/SLEAaccLedgerTest.dart';
import '../ServiceLayer/SlAisoneERP/SLEItemQuery.dart';
import '../ServiceLayer/SlAisoneERP/SLEPendingCheques.dart';
import '../ServiceLayer/SlAisoneERP/SLEPendingSaleOrder.dart';
import '../ServiceLayer/SlAisoneERP/SLEUserAccountsQuery.dart';
import '../ServiceLayer/SlAisoneERP/SlEAccountLedger.dart';
import '../UserWidgets/Labels/Ulabels.dart';
import '../test.dart';

class vi_Drawer extends StatefulWidget {
  const vi_Drawer({Key? key}) : super(key: key);

  @override
  State<vi_Drawer> createState() => _vi_DrawerState();
}

class _vi_DrawerState extends State<vi_Drawer> {
  @override
  var decoded;

  void initState() {
    super.initState();
    FncstartupSettings();
    Fnc_UserAccounts();

    decoded = base64.decode(cmGlobalVariables.Pb_UserImage);
  }

  ULabels lblDrawer = new ULabels();
  ULabels lblDrawerTile1 = new ULabels();
  ULabels lblDrawerTile2 = new ULabels();
  ULabels lblDrawerTile3 = new ULabels();
  ULabels lblDrawerTile4 = new ULabels();
  ULabels lblDrawerlabel1 = new ULabels();
  ULabels lblDrawerlabel2 = new ULabels();
  ULabels lblDrawerlabel3 = new ULabels();

  ULabels lblDrawerlabel4 = new ULabels();
  ULabels lblDrawerlabel5 = new ULabels();
  ULabels lblDrawerTile6 = new ULabels();

  ULabels lbllogout = new ULabels();

  int selectedIndex = 0;

  late RxList<ModAssignedBranches> l_Rx_listBranchSettting =
      Get.find(tag: "Rx_AssignedBranches");
  GlobalKey<ScaffoldState> scafKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: SizedBox(
        width: 270,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
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
                          Center(
                            child: Container(
                                margin: EdgeInsets.only(top: 0, left: 0),
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(75)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.lightBlueAccent.shade100
                                          .withOpacity(0.2),
                                      spreadRadius: 4,
                                      blurRadius: 17,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                    radius: 50.0,
                                    child: ClipOval(
                                        child: Image.memory(
                                            Uint8List.fromList(decoded))))),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 150, left: 0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.person_sharp,
                                          size: 14, color: Colors.indigo),
                                    ),
                                    TextSpan(
                                      text: cmGlobalVariables.Pb_UserName,
                                      style: GoogleFonts.ubuntu(
                                          textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 28,
                                              letterSpacing: .5)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 190, left: 310),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      MdiIcons.bank,
                                      size: 14,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  TextSpan(
                                    text: l_Rx_listBranchSettting[selectedIndex]
                                        .pr_BranchName,
                                    style: GoogleFonts.ubuntu(
                                        textStyle: const TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 28,
                                            letterSpacing: .5)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 190, left: 90),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.maps_home_work_outlined,
                                        size: 14, color: Colors.indigo),
                                  ),
                                  TextSpan(
                                    text: l_Rx_listBranchSettting[selectedIndex]
                                        .pr_Address,
                                    style: GoogleFonts.ubuntu(
                                        textStyle: const TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 28,
                                            letterSpacing: .5)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 220, left: 45),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.alternate_email,
                                        size: 14, color: Colors.indigo),
                                  ),
                                  TextSpan(
                                    text: cmGlobalVariables.Pb_UserEmail,
                                    style: GoogleFonts.ubuntu(
                                        textStyle: const TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 28,
                                            letterSpacing: .5)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 1,
                  ),

                  ListTile(
                    selected: selectedIndex == 0,
                    leading: Icon(
                      Icons.desktop_mac_outlined,
                      size: 28,
                    ),
                    title: lblDrawerTile1,
                    onTap: () async {
                      changeIndex(0);

                      Get.snackbar("Please Wait", "Data Is Loading");
                      //Fnc_AccountLedger();

                      if (await Fnc_AccountLedger() == true) {
                        Get.to(() => vi_AccountLedger());
                      } else {
                        Get.snackbar("Alert",
                            "No DATA, Please Contact Your Administrator");
                      }

                      // Navigator.of(context).pop();
                      //Get.to(() => test1());

                      //}
                    },
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  //tile2
                  ListTile(
                      selected: selectedIndex == 1,
                      leading: Icon(
                        Icons.library_books_outlined,
                        size: 28,
                      ),
                      title: lblDrawerTile2,
                      onTap: () async {
                        changeIndex(0);
                        Get.snackbar("Please Wait", "Data Is Loading");

                        if (await Fnc_PendingCheques() == true) {
                          //Get.to(() => vi_display());
                          Get.to(() => vi_PendingCheques());
                        } else {
                          Get.snackbar("Alert",
                              "No DATA, Please Contact Your Administrator");
                        }
                      }),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  ListTile(
                      selected: selectedIndex == 1,
                      leading: Icon(
                        Icons.library_books_outlined,
                        size: 28,
                      ),
                      title: lblDrawerTile3,
                      onTap: () async {
                        changeIndex(0);
                        Get.snackbar("Please Wait", "Data Is Loading");

                        if (await Fnc_PendingSO() == true) {
                          Get.to(() => vi_PendingSaleOrderr());
                        } else {
                          Get.snackbar("Alert",
                              "No DATA, Please Contact Your Administrator");
                        }
                      }),

                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 1,
                  ),

                  ListTile(
                      selected: selectedIndex == 1,
                      leading: Icon(
                        Icons.library_books_outlined,
                        size: 28,
                      ),
                      title: lblDrawerTile4,
                      onTap: () async {
                        changeIndex(0);
                        Get.snackbar("Please Wait", "Data Is Loading");

                        if (await Fnc_ItemQuery() == true) {
                          Get.to(() => vi_ItemQuery());
                        } else {
                          Get.snackbar("Alert",
                              "No DATA, Please Contact Your Administrator");
                        }
                      }),

                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 1,
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 280),
                    child: ListTile(
                        selected: selectedIndex == 1,
                        leading: Icon(
                          Icons.logout,
                          size: 28,
                        ),
                        title: lbllogout,
                        onTap: () async {

                          FncClearAllDATA();

                        }),
                  ),

                  //tile2
                ],
              ),
            ],
          ),
        ),
      ),
      key: scafKey,
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
            stops: [0.1, 0.5, 0.7, 0.9],
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
            child: Stack(children: <Widget>[
              Container(
                height: 500,
              ),
              Container(
                margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                height: 220,
                width: 480,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                  gradient: LinearGradient(colors: [
                    Colors.lightBlueAccent.shade200,
                    Colors.lightBlueAccent.shade200,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 55, left: 180),
                      child: lblDrawerTile6,
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 42, left: 12),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu_sharp,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      scafKey.currentState?.openDrawer();
                    },
                  )),
              Container(
                margin: EdgeInsets.only(top: 110, left: 112),
                child: Text(
                  "80",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 103, left: 73),
                child: SizedBox(
                  height: 40,
                  child: Image.asset("assets/inc.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 129, left: 80),
                child: Text(
                  "Balance",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 110, left: 212),
                child: Text(
                  "30",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 103, left: 173),
                child: SizedBox(
                  height: 35,
                  child: Image.asset("assets/dec.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 129, left: 180),
                child: Text(
                  "Payment",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 110, left: 312),
                child: Text(
                  "7",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 103, left: 273),
                child: SizedBox(
                  height: 40,
                  child: Image.asset("assets/inc.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 129, left: 290),
                child: Text(
                  "Over Due Amount",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 180, left: 20),
                width: 215,
                height: 75,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 5),
                          blurRadius: 4)
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 100),
                      child: lblDrawerlabel3,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 45, left: 100),
                        child: Text(
                          "RS: 45415",
                          style: TextStyle(color: Colors.black38, fontSize: 23),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 7),
                      child: SizedBox(
                        height: 35,
                        child: Image.asset("assets/cashr.png"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 180, left: 250),
                width: 215,
                height: 75,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 5),
                          blurRadius: 4)
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 100),
                      child: lblDrawerlabel4,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 45, left: 100),
                        child: Text(
                          "RS: 45415",
                          style: TextStyle(color: Colors.black38, fontSize: 23),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 7),
                      child: SizedBox(
                        height: 35,
                        child: Image.asset("assets/cashp.png"),
                      ),
                    ),
                  ],
                ),
              ),

              //Grid

              //Grid
            ]),
          ),
        ),
      ),
    );
  }

  //=================DART==================

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  FncstartupSettings() {
    //Labels
    lblDrawer.TxtText = "D R A W E R";
    lblDrawer.TxtFontSize = 15;
    lblDrawer.color = Colors.black38;

    lblDrawerlabel1.TxtText = "BANK BALANCE";
    lblDrawerlabel1.TxtFontSize = 18;
    lblDrawerlabel1.color = Colors.black38;

    lblDrawerlabel2.TxtText = "CASH BALANCE";
    lblDrawerlabel2.TxtFontSize = 18;
    lblDrawerlabel2.color = Colors.black38;

    lblDrawerlabel3.TxtText = "TOTAL DEBIT";
    lblDrawerlabel3.TxtFontSize = 15;
    lblDrawerlabel3.color = Colors.black38;

    lblDrawerlabel4.TxtText = "TOTAL CREDIT";
    lblDrawerlabel4.TxtFontSize = 15;
    lblDrawerlabel4.color = Colors.black38;

    lblDrawerlabel5.TxtText = "PAYABLE";
    lblDrawerlabel5.TxtFontSize = 18;
    lblDrawerlabel5.color = Colors.black38;

    lblDrawerTile6.TxtText = " Dashboard";
    lblDrawerTile6.TxtFontSize = 20;
    lblDrawerTile6.color = Colors.black38;

    lblDrawerTile1.TxtText = "Ledger";
    lblDrawerTile1.TxtFontSize = 17;
    lblDrawerTile1.color = Colors.black38;

    lblDrawerTile2.TxtText = "Pending Cheques";
    lblDrawerTile2.TxtFontSize = 17;
    lblDrawerTile2.color = Colors.black38;

    lblDrawerTile3.TxtText = "Pending Sale Order";
    lblDrawerTile3.TxtFontSize = 17;
    lblDrawerTile3.color = Colors.black38;

    lblDrawerTile4.TxtText = "Item Query";
    lblDrawerTile4.TxtFontSize = 17;
    lblDrawerTile4.color = Colors.black38;

    lbllogout.TxtText = "Logout";
    lbllogout.TxtFontSize = 17;
    lbllogout.color = Colors.black38;
  }

  Future<bool> Fnc_AccountLedger() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    List<ModI_AccountLedger>? l_listI_AccountLedger =
        new List<ModI_AccountLedger>.empty(growable: true);
    l_listI_AccountLedger = await SlEAccountLedger().Fnc_AccountLedger(
        DateTime.parse("2021-01-01"), DateTime.parse("2021-03-31"));
    {
      if (l_listI_AccountLedger == null) {
        Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
        return false;
      }
      RxList<ModI_AccountLedger>? Rx_ListAccountLegdger =
          <ModI_AccountLedger>[].obs;
      Rx_ListAccountLegdger.addAll(l_listI_AccountLedger);

      cmGlobalVariables.Pbl_AccountLedger?.addAll(l_listI_AccountLedger);
    }

    Navigator.of(context).pop();
    return true;
  }

  Future<bool> Fnc_PendingCheques() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    List<ModI_PendingCheques>? l_listIPendingCheques =
        new List<ModI_PendingCheques>.empty(growable: true);
    l_listIPendingCheques = await SlEPendingCheques().Fnc_PendingCheques();
    {
      if (l_listIPendingCheques == null) {
        Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
        return false;
      }
      RxList<ModI_PendingCheques>? Rx_l_listIPendingCheques =
          <ModI_PendingCheques>[].obs;
      Rx_l_listIPendingCheques.addAll(l_listIPendingCheques);

      Get.put(Rx_l_listIPendingCheques, tag: "Rx_l_listIPendingCheques");
    }

    Navigator.of(context).pop();
    return true;
  }

  Future<bool> Fnc_PendingSO() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    List<ModI_PendingSaleOrder>? l_listIPendingSaleOrder =
        new List<ModI_PendingSaleOrder>.empty(growable: true);

    l_listIPendingSaleOrder = await SlEPendingSelOrder().Fnc_PendingSO();
    {
      if (l_listIPendingSaleOrder == null) {
        Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
        return false;
      }
      RxList<ModI_PendingSaleOrder>? Rx_l_listIPendingSaleOrder =
          <ModI_PendingSaleOrder>[].obs;
      Rx_l_listIPendingSaleOrder.addAll(l_listIPendingSaleOrder);

      Get.put(Rx_l_listIPendingSaleOrder, tag: "Rx_l_listIPendingSaleOrder");
    }

    Navigator.of(context).pop();
    return true;
  }

  Future<bool> Fnc_ItemQuery() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    List<DTO>? l_listItemQuery = new List<DTO>.empty(growable: true);
    l_listItemQuery = await SlEItemQuery().Fnc_ItemQuery();
    {
      if (l_listItemQuery == null) {
        Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
        return false;
      }

      RxList<DTO>? Rx_l_listDTOModel = <DTO>[].obs;
      Rx_l_listDTOModel.addAll(l_listItemQuery);

      Get.put(Rx_l_listDTOModel, tag: "Rx_l_listDTOModel");
    }

    Navigator.of(context).pop();
    return true;
  }

  Future<bool> Fnc_UserAccounts() async {
    List<ModUserAccountsQuery>? l_listUserAccountsQuery =
        new List<ModUserAccountsQuery>.empty(growable: true);
    l_listUserAccountsQuery =
        await SLEUserAccountsQuery().Fnc_UserAccountsQuery();
    {
      if (l_listUserAccountsQuery == null) {
        Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
        return false;
      }

      cmGlobalVariables.Pb_SelectedDID =
          l_listUserAccountsQuery[0].Pr_AccountsDID;

      RxList<ModUserAccountsQuery>? Rx_l_UserAccountsQuery =
          <ModUserAccountsQuery>[].obs;
      Rx_l_UserAccountsQuery.addAll(l_listUserAccountsQuery);

      Get.put(Rx_l_UserAccountsQuery, tag: "Rx_l_listDTOModel");
      cmGlobalVariables.Pb_ListUserAccountsQuery?.addAll(
          l_listUserAccountsQuery);
    }
    return true;
  }

  void FncClearAllDATA() {
    cmGlobalVariables.Pb_Token = "";
    cmGlobalVariables.Pb_UserDID = "";
    cmGlobalVariables.Pb_UserName = "";
    cmGlobalVariables.Pb_UserImage = "";
    cmGlobalVariables.Pb_UserEmail = "";
    cmGlobalVariables.Pb_UserNumber = "";
    cmGlobalVariables.Pb_Report = "";
    cmGlobalVariables.PbSelectedBranch = 0;
    cmGlobalVariables.PbDefaultBranch = 0;
    cmGlobalVariables.PbCount = 0;
    cmGlobalVariables.Pb_SelectedDID = "";
    cmGlobalVariables.Pb_jsonString = "";
    cmGlobalVariables.PbCompanySettingQuery.clear();
    cmGlobalVariables.Pbl_AccountLedger.clear();
    cmGlobalVariables.Testledger.clear();
    cmGlobalVariables.DTOItemQueryList.clear();
    cmGlobalVariables.Pb_ListUserAccountsQuery.clear();



    Get.to(() => vi_login());



  }
}
