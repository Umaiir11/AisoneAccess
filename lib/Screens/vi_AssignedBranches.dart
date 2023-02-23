import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ClassModules/cmGlobalVariables.dart';
import '../Models/EModel/ModBranchSetting.dart';
import '../UserWidgets/Labels/UWLabels.dart';
import '../UserWidgets/Labels/Ulabels.dart';
import 'Drawer.dart';

class vi_AssignedBranches extends StatefulWidget {
  const vi_AssignedBranches({Key? key}) : super(key: key);

  @override
  State<vi_AssignedBranches> createState() => _vi_AssignedBranchesState();
}

class _vi_AssignedBranchesState extends State<vi_AssignedBranches> {
  @override
  late RxList<ModAssignedBranches> Rx_AssignedBranches =
      Get.find(tag: "Rx_AssignedBranches");
  int selectedIndeX = 0;


  //UserWidgets
  ULabels lblbranchList = new ULabels();
  ULabels lblbranchName = new ULabels();

  void initState() {
    super.initState();
    FncstartupSettings();
  }

  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: SizedBox(
        height: 33,
        child:BottomAppBar(
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



                  Container(height :100,),
                  Container(
                    margin: EdgeInsets.only(top: 7.5, left: 84),
                    child: InkWell(
                      onTap: () => launchUrl(Uri.parse('https://www.aisonesystems.com/')),
                      child: Text(
                        'Powered by - aisonesystems.com',style:

                      GoogleFonts.ubuntu(
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
                        Icons.phone_forwarded_outlined, size: 25,color: Colors.indigoAccent,
                      ),
                      onPressed: () async {
                        Uri phoneno = Uri.parse('tel:+923214457734');
                        if (await launchUrl(phoneno)) {
                          //dialer opened
                        }else{
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
                        size: 25,color: Colors.green,
                      ),
                      onPressed: () async {

                        var whatsapp = "+923214457734";
                        Uri whatsappopen = Uri.parse("whatsapp://send?phone=$whatsapp");
                        if (await launchUrl(whatsappopen)) {
                          //dialer opened
                        }else{
                          //dailer is not opened
                        }
                      },
                    ),
                  ),
                ],
              ),
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
              Color(0x3A88CDF8),
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
                margin: EdgeInsets.only(top: 103, left: 160),
                child: SizedBox(
                  height: 165,
                  child: Image.asset("assets/aa.png"),
                ),
              ),
              Container(

                margin: EdgeInsets.only(top: 80, left: 127),
                child: Shimmer.fromColors(
                    baseColor: Colors.black26,
                    highlightColor: Colors.cyanAccent,
                    child: lblbranchList),
              ),
              //Cards and Decorated Containers
              Container(

                margin: EdgeInsets.only(top: 250, left: 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Rx_AssignedBranches.length,
                  itemBuilder: (context, index) {
                    //get selected index on tap,
                    //after that got Company Did that index
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {

                            FncSelectedBranch();
                            Get.to(() => vi_Drawer());

                            setState(() {
                              selectedIndeX = index;
                            });
                          },
                          child: SizedBox(
                            width: 450,
                            height: 140,
                            child: Card(
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                (index % 2 == 0) ? Colors.lightBlueAccent.shade100 : Colors.redAccent.shade100,
                                                (index % 2 == 0) ? Colors.lightBlueAccent.shade100 : Colors.redAccent.shade100,
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
                                  Positioned.fill(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Image.asset(
                                            "assets/company.png",
                                            height: 64,
                                            width: 64,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              lblbranchName,
                                              SizedBox(
                                                height: 12,
                                              ),
                                              UWLabels(
                                                  text: Rx_AssignedBranches[index]
                                                      .pr_BranchName,
                                                  l_FontSize: 18,
                                                  color: Colors.black38),
                                              const SizedBox(height: 16),
                                              Wrap(
                                                spacing: 10.0,
                                                runSpacing: 10.0,
                                                direction: Axis.vertical,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      const Icon(
                                                        MdiIcons.googleMaps,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      UWLabels(
                                                          text:
                                                              Rx_AssignedBranches[
                                                                      index]
                                                                  .pr_Address,
                                                          l_FontSize: 18,
                                                          color: Colors.black38),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: const TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        letterSpacing: .5)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

            ]),
          ),
        ),
      ),
    );
  }

  //=================DART==================

  FncstartupSettings() {
    //Labels
    lblbranchList.TxtText = "B R A N C H E S";
    lblbranchList.TxtFontSize = 30;
    lblbranchList.color = Colors.black38;

    lblbranchName.TxtText = "Company Name";
    lblbranchName.TxtFontSize = 21;
    lblbranchName.color = Colors.black87;
  }

  FncSelectedBranch()
  {
   cmGlobalVariables.PbSelectedBranch =     Rx_AssignedBranches[selectedIndeX].pr_BranchDID;
  }
}
