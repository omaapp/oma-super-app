import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("المحفظة"),
        centerTitle: true,
      ),

      body: ListView(

        padding: const EdgeInsets.all(18),

        children: [

          Container(

            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(

              gradient: const LinearGradient(

                colors: [

                  Color(0xff1565C0),

                  Color(0xff0D47A1),

                ],
              ),

              borderRadius:
                  BorderRadius.circular(24),
            ),

            child: const Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  "الرصيد الحالي",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  "15,000 د.ع",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(

            children: [

              Expanded(
                child: _WalletButton(
                  icon: Icons.add,
                  title: "شحن",
                  color: Colors.green,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: _WalletButton(
                  icon: Icons.history,
                  title: "السجل",
                  color: Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(

            "آخر العمليات",

            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          const _WalletItem(
            title: "شحن رصيد",
            amount: "+10000 د.ع",
            color: Colors.green,
          ),

          SizedBox(height: 14),

          _WalletItem(
            title: "رحلة Taxi",
            amount: "-2500 د.ع",
            color: Colors.red,
          ),

          SizedBox(height: 14),

          _WalletItem(
            title: "رحلة Tuk Tuk",
            amount: "-1500 د.ع",
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _WalletButton extends StatelessWidget {

  final IconData icon;
  final String title;
  final Color color;

  const _WalletButton({

    required this.icon,

    required this.title,

    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: () {},

      borderRadius:
          BorderRadius.circular(18),

      child: Container(

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color: color.withOpacity(.08),

          borderRadius:
              BorderRadius.circular(18),
        ),

        child: Column(

          children: [

            Icon(
              icon,
              color: color,
              size: 34,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletItem extends StatelessWidget {

  final String title;
  final String amount;
  final Color color;

  const _WalletItem({

    required this.title,

    required this.amount,

    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: const [

          BoxShadow(

            color: Color(0x11000000),

            blurRadius: 10,

            offset: Offset(0,4),
          ),
        ],
      ),

      child: Row(

        children: [

          CircleAvatar(

            backgroundColor:
                color.withOpacity(.12),

            child: Icon(

              Icons.account_balance_wallet,

              color: color,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Text(

              title,

              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Text(

            amount,

            style: TextStyle(

              color: color,

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}