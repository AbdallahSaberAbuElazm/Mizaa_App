import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/build_intro_text.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
as translation;

class OTPVerifyScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String routeName;

  const OTPVerifyScreen({required this.data, required this.routeName});

  @override
  _OTPVerifyScreenState createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  bool enableResendBtn = false;
  //var autoFill;
  late FocusNode myFocusNode;
  bool isAPIcallProcess = false;
  final _fomrKey = GlobalKey<FormState>();
  var autoFill;
  CountdownController countdownController = CountdownController();
  final UserAuthenticationController userAuthenticationController = Get.find();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();

    SmsAutoFill().listenForCode.call();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
              backgroundColor:Get.isDarkMode? ColorConstants.darkMainColor:   Colors.white,
              body: Form(
                  key: _fomrKey,
                  child: Container(
                      alignment: Alignment.topRight,
                      margin:
                          const EdgeInsets.only(top: 35, right: 16, left: 16),
                      child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Utils.buildLogo(),
                            const SizedBox(height: 22),
                             BuildIntroText(
                              headerText: translation.confirmPhoneNumber.tr,
                            ),
                            const SizedBox(height: 40),
                             Text(
                               translation.typeCodeReceived.tr,
                              style:  TextStyle(
                                  fontSize: 15,
                                  color: Get.isDarkMode? Colors.white:Colors.black,
                                  fontFamily: 'Noto Kufi Arabic'),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.data['mobileNo']}',
                                  style:  TextStyle(
                                      fontSize: 18,
                                      color: Get.isDarkMode? Colors.white:Colors.black,
                                      fontFamily: 'Noto Kufi Arabic'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      if(widget.routeName == 'recover'){
                                        Get.offNamed('/recovery');
                                      }else if (widget.routeName == 'register'){
                                        Get.offNamed('/register');
                                      }

                                    },
                                    child:  Text(
                                      translation.editText.tr,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: ColorConstants.mainColor),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            PinCodeTextField(
                              length: 6,
                              obscureText: false,
                              autoFocus: true,
                              cursorColor:Get.isDarkMode? Colors.white: Colors.black,
                              keyboardType: TextInputType.number,
                              animationType: AnimationType.scale,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(8),
                                fieldHeight: 60,
                                fieldWidth: 50,
                                activeFillColor:
                                    ColorConstants.btnBackgroundGrey,
                                activeColor: ColorConstants.btnBackgroundGrey,
                                inactiveColor: ColorConstants.btnBackgroundGrey,
                                inactiveFillColor: Colors.white,
                                selectedColor: ColorConstants.btnBackgroundGrey,
                                selectedFillColor: Colors.white,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              // backgroundColor: Colors.blue.shade50,
                              enableActiveFill: true,
                              // errorAnimationController: errorController,
                              // controller: textEditingController,
                              onCompleted: (v) {
                                  userAuthenticationController
                                      .otpController.value = v;
                                print("Completed $v");
                              },
                              onChanged: (value) {
                                userAuthenticationController
                                    .otpController.value = value;
                              },
                              appContext: context,
                            ),
                            const SizedBox(height: 30),
                            Obx(
                              () => CustomButton(
                                  btnText:translation.activateConfirmation.tr,
                                  textColor: Colors.white,
                                  textSize: 17,
                                  btnBackgroundColor: ColorConstants.mainColor,
                                  btnOnpressed: (userAuthenticationController
                                              .otpController.value.length ==
                                          6)
                                      ? () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: ColorConstants
                                                        .mainColor,
                                                  )));
                                          if (widget.routeName == 'recover') {
                                            userAuthenticationController
                                                .recoverPasswordOtp(
                                                    password:
                                                        widget.data['password'],
                                                    mobileNo:
                                                        widget.data['mobileNo'],
                                                    otp: userAuthenticationController.otpController.value,
                                                    context: context);
                                          } else if (widget.routeName ==
                                              'register') {
                                            userAuthenticationController
                                                .registerOtp(
                                                    mobileNo:
                                                        widget.data['mobileNo'],
                                                    firstName: widget
                                                        .data['firstName'],
                                                    password:
                                                        widget.data['password'],context: context,
                                                    otpCode: userAuthenticationController.otpController.value);
                                          }
                                        }
                                      : null),
                            ),
                            const SizedBox(height: 30),
                            // countDown(),
                          ])))),
    );
  }

  Widget countDown() {
    return Countdown(
      controller: countdownController,
      seconds: 15,
      interval: const Duration(milliseconds: 1000),
      build: (context, currentRemainingTime) {
        if (currentRemainingTime == 0.0) {
          return GestureDetector(
              onTap: () {
                // write logic here to resend OTP
              },
              child: Center(
                  child: Text(
                   translation.resendCode.tr,
                style: Theme.of(context).textTheme.subtitle1,
              )));
        } else {
          return Center(
            child: Text(
                "انتظر  |  ${currentRemainingTime.toString().length == 4 ? " ${currentRemainingTime.toString().substring(0, 2)}" : " ${currentRemainingTime.toString().substring(0, 1)}"}",
                style: Theme.of(context).textTheme.subtitle1),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    myFocusNode.dispose();
    super.dispose();
  }
}

class CodeAutoFillTestPage extends StatefulWidget {
  @override
  _CodeAutoFillTestPageState createState() => _CodeAutoFillTestPageState();
}

class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage>
    with CodeAutoFill {
  String? appSignature;
  String? otpCode;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listening for code"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              "This is the current app signature: $appSignature",
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Builder(
              builder: (_) {
                if (otpCode == null) {
                  return Text("Listening for code...", style: textStyle);
                }
                return Text("Code Received: $otpCode", style: textStyle);
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
