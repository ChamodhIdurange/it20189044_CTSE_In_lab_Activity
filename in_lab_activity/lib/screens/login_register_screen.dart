import 'package:flutter/material.dart';

import '../repositories/user_repositery.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final userRepo = UserRepositery();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _loginemail = TextEditingController();
  final TextEditingController _loginpassword = TextEditingController();
  Text _errorMessage = const Text("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login/Register'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (content) => AlertDialog(
                    insetPadding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 230.0,
                    ),
                    title: const Text('Sign up'),
                    content: Column(
                      children: [
                        TextField(
                          //Setting the changed value
                          controller: _email,
                          decoration:
                              const InputDecoration(hintText: "User Name"),
                        ),
                        TextField(
                          //Setting the changed value
                          controller: _password,
                          decoration:
                              const InputDecoration(hintText: "Password"),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          //Registering user
                          userRepo.registerUser(_email.text, _password.text);

                          setState(() {
                            // Emtying feilds
                            _email.text = '';
                            _password.text = '';
                          });

                          //Closing the dialog
                          Navigator.of(content).pop();
                        },
                        child: const Text('Enter'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          //Closing the dialog
                          Navigator.of(content).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ));
        },
        child: const Icon(Icons.person_2),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextField(
              //Setting the changed value
              controller: _loginemail,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            TextField(
              //Setting the changed value
              controller: _loginpassword,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            _errorMessage,
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              //Opening a waiting buffer
              onPressed: () async {
                //User login
                _errorMessage = await userRepo.signIn(
                    _loginemail.text, _loginpassword.text);
                setState(() {
                  _errorMessage = _errorMessage;
                });
                // debugPrint(_errorMessage.data);
                //Closing the waiting buffer
              },
              child: const Text('Login'),
            ),
          ]),
        ),
      ),
    );
  }
}
