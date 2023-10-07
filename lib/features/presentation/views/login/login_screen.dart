import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/functions/app_dialogs.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../../../core/utils/thems/my_colors.dart';
import '../../components/default_button.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  late String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          navigateAndRemove(context, Routes.otpRoute, arguments: phoneNumber);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(

          backgroundColor: AppColorss.primaryColor,
          //appBar: const LoginAppBar(),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Lottie.asset("assets/images/telephone.json", width: 160, repeat: false),
                  Text(
                      "Your Phone",
                    style: TextStyle(color:AppColorss.textColor1, fontSize: 28),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    "Please confirm your country code\nand enter your phone number.",
                    style: TextStyle(color:AppColorss.textColor2, fontWeight: FontWeight.normal, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: context.width(0.7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    countryListTheme: CountryListThemeData(
                                      bottomSheetHeight: 500,
                                      backgroundColor: AppColorss.thirdColor,
                                      textStyle:  TextStyle(color: AppColorss.textColor1),
                                      searchTextStyle:  TextStyle(color: AppColorss.textColor1),
                                      inputDecoration:  InputDecoration(
                                        iconColor: AppColorss.iconsColors,
                                        icon: const Icon(Icons.search),
                                        hintText: "Search",
                                        hintStyle: TextStyle(color: AppColorss.textColor2)
                                      )
                                    ),
                                    context: context,
                                    showPhoneCode: true,
                                    onSelect: (myCountry) {
                                      cubit.setCountry(myCountry);
                                      countryCodeController.text =
                                          cubit.country!.phoneCode;
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                                  decoration: BoxDecoration(
                                    color: AppColorss.thirdColor,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                              
                                  child: Text(
                                    cubit.country == null
                                        ? "Choose a country"
                                        : "${cubit.country!.flagEmoji} ${cubit.country!.name}",
                                    textAlign: TextAlign.start,
                                    style: context.displaySmall!.copyWith(color:AppColorss.myMessageColor, fontWeight: FontWeight.normal, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: (){
                            //     showCountryPicker(
                            //       context: context,
                            //       showPhoneCode: true,
                            //       onSelect: (myCountry) {
                            //         cubit.setCountry(myCountry);
                            //         countryCodeController.text =
                            //             cubit.country!.phoneCode;
                            //       },
                            //     );
                            //   },
                            //   child: const Icon(
                            //     Icons.arrow_drop_down,
                            //     color: Colors.white,
                            //     size: AppSize.s28,
                            //   ),
                            // ),
                          ],
                        ),
                       // const SizedBox(height: 10),
                        // Divider(
                        //   height: 0,
                        //   thickness: 0.2,
                        //   color: AppColorss.dividersColor,
                        // ),
                        const SizedBox(height: 10),
                        Container(
                          height: 52,
                          padding: const EdgeInsets.only(left: 15,right: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: AppColorss.thirdColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                         
                          child: Row(
                            children: [
                              SizedBox(
                                width: AppSize.s60,
                                child: TextField(
                                  enabled: true,
                                  keyboardAppearance: Brightness.dark,
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                  controller: countryCodeController,
                                  style:  TextStyle(color: AppColorss.textColor1, fontSize: 18),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    prefix: Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      width: 5,
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '+',
                                        style: context.titleLarge!.copyWith(
                                            color: AppColorss.textColor1,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   width: 2,
                              // ),
                              Container(
                                child: const SizedBox(child: Text(" "),),
                                color: AppColorss.textColor1.withOpacity(0.5),
                                height: 30,
                                width: 0.4,
                              ),
                              const SizedBox(width: 7),

                              Expanded(
                                child: TextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Colors.white70,
                                  cursorHeight: 20,
                                  style:  TextStyle(color: AppColorss.textColor1, fontSize: 18, height: 1.2),
                                  decoration:  InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText:  "Your Phone Number ",
                                    hintStyle: TextStyle(color: AppColorss.textColor2)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  DefaultButton(
                    text: "Continue",
                    onPress: ()  {
                      if (phoneController.text.isNotEmpty &&
                          countryCodeController.text.isNotEmpty) {
                        String number = phoneController.text.trim();
                        phoneNumber = '+${countryCodeController.text}$number';
                        AppDialogs.submitPhoneDialog(
                          context: context,
                          phoneNumber:
                              '+${countryCodeController.text} ${phoneController.text}',
                          okPressed: () {
                            navigatePop(context);
                            cubit.signInWithPhoneNumber(
                                phoneNumber: phoneNumber,);
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    countryCodeController.dispose();
  }
}
