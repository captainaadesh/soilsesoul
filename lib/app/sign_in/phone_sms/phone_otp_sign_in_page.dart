import 'package:flutter/material.dart';

class SignInWithOTPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('SignIn with OTP'),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Enter Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    keyboardAppearance: Brightness.light,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      hintText: 'Enter Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    keyboardAppearance: Brightness.light,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        child: Text('Send Otp'),
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

