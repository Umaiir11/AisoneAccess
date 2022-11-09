import 'dart:convert';

import '../../ClassModules/cmHttpCalls.dart';
import '../../Models/EModel/ModCompanyURLs.dart';

class SlCompanyURLs {
  Future<ModCompanyURLs?> Fnc_CompanyURls(
      String name, String pass, String uuid) async {
    try {
      final body = {
        'pr_EmailID': name,
        'pr_Password': pass,
        'pr_CompanyDID': uuid
      };

      //Uri.https('www.aisonesystems.com', '/apiUser/ApiCompanyURLs/Post');
      String l_jsonString = json.encode((body));
      List<int> l_UtfContent = utf8.encode(l_jsonString);

      final l_response = await new cmHttpCalls()
          .Fnc_HttpResponseWeb('/apiUser/ApiCompanyURLs/Post', l_UtfContent);
      print(l_response);
      if (l_response.statusCode == 200) {
        return Fnc_JsonToModel(jsonDecode(l_response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ModCompanyURLs Fnc_JsonToModel(Map<String, dynamic> l_JsonObject) {
    ModCompanyURLs l_ModCompanyURLs = new ModCompanyURLs();
    l_ModCompanyURLs.Pr_ApiErpUrl = l_JsonObject["Pr_ApiErpUrl"];
    l_ModCompanyURLs..Pr_ApiRepServerUrl = l_JsonObject["Pr_ApiRepServerUrl"];
    l_ModCompanyURLs.Pr_PKGUID = l_JsonObject["Pr_PKGUID"];
    l_ModCompanyURLs.Pr_Token = l_JsonObject["Pr_Token"];
    l_ModCompanyURLs..Pr_WebErpUrl = l_JsonObject["Pr_WebErpUrl"];

    return l_ModCompanyURLs;
  }

  List<ModCompanyURLs> Fnc_JsonToListOfModel(List<dynamic> l_JsonList) {
    //Declare Local Variable For list Of Model and instance

    List<ModCompanyURLs> l_ListCompanyURLs =
        new List<ModCompanyURLs>.empty(growable: true);

    //Start Irritation From Json String

    for (dynamic l_JsonObject in l_JsonList) {
      ModCompanyURLs l_ModCompanyURLs = new ModCompanyURLs();
      l_ModCompanyURLs = Fnc_JsonToModel(l_JsonObject);
      l_ListCompanyURLs.add(l_ModCompanyURLs);
    }
    return l_ListCompanyURLs;
  }
}
