import 'package:booking_hotel/business_logic/auth_cubit/auth_cubit.dart';
import 'package:booking_hotel/core/router/app_router_names.dart';
import 'package:booking_hotel/core/styles/colors.dart';
import 'package:booking_hotel/data/models/auth_params/register_param_model.dart';
import 'package:booking_hotel/presentation/widget/custom_button.dart';
import 'package:booking_hotel/presentation/widget/default_text_form_field.dart';
import 'package:booking_hotel/presentation/widget/headline_text.dart';
import 'package:booking_hotel/presentation/widget/medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final confirmPassC = TextEditingController();
  bool hidePass = true;

  final agreedText =
      "By signing up, you agreed with our terms of services and privacy policy";

  final haveAccountText = "Already hav account? ";

  final loginText = "Log in";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        debugPrint("$state");
        if (state is RegisterLoadedState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouterNames.rLoginLayoutRoute,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final auth = AuthCubit.get(context);
        String? err;
        if (state is RegisterLoadingErrorState) {
          err = state.message;
        }
        return Scaffold(
          backgroundColor: AppColor.lightGrey,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadLineText(
                      text: "Sign Up",
                      fontSize: 28.sp,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    MyFormField(
                      controller: nameC,
                      validateText: nameC.text,
                      inputType: TextInputType.text,
                      hintText: "User Name",
                      prefix: Icons.text_fields_outlined,
                      borderRadius: 30.r,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyFormField(
                      controller: emailC,
                      validateText: emailC.text,
                      inputType: TextInputType.emailAddress,
                      hintText: "Email Address",
                      prefix: Icons.email_outlined,
                      borderRadius: 30.r,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyFormField(
                      controller: passC,
                      validateText: "validateText",
                      inputType: TextInputType.text,
                      hintText: "Password",
                      prefix: Icons.password_outlined,
                      isPassword: hidePass,
                      suffix:
                          hidePass ? Icons.visibility_off : Icons.visibility,
                      suffixPressed: () {
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                      borderRadius: 30.r,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyFormField(
                      controller: confirmPassC,
                      validateText: "validateText",
                      inputType: TextInputType.text,
                      hintText: "Confirm Password",
                      prefix: Icons.password_outlined,
                      isPassword: hidePass,
                      suffix:
                          hidePass ? Icons.visibility_off : Icons.visibility,
                      suffixPressed: () {
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                      borderRadius: 30.r,
                    ),
                    err != null
                        ? Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              MediumText(
                                text: err,
                                color: Colors.red,
                              ),
                            ],
                          )
                        : state is RegisterLoadingState
                            ? Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Container(),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyButton(
                      onPressed: () {
                        final name = nameC.text;
                        final email = emailC.text;
                        final pass = passC.text;
                        final confirmPass = confirmPassC.text;
                        final param = RegisterParamModel(
                          name: name,
                          email: email,
                          password: pass,
                          passwordConfirmation: confirmPass,
                        );
                        auth.register(param);
                      },
                      text: "Sign up",
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    MediumText(
                      text: agreedText,
                      color: AppColor.grey,
                      fontSize: 17,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MediumText(
                          text: haveAccountText,
                          color: AppColor.grey,
                          fontSize: 17,
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouterNames.rLoginLayoutRoute,
                            (route) => false,
                          ),
                          child: MediumText(
                            text: loginText,
                            fontSize: 17,
                            color: AppColor.teal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
