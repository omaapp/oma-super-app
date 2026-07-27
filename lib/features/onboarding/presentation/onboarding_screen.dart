import 'package:flutter/material.dart';

import '../../auth/presentation/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController controller = PageController();

  int page = 0;

  final pages = const [
    (
      icon: Icons.local_taxi,
      title: "اطلب رحلتك بسهولة",
      subtitle: "احجز سيارة أو تكتك خلال ثوانٍ."
    ),
    (
      icon: Icons.location_searching,
      title: "تتبع السائق",
      subtitle: "تابع السائق لحظة بلحظة."
    ),
    (
      icon: Icons.verified_user,
      title: "رحلة آمنة",
      subtitle: "استمتع برحلة سريعة وآمنة."
    ),
  ];

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 10,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: const Text("تخطي"),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    page = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = pages[index];

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/branding/logo.png",
                          width: 110,
                        ),

                        const SizedBox(height: 35),

                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xff1565C0,
                            ).withOpacity(.08),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item.icon,
                            size: 90,
                            color: const Color(
                              0xff1565C0,
                            ),
                          ),
                        ),

                        const SizedBox(height: 45),

                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          item.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) {
                  final selected = page == index;

                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: selected ? 26 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xff1565C0)
                          : Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                0,
                24,
                30,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  icon: Icon(
                    page == pages.length - 1
                        ? Icons.check_circle
                        : Icons.arrow_forward,
                  ),
                  label: Text(
                    page == pages.length - 1
                        ? "ابدأ الآن"
                        : "التالي",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (page < pages.length - 1) {
                      controller.nextPage(
                        duration: const Duration(
                          milliseconds: 350,
                        ),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _finishOnboarding();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}