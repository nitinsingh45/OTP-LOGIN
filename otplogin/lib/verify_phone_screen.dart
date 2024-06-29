import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyPhoneScreen extends StatefulWidget {
  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Phone'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Verify Phone',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              /* Text(
                'Code is sent to 8094508485',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),*/
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return Container(
                    width: 40,
                    height: 40,
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 5) {
                          _focusNodes[index].unfocus();
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index + 1]);
                        }
                        if (value.length == 1 && index == 5) {
                          _focusNodes[index].unfocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                'Didn\'t receive the code? Request Again',
                style: TextStyle(fontSize: 14, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Verification logic here
                  String otp =
                      _controllers.map((controller) => controller.text).join();
                  print("Entered OTP: $otp");
                  // Add your OTP verification logic here
                },
                child: Text('VERIFY AND CONTINUE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
