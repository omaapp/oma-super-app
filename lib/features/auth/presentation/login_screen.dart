import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/fade_slide.dart';
import '../data/auth_repository.dart';
import 'otp_screen.dart';

import 'widgets/login_button.dart';
import 'widgets/login_card.dart';
import 'widgets/login_logo.dart';
import 'widgets/phone_input.dart';
import 'widgets/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController =
      TextEditingController();

  final AuthRepository repository = AuthRepository();

  bool loading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
    final phoneNumber = phoneController.text.trim();

    if (phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("أدخل رقم هاتف صحيح"),
        ),
      );
      return;
    }

    final phone = "+964$phoneNumber";

    setState(() => loading = true);

    await repository.sendOtp(
      phone: phone,
      onCodeSent: (verificationId) {
        if (!mounted) return;

        setState(() => loading = false);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              verificationId: verificationId,
              phone: phone,
            ),
          ),
        );
      },
      onError: (message) {
        if (!mounted) return;

        setState(() => loading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      },
    );
  }

  void _showComingSoon(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "تسجيل الدخول بواسطة $provider قريباً",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryDark,
              AppColors.primary,
              AppColors.primaryLight,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(
              AppSpacing.lg,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),

                const FadeSlide(
                  delay: Duration(
                    milliseconds: 100,
                  ),
                  child: LoginLogo(),
                ),

                const SizedBox(
                  height: 40,
                ),

                FadeSlide(
                  delay: const Duration(
                    milliseconds: 350,
                  ),
                  child: LoginCard(
                    phoneField: PhoneInput(
                      controller: phoneController,
                    ),

                    continueButton: LoginButton(
                      loading: loading,
                      onPressed: sendOtp,
                    ),

                    googleButton: GoogleLoginButton(
                      onPressed: () =>
                          _showComingSoon("Google"),
                    ),

                    appleButton: AppleLoginButton(
                      onPressed: () =>
                          _showComingSoon("Apple"),
                    ),

                    guestButton: GuestButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.home,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.xl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
