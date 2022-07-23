import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//
import 'package:flutter/material.dart';
import 'package:iblood/pages/signup_page.dart';
import 'package:iblood/widgets/custom_field.dart';
import 'package:iblood/widgets/submit_button.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../models/http_exception.dart';
//

class LogInPage extends StatefulWidget {
  static const routeName = '/LogInPage';

  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String imageUrl = '';

  var loading = false;
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Login',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 15),
                const SizedBox(height: 10),
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
                loading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          SubmitButton(
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                _logIn();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            child: const Text("Don't have an account? Signup"),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(SignUpPage.routeName),
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
                      ),
              ],
            ),
          ),
        ));
  }

  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Future _logIn() async {
    setState(() {
      loading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on HttpException catch (e) {
      _handleSignUpError(e);
      setState(() {
        loading = false;
      });
    } catch (error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: error.toString());
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('login failed'),
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
        title: Text('login failed'),
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
