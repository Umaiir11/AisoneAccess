import 'package:aisoneaccess/ClassModules/cmGlobalVariables.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../UserWidgets/Labels/Ulabels.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class Controll extends StatefulWidget {
  const Controll({Key? key}) : super(key: key);

  @override
  State<Controll> createState() => _ControllState();
}

class _ControllState extends State<Controll> {
  @override
  String fileName = "Account Ledger";
  int count = 0;

  void initState() {
    super.initState();
    lblAppBar.TxtText = "REPORT";
    lblAppBar.TxtFontSize = 24;
    lblAppBar.color = Colors.black87;

    AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'Key1',
        channelName: 'file downloaded',
        channelDescription: ' done',
        defaultColor: Colors.cyanAccent,
        ledColor: Colors.white,
        playSound: true,
        soundSource: "",
        enableLights: true,
        enableVibration: true,
      )
    ]);
  }

  ULabels lblAppBar = new ULabels();

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          count++;
          FncPermissions();
        },
        child: Icon(Icons.save_alt), // icon to be displayed on the button
        backgroundColor: Colors.blue, // background color of the button
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed:shareFile





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
                        Icons.whatsapp_outlined,
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
        child: SfPdfViewer.memory(
          cmGlobalVariables.Pb_Report!,
          pageLayoutMode: PdfPageLayoutMode.continuous,
          scrollDirection: PdfScrollDirection.vertical,
          enableDoubleTapZooming: true,
        ),
      ),
    );
  }

  void FncSaveBytesAsPdf(String fileName) async {
    String l_filePath = '/storage/emulated/0/Download/$fileName($count).pdf';
    File l_file = File(l_filePath);
    l_file.writeAsBytes(cmGlobalVariables.Pb_Report);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Report Saved"),
      duration: Duration(milliseconds: 1200),
    ));
  }

  Future<void> FncPermissions() async {
    PermissionStatus l_mediaPermission = await Permission.storage.request();

    if (l_mediaPermission == PermissionStatus.granted) {
      FncSaveBytesAsPdf(fileName);
      notify();
    }

    if (l_mediaPermission == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("This permission is recommended."),
        duration: Duration(milliseconds: 900),
      ));
    }

    if (l_mediaPermission == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  void notify() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 1,
      channelKey: 'Key1',
      title: '${Emojis.activites_party_popper + " File Saved"}',
      body: "PDF saved in 'Download' location",
      wakeUpScreen: true,
      notificationLayout: NotificationLayout.BigText,
    ));
  }


  Future<void> _shareFile() async {
    String l_filePath = '/storage/emulated/0/Download/$fileName($count).pdf';
    try {
      await Share.shareXFiles([XFile(l_filePath)], text: 'Sharing a PDF file');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> shareFile() async {
    await _shareFile();
  }


}
