import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_q/gen/assets.gen.dart';
import 'package:plan_q/src/core/common/app_textstyles.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
import 'package:plan_q/src/core/common/widgets/common_textfield_widget.dart';
import 'package:plan_q/src/core/constants/app_routes.dart';
import 'package:plan_q/src/core/constants/color_constant.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // Password rules
  bool hasSpecialCharacter = false;
  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  void validatePassword(String value) {
    setState(() {
      hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
      hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
      hasNumber = RegExp(r'[0-9]').hasMatch(value);
      hasMinLength = value.length >= 8;
    });
  }

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            isMet
                ? Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff77C2BA)),
                    child: Assets.images.check.image(scale: 4),
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Color(0xffBFBFBF),
                    size: 18,
                  ),
            const SizedBox(width: 8),
            Text(text,
                style:
                    GoogleFonts.inter(color: Color(0xffBFBFBF), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBar(
          backgroundColor: ColorConstant.backgroundColor,
          leading: BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register New Account',
                  style: GoogleFonts.inter(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fill the information to complete the registration',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: ColorConstant.secondaryDark),
                ),
                const SizedBox(height: 30),

                // Full Name
                _titleText(title: 'Full name'),
                const SizedBox(height: 12),
                CustomTextField(
                    controller: _fullNameController, hint: "Full Name"),

                const SizedBox(height: 10),

                // Email
                _titleText(title: 'Email'),
                const SizedBox(height: 12),
                CustomTextField(
                    controller: _emailController, hint: "Email Address"),

                const SizedBox(height: 10),

                // Password
                _titleText(title: "Password"),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: _passwordController,
                  hint: "Password",
                  obscureText: obscurePassword,
                  toggleObscure: () =>
                      setState(() => obscurePassword = !obscurePassword),
                  onChanged: validatePassword,
                ),
                //Secure password indicators bars
                const SizedBox(height: 10),
                Row(
                  children: List.generate(4, (index) {
                    return _buildPasswordBar(
                        index < _getPasswordStrengthLevel());
                  }),
                ),

                const SizedBox(height: 10),
                //Secure password indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPasswordRequirement(
                        "Special character", hasSpecialCharacter),
                    _buildPasswordRequirement("At least a number", hasNumber),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPasswordRequirement(
                        "Al least 8 characters", hasMinLength),
                    _buildPasswordRequirement(
                        "Uppercase character", hasUppercase),
                  ],
                ),
                const SizedBox(height: 16),

                // Confirm Password
                _titleText(title: "Confirm Password"),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hint: "Confirm Password",
                  obscureText: obscureConfirmPassword,
                  toggleObscure: () => setState(
                      () => obscureConfirmPassword = !obscureConfirmPassword),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: ColoredBox(
          color: ColorConstant.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Create Account Button
                CommonSubmitButton(
                    child: Text(
                      'Create Account',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {}),
                const SizedBox(height: 20),
                Center(child: _buildFooterText(context)),
                SizedBox(height: 26)
              ],
            ),
          ),
        ),
      ),
    );
  }

//to check there's any password strength level match
  int _getPasswordStrengthLevel() {
    int strength = 0;
    if (hasSpecialCharacter) strength++;
    if (hasNumber) strength++;
    if (hasMinLength) strength++;
    if (hasUppercase) strength++;
    return strength;
  }

  //Footer sign In option
  Widget _buildFooterText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "Already have an account? ",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: 'Sign In',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xff77C2BA),
            ),
            onEnter: (event) {},
            onExit: (event) {},
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context)
                    .pushNamed(AppRoutes.LOGIN_SCREEN_ROUTE_NAME);
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

// //Textfield to fill form fields
//   Widget _buildTextField(TextEditingController controller, String hint,
//       {bool obscureText = false,
//       void Function()? toggleObscure,
//       void Function(String)? onChanged}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: ColorConstant.textFieldBg,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         onChanged: onChanged,
//         cursorColor: Colors.white,
//         style: Theme.of(context)
//             .textTheme
//             .bodyMedium
//             ?.copyWith(color: ColorConstant.whiteColor),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: ColorConstant.offWhite),
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//           suffixIcon: toggleObscure != null
//               ? InkWell(
//                   onTap: toggleObscure,
//                   child: obscureText
//                       ? Assets.images.visibilityOffIcon.image(scale: 3)
//                       : Icon(
//                           Icons.visibility,
//                           color: ColorConstant.whiteColor,
//                         ),
//                 )
//               : null,
//         ),
//       ),
//     );
//   }

//Strong Password Indicator bar
  Widget _buildPasswordBar(bool isActive) {
    return Expanded(
      child: Container(
        height: 5,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isActive
                ? [
                    ColorConstant.buttonGradient1Color,
                    ColorConstant.buttonGradient2Color,
                  ]
                : [
                    ColorConstant.buttonGradient1Color.withOpacity(.2),
                    ColorConstant.buttonGradient2Color.withOpacity(.2)
                  ],
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

//Text Field Title
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
