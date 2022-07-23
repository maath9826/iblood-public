
//
import 'package:flutter/material.dart';
import 'package:iblood/models/user/user.dart';
import 'package:iblood/models/user/user_roles/user_roles.dart';
import 'package:iblood/pages/login_page.dart';
import 'package:iblood/widgets/custom_field.dart';
import 'package:iblood/widgets/submit_button.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../providers/auth_provider.dart';
import '../models/http_exception.dart';
//

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUpPage';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  var loading = false;

  AuthProvider? _authProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Sign up',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 15),
                const SizedBox(height: 10),
                CustomField(
                  label: 'Name',
                  controller: _userNameController,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 15),
                CustomField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 15),
                CustomField(
                  label: 'Password',
                  controller: _passwordController,
                  validator: _requiredValidator,
                  isPassword: true,
                ),
                const SizedBox(height: 15),
                CustomField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  validator: _confirmPasswordValidator,
                  isPassword: true,
                ),
                const SizedBox(height: 15),
                if (loading) const Center(child: CircularProgressIndicator()),
                if (!loading) ...[
                  SubmitButton(
                    onPressed: () {
                      if (_validateAllFields()) {
                        _signUp();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: const Text('Already have an account? Login '),
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(LogInPage.routeName),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 4),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ));
  }

  bool _validateAllFields() {
    if (_formKey.currentState!.validate()
    // &&
        // _selectedBloodGroup != null &&
        // _selectedGender != null &&
        // _selectedLocation != null
    ) {
      return true;
    } else {
      return false;
    }
  }

  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return 'This field is required';
    }
    if (_passwordController.text != confirmPasswordText) {
      return "Passwords don't match";
    }
    return null;
  }

  Future _signUp() async {
    setState(() {
      loading = true;
    });
    try {
      await _authProvider!.signup(
        email: _emailController.text,
        password: _passwordController.text,
        user: User(
          userName: _userNameController.text,
          email: _emailController.text,
          roles: UserRoles()
        ),
      );

      Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign up succeeded'),
          content: const Text('Your account was created, click "Ok" to proceed'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'))
          ],
        ),
      );
      // Navigator.of(context).pop();
    } on HttpException catch (e) {
      _handleSignUpError(e);
      setState(() {
        loading = false;
      });
    } catch (error) {
      print("errorrr: $error");
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign up failed'),
          content: const Text(errorMessage),
          actions: [
            TextButton(
                onPressed: () {
                   Navigator.of(context).pop();
                },
                child: const Text('Ok'))
          ],
        ),
      );
      setState(() {
        loading = false;
      });
    }

  }

  void _handleSignUpError(HttpException error) {
    print(error);
    var errorMessage = 'Authentication failed';
    if (error.toString().contains('EMAIL_EXISTS')) {
      errorMessage = 'This email address is already in use.';
    } else if (error.toString().contains('INVALID_EMAIL')) {
      errorMessage = 'This is not a valid email address';
    } else if (error.toString().contains('WEAK_PASSWORD')) {
      errorMessage = 'This password is too weak.';
    } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
      errorMessage = 'Could not find a user with that email.';
    } else if (error.toString().contains('INVALID_PASSWORD')) {
      errorMessage = 'Invalid password.';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign up failed'),
        content: Text(errorMessage),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'))
        ],
      ),
    );
  }
}
