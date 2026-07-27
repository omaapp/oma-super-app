import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../customer/home/presentation/customer_main_screen.dart';
import '../data/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../user/data/user_service.dart';
import '../../driver/presentation/driver_home_screen.dart';
import 'select_role_screen.dart';
class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phone;

  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phone,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthRepository _repository = AuthRepository();

  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  bool loading = false;

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  String get code {
    return controllers.map((e) => e.text).join();
  }

  Future<void> verifyOtp() async {
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("أدخل رمز التحقق كاملاً"),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await _repository.verifyOtp(
        verificationId: widget.verificationId,
        code: code,
      );

      if (!mounted) return;

      final uid = FirebaseAuth.instance.currentUser!.uid;

final doc = await UserService.instance.getUser(uid);

String role;

if (doc.exists) {
  role = doc.data()?["role"] ?? "customer";
} else {
  final selectedRole = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => const SelectRoleScreen(),
    ),
  );

  if (selectedRole == null) return;

  role = selectedRole;

  await UserService.instance.createUser(
    role: role,
    phone: FirebaseAuth.instance.currentUser?.phoneNumber ?? "",
  );
}

if (!mounted) return;

if (role == "driver") {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const DriverHomeScreen(),
    ),
    (_) => false,
  );
} else {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const CustomerMainScreen(),
    ),
    (_) => false,
  );
}
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 48,
      child: TextField(
        controller: controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "رمز التحقق",
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Icon(
              Icons.sms,
              size: 80,
              color: Color(0xFF1565C0),
            ),

            const SizedBox(height: 20),

            Text(
              "أدخل رمز التحقق",
              style: GoogleFonts.cairo(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "تم إرسال الرمز إلى",
              style: GoogleFonts.cairo(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              widget.phone,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, otpBox),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: loading ? null : verifyOtp,
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "تأكيد",
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}