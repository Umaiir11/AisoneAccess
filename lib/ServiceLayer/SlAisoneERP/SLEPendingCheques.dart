import 'dart:convert';

import '../../../Models/EModel/ModPendingCheques.dart';
import '../../ClassModules/cmHttpCalls.dart';

class SlEPendingCheques {
  Future<List<ModI_PendingCheques>?> Fnc_PendingCheques() async {
    try {

      final body = {
        "Pr_Branchid": "1",
        "Pr_WhereClause": "",
        "Pr_GroupByClause": "",
        "Pr_OrderByClause": ""
      };

      String l_jsonString = json.encode((body));
      List<int> l_UtfContent = utf8.encode(l_jsonString);

      final l_response = await new cmHttpCalls().Fnc_HttpResponseERPBoth(
          '/RptPendingCheques/Fnc_Read_SP', l_UtfContent);

      if (l_response.statusCode == 200) {
        var a = l_response;
        print(a);
        return Fnc_JsonToListOfModel(jsonDecode(l_response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ModI_PendingCheques Fnc_JsonToModel(Map<String, dynamic> l_JsonObject) {
    ModI_PendingCheques l_ModI_PendingCheques = new ModI_PendingCheques();

    l_ModI_PendingCheques.Pr_PKGUID = l_JsonObject["Pr_PKGUID"] ?? '0' ;
    l_ModI_PendingCheques.Pr_VNO = l_JsonObject["Pr_VNO"] ?? 0;
    l_ModI_PendingCheques.Pr_VoucherNo = l_JsonObject["Pr_VoucherNo"] ?? '0';
    l_ModI_PendingCheques.Pr_VDate =
        DateTime.parse(l_JsonObject["Pr_VDate"] ?? "2022-08-06T00:00:00") ;
    l_ModI_PendingCheques.Pr_ChequeDate =
      DateTime.parse( l_JsonObject["Pr_ChequeDate"] ?? "2022-08-06T00:00:00") ;
    l_ModI_PendingCheques.Pr_AccountDID = l_JsonObject["Pr_AccountDID"] ?? '0';
    l_ModI_PendingCheques.Pr_AccountID = l_JsonObject["Pr_AccountID"] ?? '0';
    l_ModI_PendingCheques.Pr_ChequeNo = l_JsonObject["Pr_ChequeNo"] ?? '0';
    l_ModI_PendingCheques.Pr_RefNo = l_JsonObject["Pr_RefNo"] ?? '0';
    l_ModI_PendingCheques.Pr_Remarks = l_JsonObject["Pr_Remarks"] ?? '0';

    lat:
    l_ModI_PendingCheques.Pr_Amount = l_JsonObject["Pr_Amount"] ?? 0;
    lat:
    l_ModI_PendingCheques.Pr_PendingDebit =
        l_JsonObject["Pr_PendingDebit"] ?? 0;
    lat:
    l_ModI_PendingCheques.Pr_PendingCredit =
        l_JsonObject["Pr_PendingCredit"] ?? 0;

    l_ModI_PendingCheques.Pr_ChequeStatusDID =
        l_JsonObject["Pr_ChequeStatusDID"] ?? 0;
    l_ModI_PendingCheques.Pr_ChequeStatus =
        l_JsonObject["Pr_ChequeStatus"] ?? '0';
    l_ModI_PendingCheques.Pr_ChequeType = l_JsonObject["Pr_ChequeType"] ?? 0;
    l_ModI_PendingCheques.Pr_PostedID = l_JsonObject["Pr_PostedID"] ?? false;
    l_ModI_PendingCheques.Pr_BranchID = l_JsonObject["Pr_BranchID"] ?? 0;
    return l_ModI_PendingCheques;
  }

  List<ModI_PendingCheques> Fnc_JsonToListOfModel(List<dynamic> l_JsonList) {
    List<ModI_PendingCheques> l_ListModI_PendingCheques =
        new List<ModI_PendingCheques>.empty(growable: true);
    for (dynamic l_JsonObject in l_JsonList) {
      ModI_PendingCheques l_ModI_PendingCheques = new ModI_PendingCheques();
      l_ModI_PendingCheques = Fnc_JsonToModel(l_JsonObject);
      l_ListModI_PendingCheques.add(l_ModI_PendingCheques);
    }
    return l_ListModI_PendingCheques;
  }
}
