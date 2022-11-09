import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../ClassModules/cmHttpCalls.dart';
import '../../../Models/EModel/ModBranchSetting.dart';
import '../../ClassModules/cmGlobalVariables.dart';
import '../../ClassModules/cmHttpCalls.dart';
import '../../Models/EModel/ModBranchSetting.dart';

class SlEAssignedBranches {
  Future<List<ModAssignedBranches>?> Fnc_AssignedBranches() async {
    try {


    String a=    cmGlobalVariables.Pb_UserDID!;
    print(a);
    print(a);
  //String? l_Where ="where VMDID=" + cmGlobalVariables.Pb_UserDID!;
      //" Where UserDID = '" & Pb_UserDID.ToString & "' and IsAssigned = 1"
      final body = {
        "Pr_Branchid": "1",
        "Pr_WhereClause": "where UserDID='" +cmGlobalVariables.Pb_UserDID!+"'",
        "Pr_GroupByClause": "",
        "Pr_OrderByClause": ""
      };
     // Uri l_uri = Uri.http(ipAddress, '/RptAssignedBranches/Fnc_Read_Sp');

      String l_jsonString = json.encode((body));
      List<int> l_UtfContent = utf8.encode(l_jsonString);

      final l_response = await new cmHttpCalls().Fnc_HttpResponseERPBoth('RptAssignedBranches/Fnc_Read_Sp', l_UtfContent);

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

  ModAssignedBranches Fnc_JsonToModel(Map<String, dynamic> l_JsonObject) {
    ModAssignedBranches l_ModAssignedBranches = ModAssignedBranches();
    l_ModAssignedBranches?.pr_UserDID = l_JsonObject["Pr_UserDID"];
    l_ModAssignedBranches?.pr_BranchDID = l_JsonObject["Pr_BranchDID"];
    l_ModAssignedBranches?.pr_BranchName = l_JsonObject["Pr_BranchName"];
    l_ModAssignedBranches?.pr_BranchPreFix = l_JsonObject["Pr_BranchPreFix"];
    l_ModAssignedBranches?.pr_Address = l_JsonObject["Pr_Address"];
    l_ModAssignedBranches?.pr_IsAssigned = l_JsonObject["Pr_IsAssigned"];
    return l_ModAssignedBranches;
  }

  List<ModAssignedBranches> Fnc_JsonToListOfModel(List<dynamic> l_JsonList) {
    //Declare Local Variable For list Of Model and instance

    List<ModAssignedBranches> l_ListModBranchSettting =
        new List<ModAssignedBranches>.empty(growable: true);

    //Start Irritation From Json String

    for (dynamic l_JsonObject in l_JsonList) {
      ModAssignedBranches l_ModBranchSettting = new ModAssignedBranches();
      l_ModBranchSettting = Fnc_JsonToModel(l_JsonObject);
      l_ListModBranchSettting.add(l_ModBranchSettting);
    }
    return l_ListModBranchSettting;
  }
}
