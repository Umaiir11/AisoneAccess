
import '../Models/EModel/DTO.dart';
import '../Models/EModel/ModAccLedger.dart';
import '../Models/EModel/ModCompanySettingQuery.dart';
import '../Models/EModel/ModUserAccountsQuery.dart';



class cmGlobalVariables {
  static String Pb_WebAPIURL = "www.aisonesystems.com";
  static String? Pb_ERPApiUrl = "";
  static String? Pb_ERP_API = "";
  static String? Pb_Token;
  static bool Pb_isOffline = false;
  static String? Pb_UserDID;

  static String? Pb_UserName;
  static var Pb_UserImage;
  static String? Pb_UserEmail;
  static String? Pb_UserNumber;

  static var Pb_Report;


  static int? PbSelectedBranch;
  static int? PbDefaultBranch;

  static int? PbCount;


  static var Pb_SelectedDID;

  static String? Pb_jsonString;



  static List<ModCompanySettingQuery> PbCompanySettingQuery =
  new List<ModCompanySettingQuery>.empty(growable: true);

  static List<ModI_AccountLedger> Pbl_AccountLedger =
  new List<ModI_AccountLedger>.empty(growable: true);

  static List<ModI_AccountLedger> Testledger =
  new List<ModI_AccountLedger>.empty(growable: true);

  static List<DTO> DTOItemQueryList = new List<DTO>.empty(growable: true);


  static List<ModUserAccountsQuery> Pb_ListUserAccountsQuery = new List<ModUserAccountsQuery>.empty(growable: true);




}
