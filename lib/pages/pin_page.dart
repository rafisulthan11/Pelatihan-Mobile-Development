import 'package:flutter/material.dart';
import 'package:flutter_catatan_app/data/pin_service.dart';
import 'package:flutter_catatan_app/pages/home_page.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final TextEditingController pinController = TextEditingController();

  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 200),
          //title app
          Center(
            child: Text(
              'Aplikasi Catatan Rahasia',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 50),
          Center(child: Text('Masukkan PIN Anda')),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: pinController,
              keyboardType: TextInputType.number,
              obscureText: isHidden,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PIN',
                suffixIcon: IconButton(
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () async {
                final pin = int.tryParse(pinController.text);
                if (pin != null) {
                  int? existingPin = await PinService().getPin();
                  if (existingPin == null) {
                    await PinService().savePin(pin);
                    await PinService().saveIsLoggedIn(true);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    if (existingPin == pin) {
                      await PinService().saveIsLoggedIn(true);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('PIN salah, coba lagi'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('PIN harus berupa angka'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
