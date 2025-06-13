import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/common_textfield_widget.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In To Your\nAccount',
                style: GoogleFonts.inter(
                    fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "We're so excited to see you again",
                style: GoogleFonts.inter(
                    fontSize: 12, color: ColorConstant.secondaryDark),
              ),
              const SizedBox(height: 30),

              _titleText(title: 'Email'),
              const SizedBox(height: 12),
              CustomTextField(
                  controller: _emailController, hint: "Email Address"),
              const SizedBox(height: 10),

              _titleText(title: "Password"),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _passwordController,
                hint: "Password",
                obscureText: obscurePassword,
                toggleObscure: () =>
                    setState(() => obscurePassword = !obscurePassword),
              ),

              // Forgot Password
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Forget Password?",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorConstant.accentMintGeenColor,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),

              const SizedBox(height: 64),
              CommonSubmitButton(
                  child: Text(
                    'Continue',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {}),

              const SizedBox(height: 30),
              _buildOrDivider(),

              const SizedBox(height: 30),
              _buildSocialButton(
                iconAsset: Assets.svgs.facebookLogo,
                text: 'Continue with Facebook',
                backgroundColor: ColorConstant.buttonGradient1Color,
                iconColor: ColorConstant.whiteColor,
                textColor: ColorConstant.whiteColor,
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                iconAsset: Assets.svgs.googleLogo,
                text: 'Continue with Google',
                backgroundColor: ColorConstant.whiteColor,
                iconColor: ColorConstant.blackColor,
                textColor: ColorConstant.blackColor,
              ),

              const SizedBox(height: 40),
              Center(child: _buildFooterText(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: ColorConstant.offWhite)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'or continue with',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: ColorConstant.white60Color),
          ),
        ),
        const Expanded(child: Divider(color: ColorConstant.white60Color)),
      ],
    );
  }

  Widget _buildSocialButton({
    IconData? icon,
    String? iconAsset,
    required String text,
    required Color backgroundColor,
    required Color iconColor,
    required Color textColor,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconAsset != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.5),
                  child: SvgPicture.asset(
                    iconAsset,
                    height: 24,
                    width: 24,
                  ),
                )
              : Icon(icon, color: iconColor),
          Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w400, fontSize: 16),
          ),
          SizedBox(
            height: 24,
            width: 24,
          )
        ],
      ),
    );
  }

  Widget _buildFooterText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "Don’t have an account? ",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ColorConstant.whiteColor, fontSize: 14),
          ),
          TextSpan(
            text: 'Sign Up',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff77C2BA),
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context)
                    .pushNamed(AppRoutes.REGISTER_SCREEN_ROUTE_NAME);
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _titleText({required String title}) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: ColorConstant.offWhite),
    );
  }
}
