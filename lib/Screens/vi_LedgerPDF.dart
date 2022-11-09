import 'package:aisoneaccess/ClassModules/cmGlobalVariables.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


late PdfViewerController _pdfViewerController;
late PdfTextSearchResult _searchResult;

class Controll extends StatefulWidget {
  const Controll({Key? key}) : super(key: key);

  @override

  State<Controll> createState() => _ControllState();
}

class _ControllState extends State<Controll> {
  @override

  void initState() {
    fncPrint();
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account Ledger PDF'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.zoom_in,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.zoomLevel = 4;
              },
            ),
          ],
        ),
        body: SfPdfViewer.memory(
          cmGlobalVariables.Pb_Report!,

          pageLayoutMode: PdfPageLayoutMode.single,
          scrollDirection: PdfScrollDirection.horizontal,
          enableDoubleTapZooming: true
          ,        )
    );
  }

  fncPrint(){

    print(cmGlobalVariables.Pb_Report);
    print(cmGlobalVariables.Pb_Report);
    print(cmGlobalVariables.Pb_Report);
  }
}


