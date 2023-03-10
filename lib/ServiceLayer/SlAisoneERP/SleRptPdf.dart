import 'dart:convert';
import 'dart:typed_data';

import 'package:aisoneaccess/ClassModules/cmGlobalVariables.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../ClassModules/cmCryptography.dart';
import '../../ClassModules/cmHttpCalls.dart';
import '../../Models/EModel/ModRptAccLedger.dart';
import 'SlEncryption.dart';

String? l_Encryption;

var d1 = "2022-01-13T13:49:44";
var d2 = "2022-08-13T13:49:44";
class SlERptPdf {
  Future<String?> Fnc_reportpdf() async {
    try {
      final body = ModRptAccLedger(
        Pr_FormDID: 6503,
        Pr_ReportName: "RptSerDevAccountLedger",
        Pr_BranchID: 1,
        Pr_Token:cmGlobalVariables.Pb_Token!,
        Pr_AccountDID: cmGlobalVariables.Pb_ListUserAccountsQuery[0].Pr_AccountsDID ,
        Pr_FromDate:DateTime.parse(d1),
        Pr_ToDate:DateTime.parse(d2),
        Pr_WhereClause_PC:
            "and [AccountDID]:'" +cmGlobalVariables.Pb_ListUserAccountsQuery[0].Pr_AccountsDID+"'and[ChequeStatusDID]in(1,2)and[PostedID]:1",
        Pr_GroupByClause_PC: "",
        Pr_OrderByClause_PC: "Order By ChequeType , [ChequeDate] desc",
        Pr_City: "Lahore",
        Pr_Address: "Pakistan",
        Pr_PrintedBy: "CustCare",
      );

      String l_jsonString = json.encode(body.toJson());
      cmGlobalVariables.Pb_jsonString = l_jsonString;

      if (await Fnc_OnlineEncryption() == true) {
        String encoded = Uri.encodeComponent(l_Encryption!);
        // print(encoded);
        List<int> l_UtfContent = utf8.encode(l_jsonString);
        final l_response = await new cmHttpCalls().Fnc_HttpResponseforReport(
            '/RptSerAccountLedger/pdf?l_QueryString=', l_UtfContent, encoded);
        if (l_response.statusCode == 200) {
          //return json.decode(json.encode(l_response.body));
          return json.decode(l_response.body);
        } else {}
      } else {
        Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<bool> Fnc_OnlineEncryption() async {
  //Assigned Branches Api Call
  l_Encryption = await SlEncryption().Fnc_ItemQuery();
  {
    if (l_Encryption == null) {
      Get.snackbar("Alert", "No DATA, Please Contact Your Administrator");
      return false;
    }
  }

  return true;
}
