import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("العناوين المحفوظة"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context, uid);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("addresses")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("لا توجد عناوين محفوظة"),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data =
                  docs[index].data()
                      as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  leading: Icon(
                    data["type"] == "home"
                        ? Icons.home
                        : Icons.work,
                  ),
                  title: Text(data["title"]),
                  subtitle: Text(data["address"]),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      docs[index].reference.delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static void _showAddDialog(
      BuildContext context,
      String uid) {
    final title = TextEditingController();
    final address = TextEditingController();

    String type = "home";

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("إضافة عنوان"),

              content: SingleChildScrollView(
                child: Column(
                  children: [

                    TextField(
                      controller: title,
                      decoration: const InputDecoration(
                        labelText: "اسم العنوان",
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: address,
                      decoration: const InputDecoration(
                        labelText: "العنوان",
                      ),
                    ),

                    const SizedBox(height: 15),

                    DropdownButton<String>(
                      value: type,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: "home",
                          child: Text("المنزل"),
                        ),
                        DropdownMenuItem(
                          value: "work",
                          child: Text("العمل"),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          type = v!;
                        });
                      },
                    ),
                  ],
                ),
              ),

              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("إلغاء"),
                ),

                ElevatedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .collection("addresses")
                        .add({
                      "title": title.text,
                      "address": address.text,
                      "type": type,
                    });

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("حفظ"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}