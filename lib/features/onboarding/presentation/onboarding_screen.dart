import 'package:flutter/material.dart';

import '../../auth/presentation/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "اطلب رحلتك بسهولة",
      "subtitle": "احجز سيارة أو تكتك خلال ثوانٍ.",
      "image": "assets/onboarding/onboarding_1.png",
    },
    {
      "title": "تتبع السائق",
      "subtitle": "تابع السائق لحظة بلحظة.",
      "image": "assets/onboarding/onboarding_2.png",
    },
    {
      "title": "رحلة آمنة",
      "subtitle": "استمتع برحلة سريعة وآمنة.",
      "image": "assets/onboarding/onboarding_3.png",
    },
  ];

  void finish() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xff1565C0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: finish,
                  child: const Text(
                    "تخطي",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.asset(
                          "assets/branding/logo.png",
                          width: 120,
                        ),

                        const SizedBox(height: 28),

                        AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: currentPage == index ? 1 : 0.92,
                          child: Image.asset(
                            page["image"]!,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 35),

                        Text(
                          page["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Color(0xff1E293B),
                          ),
                        ),

                        const SizedBox(height: 18),

                        Text(
                          page["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xff64748B),
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) {
                  final selected = currentPage == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: selected ? 34 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: selected
                          ? primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: Icon(
                    currentPage == pages.length - 1
                        ? Icons.check_circle
                        : Icons.arrow_forward,
                  ),
                  label: Text(
                    currentPage == pages.length - 1
                        ? "ابدأ الآن"
                        : "التالي",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (currentPage < pages.length - 1) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      finish();
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
}