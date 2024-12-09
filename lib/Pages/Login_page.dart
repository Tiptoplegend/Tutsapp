import 'package:flutter/material.dart';
import 'package:tutsapp/Services/Auth_service.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<Loginpage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? username, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: SafeArea(child: _buildui()),
    );
  }

  Widget _buildui() {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_title(), _loginForm()],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recipe Book",
      style: TextStyle(
        fontSize: 85,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width + 0.90,
        height: MediaQuery.sizeOf(context).height * 0.30,
        child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.90,
                  child: TextFormField(
                    onSaved: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a username";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Username"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.90,
                  child: TextFormField(
                    obscureText: true,
                    onSaved: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return "Enter a valid Password";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                ),
                _loginbutton(),
                _Signupbutton(),
              ],
            )));
  }

  Widget _loginbutton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(username!, password!);
          }
        },
        child: const Text("SignIn"),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _Signupbutton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(onPressed: () {}, child: Text("SignUp")),
    );
  }
}
