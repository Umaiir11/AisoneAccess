import 'package:aisoneaccess/ClassModules/cmGlobalVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/EModel/DTO.dart';

class vi_ItemQuery extends StatefulWidget {
  const vi_ItemQuery({Key? key}) : super(key: key);

  @override
  State<vi_ItemQuery> createState() => _vi_ItemQueryState();
}

class _vi_ItemQueryState extends State<vi_ItemQuery> {
  @override
  late RxList<DTO> l_ListItemsQuery = Get.find(tag: "Rx_l_listDTOModel");
  List<DTO> l_List_Elements = <DTO>[];
  bool isVisible = true;



  void initState() {
    super.initState();
    l_List_Elements.addAll(l_ListItemsQuery);
  }

  bool isFolded = true;
  TextEditingController _textController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          setState(() {
            isVisible = !isVisible;
          });

        },
        child: Icon(Icons.remove_red_eye), // icon to be displayed on the button
        backgroundColor: Colors.blue, // background color of the button
      ),
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
              child: Text("I T E M S")),
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
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 370),
                  margin: EdgeInsets.only(top: 20, left: 27),
                  width: isFolded ? 52 : 320,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.grey.shade200,
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
                                        hintStyle:
                                            TextStyle(color: Colors.black),
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
                                padding: EdgeInsets.all(16.0),
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
              ),
              Container(
                  margin: EdgeInsets.only(top: 75, left: 0),
                  child: ListView.builder(
                    itemCount: l_List_Elements.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {},
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
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

                                    child :Stack(
                                        children: [
                                          Container(
                                              height: 170,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        (index % 2 == 0)
                                                            ? Colors.white
                                                            : Colors.grey.shade300,
                                                        (index % 2 == 0)
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

                                          //ID
                                          Visibility(
                                            visible: isVisible,
                                            child: Positioned(
                                              top: 15,
                                              left: 10,
                                              child: Container(
                                                child: Text(
                                                  "ID: ",
                                                  style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          // fontWeight: FontWeight.w600,
                                                          letterSpacing: .5)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isVisible,
                                            child: Positioned(
                                              top: 15,
                                              left: 33,
                                              child: Container(



                                                child: Text(
                                                  l_List_Elements[index]
                                                      .Pr_ItemID
                                                      .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .indigoAccent.shade200,
                                                          fontWeight: FontWeight.w600,
                                                          letterSpacing: .5)),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //UOM
                                          Visibility(
                                            visible: isVisible,
                                            child: Positioned(
                                              top: 15,
                                              left: 322,
                                              child: Container(
                                                child: Text(
                                                  "UOM: ",
                                                  style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          // fontWeight: FontWeight.w600,
                                                          letterSpacing: .5)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isVisible,
                                            child: Positioned(
                                              top: 15,
                                              left: 365,
                                              child: Container(
                                                child: Text(
                                                  l_List_Elements[index]
                                                      .Pr_UOM
                                                      .toString(),
                                                  style: GoogleFonts.ubuntu(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .indigoAccent.shade200,
                                                          fontWeight: FontWeight.w600,
                                                          letterSpacing: .5)),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //List1
                                          Positioned(
                                            top: 43,
                                            left: 10,
                                            child: Container(
                                              child: Text(
                                                "List1: ",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 43,
                                            left: 53,
                                            child: Container(
                                              child: Text(
                                                l_List_Elements[index]
                                                    .Pr_List1
                                                    .toString(),
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .indigoAccent.shade200,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),

                                          //List2
                                          Positioned(
                                            top: 43,
                                            left: 250,
                                            child: Container(
                                              child: Text(
                                                "List2: ",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 44,
                                            left: 293,
                                            child: Container(
                                              child: Text(
                                                maxLines: 1,
                                                l_List_Elements[index]
                                                    .Pr_List2
                                                    .toString(),
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .indigoAccent.shade200,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),

                                          //String1
                                          Positioned(
                                            top: 71,
                                            left: 10,
                                            child: Container(
                                              child: Text(
                                                "String1: ",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 71,
                                            left: 70,
                                            child: Container(
                                              child: Text(
                                                maxLines: 1,
                                                l_List_Elements[index]
                                                    .Pr_Str1
                                                    .toString(),
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .indigoAccent.shade200,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),

                                          //String2
                                          Positioned(
                                            top: 71,
                                            left: 240,
                                            child: Container(
                                              child: Text(
                                                "String2: ",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 71,
                                            left: 300,
                                            child: Container(
                                              child: Text(
                                                maxLines: 1,
                                                l_List_Elements[index]
                                                    .Pr_Str2
                                                    .toString(),
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .indigoAccent.shade200,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),

                                          //Qty
                                          Positioned(
                                            top: 95,
                                            left: 10,
                                            child: Container(
                                              child: Text(
                                                "Quantity: ",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 94,
                                            left: 122,
                                            child: Container(
                                              child: Text(
                                                maxLines: 1,
                                                l_List_Elements[index]
                                                    .Pr_Qty
                                                    .toString(),
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .indigoAccent.shade200,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),

                                          //Rate
                                          Positioned(
                                            top: 95,
                                            left: 250,
                                            child: Container(
                                              child: Text(
                                                "Rate: ",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 94,
                                            left: 290,
                                            child: Container(
                                              child: Text(
                                                maxLines: 1,
                                                l_List_Elements[index]
                                                    .Pr_Rate
                                                    .toString(),
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .indigoAccent.shade200,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                          //Des
                                          Positioned(
                                            top: 125,
                                            left: 10,
                                            child: Container(
                                              child: Text(
                                                "Description: ",
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 125,
                                            left: 97,
                                            child: Container(
                                              child: Text(
                                                maxLines: 2,
                                                l_List_Elements[index]
                                                    .Pr_Desc
                                                    .toString(),
                                                style: GoogleFonts.ubuntu(
                                                    textStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .indigoAccent.shade200,
                                                        fontWeight: FontWeight.w600,
                                                        letterSpacing: .5)),
                                              ),
                                            ),
                                          ),
                                        ],

                                      )

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
        ));
  }

  void FncfilterSearchResults(String UserInput) {
    List<DTO> dummySearchList = <DTO>[];
    dummySearchList.addAll(l_ListItemsQuery);
    List<DTO> l_SearchedListItems = [];

    List<DTO> l_dummyListData = <DTO>[];
    if (UserInput.isNotEmpty) {
      UserInput.split(' ').forEach((s) {
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_ItemID.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_ItemID.toString().toUpperCase().contains(s)));

        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_UOM.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_UOM.toString().toUpperCase().contains(s)));

        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_List1.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_List1.toString().toUpperCase().contains(s)));

        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_List2.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_List2.toString().toUpperCase().contains(s)));

        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Str1.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Str1.toString().toUpperCase().contains(s)));

        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Str2.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Str2.toString().toUpperCase().contains(s)));

        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Qty.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Qty.toString().toUpperCase().contains(s)));

        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Rate.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Rate.toString().toUpperCase().contains(s)));

        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Desc.toString().toLowerCase().contains(s)));
        l_SearchedListItems.addAll(l_ListItemsQuery.where((l_listelement) =>
            l_listelement.Pr_Desc.toString().toUpperCase().contains(s)));

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
        l_List_Elements.addAll(l_ListItemsQuery);
      });
    }
  }
}
