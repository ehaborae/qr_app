import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_app/pages/qr_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController qrDataFeed = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your Text/Link here',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: qrDataFeed,
                decoration: const InputDecoration(
                  hintText: 'Enter your Text/Link here',
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => QRPage(
                          qrData: qrDataFeed.text,
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.grey[200]),
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
