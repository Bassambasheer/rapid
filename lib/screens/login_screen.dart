import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rapidd_technologies/Utils/context_extension.dart';
import 'package:rapidd_technologies/Utils/navigation_bar.dart';
import 'package:rapidd_technologies/Utils/text_field.dart';
import 'package:rapidd_technologies/Utils/utils.dart';
import 'package:rapidd_technologies/riverpods/auth_pod.dart';
import 'package:rapidd_technologies/screens/register_screen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  final RegExp regExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HexColor('#79a3d3'),
              HexColor('#d5e7fd')
            ], // Replace with your desired colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'Unlock Your World\nHere!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                    ).fontFamily,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                TxtField(
                  capitalization: TextCapitalization.none,
                  hint: 'E-mail',
                  insideHint: 'Enter your E-mail',
                  controller: _usernameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'E-mail is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TxtField(
                  hint: 'Password',
                  insideHint: 'Enter Passcode',
                  pass: obscure,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Atleast one uppercase,lowercase,numeric and\nspecial character is required ';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: 350,
                    child: RoundedLoadingButton(
                      borderRadius: 20,
                      color: Colors.blue,
                      controller: _btnController,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authNotifier
                              .loginUser(_usernameController.text,
                                  _passwordController.text)
                              .then((value) {
                            context.navigateToScreen(
                                child: const CustomNavigationBar(),
                                isReplace: true);
                            Utils.saveBooleanValue('isLoggedIn', true);
                            Utils.showToast('User Logged in Successfully');
                          }).catchError((e) {
                            Utils.showErrorToast('Invalid Credentials');
                            _btnController.reset();
                          });
                        } else {
                          _btnController.reset();
                        }
                      },
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ));
                    },
                    child: Text(
                      "New User? Create Account",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontFamily: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                        ).fontFamily,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
