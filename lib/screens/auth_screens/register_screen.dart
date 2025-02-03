import 'package:drivers_app/components/phone_field_widget.dart';
import 'package:drivers_app/components/text_form_widget.dart';
import 'package:drivers_app/screens/user_screens/home_screen.dart';
import 'package:drivers_app/services/aut/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;
  final bool forgetPassword;
  const RegisterScreen({super.key, this.onTap, this.forgetPassword = false});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final AuthService authService = AuthService();
//declare a GlobalKey
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void _submit() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await authService.registerUser(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
        phoneController.text.trim(),
        addressController.text.trim(),
      );
      setState(() {
        isLoading = false;
      });
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (c) => HomeScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Not all field are valid");
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
                  "Register",
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
                              hintText: 'Name',
                              icon: Icons.person,
                              controller: nameController,
                              limitingText: 50,
                              length: 49,
                              nameLength: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
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
                            PhoneFieldWidget(
                              controller: phoneController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormWidget(
                              hintText: 'Address',
                              icon: Icons.location_on,
                              controller: addressController,
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
                              height: 10,
                            ),
                            TextFormWidget(
                              hintText: 'Confirm Password',
                              passwordSuffixIcon: true,
                              passwordVisible: false,
                              icon: Icons.password,
                              controller: confirmController,
                              limitingText: 50,
                              length: 49,
                              nameLength: 6,
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
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            widget.forgetPassword
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Have an account?",
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
                                          "Log In",
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
