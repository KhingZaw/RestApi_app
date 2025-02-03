import 'package:drivers_app/components/text_form_widget.dart';
import 'package:drivers_app/screens/auth_screens/register_screen.dart';
import 'package:drivers_app/services/aut/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  //declare a GlobalKey
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final AuthService authService = AuthService();
  void _submit() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      final success =
          await authService.resetPassword(email: emailController.text);
      setState(() {
        isLoading = false;
      });
      if (success) {
        Fluttertoast.showToast(
            msg:
                "We have sent you an email to recover password, please check email");
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                Image.asset("assets/images/city.jpg"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Forget Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormWidget(
                              hintText: 'Email',
                              icon: Icons.email,
                              controller: emailController,
                              limitingText: 100,
                              length: 99,
                              nameLength: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              onPressed: _submit,
                              child: isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Text(
                                      "Send Reset Password",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) =>
                                          RegisterScreen(forgetPassword: true),
                                    ),
                                  ),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
