import 'package:drivers_app/components/text_form_widget.dart';
import 'package:drivers_app/screens/auth_screens/forget_password.dart';
import 'package:drivers_app/screens/user_screens/home_screen.dart';
import 'package:drivers_app/services/aut/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();
  //declare a GlobalKey
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void _submit() async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      try {
        await authService.login(
          emailController.text,
          passwordController.text,
        );
        setState(() {
          isLoading = false;
        });

        Fluttertoast.showToast(msg: "Successfully Logged In");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => HomeScreen(),
          ),
        );
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Login failed: ${e.toString()}");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Not all fields are valid");
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
                  "Well Come Back",
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
                              height: 10,
                            ),
                            TextFormWidget(
                              hintText: 'Password',
                              passwordSuffixIcon: true,
                              passwordVisible: false,
                              icon: Icons.password,
                              controller: passwordController,
                              limitingText: 50,
                              length: 49,
                              nameLength: 6,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => ForgetPassword(),
                                    ),
                                  ),
                                  child: Text(
                                    "Forget Password ?",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inverseSurface),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
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
                                      "Login",
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
                                  onTap: widget.onTap,
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
