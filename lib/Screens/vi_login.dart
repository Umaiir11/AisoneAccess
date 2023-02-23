import 'dart:async';

import 'package:aisoneaccess/Screens/vi_CompanyLIst.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../ClassModules/cmGlobalVariables.dart';
import '../Models/EModel/ModCompanySettingQuery.dart';
import '../Models/EModel/ModUserProfile.dart';
import '../ServiceLayer/SlAisoneERP/SlWLogin.dart';
import '../ServiceLayer/SlAisoneERP/SlWUserProfile.dart';
import '../UserWidgets/Labels/Ulabels.dart';
import '../UserWidgets/TextFields/UWTxtString.dart';

class vi_login extends StatefulWidget {
  const vi_login({key}) : super(key: key);

  @override
  State<vi_login> createState() => _vi_loginState();
}

class _vi_loginState extends State<vi_login> {
  @override



  //#region Decleration

  //LoginButton
  bool G_LoadingButtonReset = true;

  //Eyebutton
  bool G_isSecurePassword = true;

  //Forcheckbox
  bool G_isChecked = false;

  //DB
  late Box G_DBbox;

  //UWWidgets
  UWTxtString G_UWEmail = new UWTxtString();
  TextEditingController G_TxtPass = new TextEditingController();

  ULabels lblLogin = new ULabels();
  ULabels lblcredentials = new ULabels();
  ULabels lblAppmode = new ULabels();

  String G_deviceTokenToSendPushNotification = "";
  var G_Connection_subscription;
  String G_InternetConnectionStatus = "Offline";

  final RoundedLoadingButtonController G_Loginloading_Button =
      RoundedLoadingButtonController();

//#endregion

  //#region States
  void initState() {
    super.initState();

    FncstartupSettings();
    FncFirebaseNotification();
    FncCheckDeviceInternetContineous();
    Fnc_CreateDBBox();

    //InitiatePerameters
    G_LoadingButtonReset = true;
    G_Loginloading_Button.reset();
    G_Loginloading_Button.stateStream.listen((value) {
      print(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    G_Connection_subscription.cancel();
  }

//#endregion

  //===========================================Implementations==============================

  //#region UI Widgets Class
  @override
  Widget build(BuildContext context) {
    //Check keyboard is open
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    FncgetDeviceTokenToSendNotification();

    //#region Widgets

    Widget togglepassword() {
      return IconButton(
        onPressed: () {
          setState(() {
            G_isSecurePassword = !G_isSecurePassword;
          });
        },
        icon: G_isSecurePassword
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off),
        color: Colors.indigo,
      );
    }

    Widget _WidgetportraitMode(double Pr_height, Pr_width) {
      return Scaffold(
        body: Container(
          height: Pr_height,
          width: Pr_width,
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
          //color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          // we use child container property and used most important property column that accepts multiple widgets

          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 500,
                ),
                Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.150),
                    child: Center(
                      child: Image.asset(
                        "assets/aisonr.png",
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: Pr_height * 0.350),
                    child: Center(child: lblLogin)),
                Container(
                  margin: EdgeInsets.only(top: Pr_height * 0.400),
                  child: Center(child: lblcredentials),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.450),
                  child: Center(
                    child: SizedBox(
                      width: Pr_width * .890,
                      child: Visibility(child: G_UWEmail),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.525),
                  child: Divider(
                    endIndent: 79,
                    indent: 79,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.550),
                  child: Center(
                    child: SizedBox(
                      width: Pr_width * .890,
                      child: TextFormField(
                        obscureText: G_isSecurePassword,
                        controller: G_TxtPass,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(color: Colors.black26),
                          labelText: ' Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: Colors.white38)),
                          prefixIcon: const Icon(MdiIcons.fingerprint,
                              size: 20, color: Colors.indigo),
                          suffixIcon: togglepassword(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.625),
                  child: Divider(
                    endIndent: 79,
                    indent: 79,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.650),
                  child: Center(child: Text("Remember me")),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Pr_height * 0.631, left: Pr_width * .570),
                  child: Checkbox(
                      value: G_isChecked,
                      onChanged: (value) {
                        G_isChecked = !G_isChecked;
                        setState(() {});
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.680),
                  child: Divider(
                    endIndent: 120,
                    indent: 120,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pr_height * 0.710),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      child: RoundedLoadingButton(
                          elevation: 5.0,
                          borderRadius: 5,
                          resetAfterDuration: G_LoadingButtonReset,
                          resetDuration: Duration(seconds: 3),
                          child: Text('Login',
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      letterSpacing: .5))),
                          controller: G_Loginloading_Button,
                          onPressed: () {
                            FncOnTap();
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _WidgetlandscapeMode(double Pr_height, Pr_width) {
      return Scaffold(
        body: Container(
          height: Pr_height,
          width: Pr_width,
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
          //color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          // we use child container property and used most important property column that accepts multiple widgets

          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              physics: !keyboardIsOpen
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 500,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: Pr_height * 0.290, left: Pr_width * 0.1),
                      child: SizedBox(
                          child: Image.asset(
                        "assets/aisonr.png",
                        width: 150,
                        fit: BoxFit.cover,
                      ))),
                  Padding(
                      padding: EdgeInsets.only(
                          top: Pr_height * 0.100, left: Pr_width * 0.600),
                      child: lblLogin),
                  Padding(
                      padding: EdgeInsets.only(
                          top: Pr_height * 0.200, left: Pr_width * 0.550),
                      child: lblcredentials),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Pr_height * 0.320, left: Pr_width * 0.390),
                    child: SizedBox(
                      width: Pr_width * .890,
                      child: Visibility(child: G_UWEmail),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Pr_height * 0.460, left: Pr_width * 0.390),
                    child: Divider(
                      endIndent: 79,
                      indent: 79,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Pr_height * 0.500, left: Pr_width * 0.390),
                    child: SizedBox(
                      width: Pr_width * .890,
                      child: TextFormField(
                        obscureText: G_isSecurePassword,
                        controller: G_TxtPass,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(color: Colors.black26),
                          labelText: ' Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: Colors.white38)),
                          prefixIcon: const Icon(MdiIcons.fingerprint,
                              size: 20, color: Colors.indigo),
                          suffixIcon: togglepassword(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Pr_height * 0.640, left: Pr_width * 0.390),
                    child: Divider(
                      endIndent: 79,
                      indent: 79,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Pr_height * 0.710, left: Pr_width * 0.600),
                    child: Text("Remember me"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Pr_height * 0.675, left: Pr_width * 0.730),
                    child: Checkbox(
                        value: G_isChecked,
                        onChanged: (value) {
                          G_isChecked = !G_isChecked;
                          setState(() {});
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Pr_height * 0.760, left: Pr_width * 0.390),
                    child: Divider(
                      endIndent: 120,
                      indent: 120,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Pr_height * 0.790, left: Pr_width * 0.550),
                    child: SizedBox(
                      width: 200,
                      child: RoundedLoadingButton(
                          elevation: 5.0,
                          borderRadius: 5,
                          resetAfterDuration: G_LoadingButtonReset,
                          resetDuration: Duration(seconds: 3),
                          child: Text('Login',
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      letterSpacing: .5))),
                          controller: G_Loginloading_Button,
                          onPressed: () {
                            FncOnTap();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
//#endregion
// =============================================

      return GestureDetector(
        onTap: () {
          //when tap anywhere on screen keyboard dismiss
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                //Get device's screen height and width.
                double height = constraints.maxHeight;
                double width = constraints.maxWidth;

                if (width >= 300 && width < 500) {
                  return _WidgetportraitMode(height, width);
                } else {
                  return _WidgetlandscapeMode(height, width);
                }
              },
            );
          },
        ),
      );
  }

//#endregion

  //===========================================DartCode=====================================

  //#region Startup
  void FncstartupSettings() {
    //TextFields
    G_UWEmail.TxtHintText = "Enter Email";
    G_UWEmail.labelText = "Email";

    //Labels
    lblLogin.TxtText = "Login";
    lblLogin.TxtFontSize = 30;
    lblLogin.color = Colors.black38;

    lblcredentials.TxtText = "Please Enter Your Credentials";
    lblcredentials.TxtFontSize = 12;
    lblcredentials.color = Colors.black38;

    lblAppmode.TxtText = "Application Mode";
    lblAppmode.TxtFontSize = 30;
    lblAppmode.color = Colors.black38;
  }

  void FncFirebaseNotification() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);

        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  void FncCheckDeviceInternetContineous() {
    G_Connection_subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult l_result) {
      if (l_result == ConnectivityResult.none) {
        setState(() {
          G_InternetConnectionStatus = "Offline";
          Get.snackbar("Network", "Device is Offline Check Your Internet");

          print(G_InternetConnectionStatus);
        });
      } else {
        G_InternetConnectionStatus = "Online";
        Get.snackbar("Network", "Device is Online");
        print(G_InternetConnectionStatus);
      }
    });
  }

//#endregion

  //#region Events

  FncOnTap() async {
//==================Validations

    if (await FncCheckWifiMobileNetwork() == true) {
      if (await FncCheckInternetAvailible() == true) {
        print("InternetDOne");
        Fnc_LoginfromDB();
        void _doSomething(RoundedLoadingButtonController controller) async {
          Timer(Duration(seconds: 3), () async {
            controller.reset();
            if (Fnc_ValidateLogin() == false) {
              G_LoadingButtonReset = false;
            } else {
              G_LoadingButtonReset = false;

              if (await Fnc_WValidateUser() == true) {
                if (await Fnc_OnlineProcedures() == true) {
                  Get.to(() => const vi_CompanyLIst());
                }
              } else {
                Get.snackbar("ALERT", "Login Failed ");
              }
            }
          });
        }

        if (Fnc_ValidateLogin() == false) {
          return;
        }

        if (await Fnc_WValidateUser() == true) {
          if (await Fnc_OnlineProcedures() == true) {
            Get.to(() => const vi_CompanyLIst());
            //Get.to(() => const Test());
          }
        }
      }
    }
  }

//#endregion

  //#region Validations
  bool Fnc_ValidateLogin() {
    if (G_UWEmail.txtController.text.isEmpty == true) {
      Get.snackbar("ALERT", "Email is required ");
      return false;
    }

    if (G_TxtPass.text.isEmpty == true) {
      Get.snackbar("ALERT", "Password is required ");
      return false;
    }

    return true;
  }

  Future<bool> Fnc_WValidateUser() async {
    ModUserProfile? l_ModUserProfile = await new SlwUserLogin().Fnc_UserProfile(
        G_UWEmail.txtController.text.toString(), G_TxtPass.text.toString());
    if (l_ModUserProfile == null) {
      Get.snackbar("Alert", "Invalid Login Information");
      return false;
    }
    cmGlobalVariables.Pb_UserDID = l_ModUserProfile.Pr_PKGUID;
    cmGlobalVariables.Pb_UserName = l_ModUserProfile.Pr_FullName;
    cmGlobalVariables.Pb_UserEmail = l_ModUserProfile.Pr_EmailID;
    cmGlobalVariables.Pb_UserNumber = l_ModUserProfile.Pr_ContactNo;
    cmGlobalVariables.Pb_UserImage = l_ModUserProfile.Pr_Image;
    Get.snackbar("Alert", "Login Successful");
    return true;
  }

//#endregion

  //#region Methods
  Future<bool> Fnc_OnlineProcedures() async {
    List<ModCompanySettingQuery>? l_list_CompanyList =
        new List<ModCompanySettingQuery>.empty(growable: true);

    l_list_CompanyList = await new SlwLogin().WLogin_Api_Call(
        G_UWEmail.txtController.text.toString(), G_TxtPass.text.toString());

    if (l_list_CompanyList == null) {
      Get.snackbar("Alert", "Invalid Login Information");
      return false;
    }
    RxList<ModCompanySettingQuery>? l_Rxlist_CompanyList =
        <ModCompanySettingQuery>[].obs;
    l_Rxlist_CompanyList.addAll(l_list_CompanyList);
    //Put that list to an container
    cmGlobalVariables.PbCompanySettingQuery.addAll(l_list_CompanyList);

    Get.put(l_Rxlist_CompanyList, tag: "l_ListCompanyList");

    return true;
  }

  void Fnc_CreateDBBox() async {
    G_DBbox = await Hive.openBox("name");
    FncStoreDataDBBox();
  }

  void FncStoreDataDBBox() {
    if (G_DBbox.get('txtEmail') != null) {
      G_UWEmail.txtController.text = G_DBbox.get('txtEmail');
      G_isChecked = true;
    }
    ;

    if (G_DBbox.get('txtPass') != null) {
      G_TxtPass.text = G_DBbox.get('txtPass');
      G_isChecked = true;
    }
    ;
  }

  void Fnc_LoginfromDB() {
    if (G_isChecked) {
      G_DBbox.put('txtEmail', G_UWEmail.txtController.text);
      G_DBbox.put('txtPass', G_TxtPass.text);
    }
  }

  Future<bool?> FncCheckInternetAvailible() async {
    bool l_internetResponse = await InternetConnectionChecker().hasConnection;

    if (l_internetResponse == false) {
      print("Your Network has No Internet");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          action: SnackBarAction(
            label: "",
            onPressed: () {},
          ),
          content: const Text(
            'Your Network has No Internet',
            style: TextStyle(color: Colors.black87),
          ),
          duration: const Duration(milliseconds: 2550),
          width: 280.0,
          // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0, // Inner padding for SnackBar content.
          ),

          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

      return l_internetResponse;
    }
    return l_internetResponse;
  }

  Future<bool> FncCheckWifiMobileNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print("I am connected to a mobile network");

      Get.snackbar("Network Alert", "Device is Connected With Mobile Network");

      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      Get.snackbar("Network Alert", "Device is Connected With WiFi ");
      print("I am connected to a Wifi network");

      return true;
    } else {
      Get.snackbar("Network Error", "Connect WiFi Or Mobile Data ");
      print("No Internet");
      return false;
    }

    return true;
  }

  Future<void> FncgetDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    G_deviceTokenToSendPushNotification = token.toString();
    print("Token Value $G_deviceTokenToSendPushNotification");
  }

//#endregion

}
