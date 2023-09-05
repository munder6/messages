import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:message_me_app/core/utils/thems/my_colors.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccessState) {
          navigateAndRemove(context, Routes.loginProfileInfoRoute);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: AppColorss.primaryColor,
          //appBar: const LoginAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Column(
              children: [
                Lottie.asset("assets/images/otp.json", width: 150, repeat: false),
                Text(
                  "Enter Code",
                  style: TextStyle(color: AppColorss.textColor1,fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                    "We've sent an SMS with an activation code to\nyour phone ${widget.phoneNumber}",
                  style:  TextStyle(color: AppColorss.textColor2, fontSize: 17, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OtpTextField(
                    cursorColor: AppColorss.textColor1,
                    textStyle:
                    TextStyle
                      (color: AppColorss.textColor1,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Default',
                        fontSize: 18
                    ),
                    fieldWidth: 50,
                    disabledBorderColor: Colors.grey[900]!,
                    filled: true,
                    fillColor: AppColorss.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    enabledBorderColor: Colors.grey[900]!,
                    numberOfFields: 6,
                    borderColor:  Colors.grey[900]!,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String value){
                      cubit.verifyOtp(smsOtpCode: value.trim());
                    }, // end onSubmit
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p18),
                  child: Text(
                    AppStrings.enter6DigitCode,
                    style: context.bodySmall!.copyWith(color: AppColorss.textColor2),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Icon(
                    //   Icons.message,
                    //   color: Colors.grey,
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                    // const Text(
                    //   AppStrings.resendSms,
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //   ),
                    // ),
                   // const Spacer(),
                    TweenAnimationBuilder(
                      tween: Tween(begin: 60.0, end: 0),
                      duration: const Duration(seconds: 60),
                      builder: (context, value, child) => Text(
                        '00:${value.toInt()}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onEnd: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
