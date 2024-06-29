import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.language, size: 100, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                'Please select your Language',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'You can change the language at any time.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              DropdownButton<String>(
                value: 'English',
                items:
                    <String>['English', 'Hindi', 'Spanish'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mobile-number');
                },
                child: Text('NEXT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
