import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/auth_repository.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();

  final AuthRepository repository = AuthRepository();

  bool loading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> sendOtp() async {
    if (phoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("أدخل رقم هاتف صحيح"),
        ),
      );
      return;
    }

    final phone = "+964${phoneController.text}";

    setState(() {
      loading = true;
    });

    await repository.sendOtp(
      phone: phone,
      onCodeSent: (verificationId) {
        if (!mounted) return;

        setState(() {
          loading = false;
        });

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
      onError: (e) {
        if (!mounted) return;

        setState(() {
          loading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xff1565C0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff1565C0),
              Color(0xff1976D2),
              Color(0xff42A5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -60,
                right: -40,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: -40,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.06),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Spacer(),

                    Image.asset(
                      "assets/branding/logo.png",
                      width: 120,
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "OMA",
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Taxi & Tuk Tuk",
                      style: GoogleFonts.cairo(
                        color: Colors.white70,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 40),

                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "تسجيل الدخول",
                            style: GoogleFonts.cairo(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 25),

                          TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              prefixText: "+964 ",
                              hintText: "7xxxxxxxxx",
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              onPressed: loading ? null : sendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(18),
                                ),
                              ),
                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "متابعة",
                                      style: GoogleFonts.cairo(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                child: Text("أو"),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  const Size.fromHeight(55),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.g_mobiledata,
                              size: 35,
                            ),
                            label: const Text("Google"),
                          ),

                          const SizedBox(height: 12),

                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  const Size.fromHeight(55),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.apple),
                            label: const Text("Apple"),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}