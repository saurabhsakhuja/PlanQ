import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
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
              const SizedBox(height: 10),
              Text(
                'Sign In To Your\nAccount',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "We're so excited to see you again",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorConstant.secondaryDark),
              ),
              const SizedBox(height: 24),

              _titleText(title: 'Email'),
              const SizedBox(height: 6),
              _buildTextField(_emailController, "Email Address"),
              const SizedBox(height: 16),

              _titleText(title: "Password"),
              const SizedBox(height: 6),
              _buildTextField(
                _passwordController,
                "Password",
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

              const SizedBox(height: 50),
              CommonSubmitButton(
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.titleMedium,
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

              const SizedBox(height: 60),
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
                  padding: const EdgeInsets.only(left: 24),
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
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
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
                ?.copyWith(color: ColorConstant.whiteColor),
          ),
          TextSpan(
            text: 'Sign Up',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.accentMintGeenColor,
                  decoration: TextDecoration.underline,
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

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool obscureText = false,
      void Function()? toggleObscure,
      void Function(String)? onChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.textFieldBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: ColorConstant.whiteColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: ColorConstant.offWhite),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          suffixIcon: toggleObscure != null
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: ColorConstant.whiteColor,
                  ),
                  onPressed: toggleObscure,
                )
              : null,
        ),
      ),
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
