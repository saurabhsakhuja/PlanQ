import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plan_q/src/core/common/widgets/common_submit_button.dart';
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
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isMet ? Colors.cyanAccent : Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBar(
          backgroundColor: ColorConstant.backgroundColor,
          leading: BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
               Text(
                'Register New Account',
                style: TextStyle(
                    color: ColorConstant.whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fill the information to complete the registration',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 24),

              // Full Name
              const Text("Full name", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 6),
              _buildTextField(_fullNameController, "Full Name"),

              const SizedBox(height: 16),

              // Email
              const Text("Email", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 6),
              _buildTextField(_emailController, "Email Address"),

              const SizedBox(height: 16),

              // Password
              const Text("Password", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 6),
              _buildTextField(
                _passwordController,
                "Password",
                obscureText: obscurePassword,
                toggleObscure: () =>
                    setState(() => obscurePassword = !obscurePassword),
                onChanged: validatePassword,
              ),
              //Secure password indicators bars
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildPasswordBar(hasSpecialCharacter),
                  _buildPasswordBar(hasNumber),
                  _buildPasswordBar(hasMinLength),
                  _buildPasswordBar(hasUppercase),
                ],
              ),
              const SizedBox(height: 8),
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
              const Text("Confirm Password",
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 6),
              _buildTextField(
                _confirmPasswordController,
                "Confirm Password",
                obscureText: obscureConfirmPassword,
                toggleObscure: () => setState(
                    () => obscureConfirmPassword = !obscureConfirmPassword),
              ),

              const SizedBox(height: 30),

              // Create Account Button
              CommonSubmitButton(text: 'Create Account', onPressed: () {}),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.white70),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: const TextStyle(color: Colors.cyanAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to sign in
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool obscureText = false,
      void Function()? toggleObscure,
      void Function(String)? onChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white60),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          suffixIcon: toggleObscure != null
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white60,
                  ),
                  onPressed: toggleObscure,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildPasswordBar(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isActive ? Colors.purpleAccent : Colors.white10,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
