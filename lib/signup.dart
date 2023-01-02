import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/shared/components/form.dart';
import 'package:messenger_app/shared/helper_functions.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String emailErrorMessage = '';
  String passwordErrorMessage = '';

  bool hidePassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Signup')),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: CustomForm(children: [
            FormItem(
              verticalPadding: 2.0,
              height: 0.1,
              child: const Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            FormItem(
              verticalPadding: 2.0,
              height: 0.1,
              child:
                  const Text('Enter your name, email and password to register'),
            ),
            FormItem(
              verticalPadding: 2.0,
              label: 'Full Name',
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  suffixIconColor: Colors.blue,
                  suffixIcon: const Icon(Icons.person, color: Colors.grey),
                  border: getInputBorder(true, outlineColor: Colors.blue),
                  focusedBorder: getInputBorder(true,
                      outlineColor: Colors.blue, thickness: 2.0),
                ),
              ),
            ),
            FormItem(
              verticalPadding: 2.0,
              label: 'Email address',
              errorMessage: emailErrorMessage,
              child: TextField(
                onChanged: ((value) => setState(() {
                      emailErrorMessage = '';
                    })),
                controller: emailController,
                decoration: InputDecoration(
                    suffixIconColor: Colors.blue,
                    suffixIcon: Icon(
                      Icons.email_rounded,
                      color: emailErrorMessage == '' ? Colors.grey : Colors.red,
                    ),
                    border: getInputBorder(emailErrorMessage == ''),
                    focusedBorder: getInputBorder(emailErrorMessage == '',
                        outlineColor: Colors.blue, thickness: 2.0),
                    fillColor: Colors.grey[350]),
              ),
            ),
            FormItem(
              verticalPadding: 2.0,
              label: 'Password',
              errorMessage: passwordErrorMessage,
              child: TextField(
                obscureText: hidePassword,
                controller: passwordController,
                decoration: InputDecoration(
                    suffixIconColor: Colors.blue,
                    suffixIcon: GestureDetector(
                      child: hidePassword
                          ? Icon(
                              Icons.visibility_off,
                              color: passwordErrorMessage == ''
                                  ? Colors.grey
                                  : Colors.red,
                            )
                          : Icon(
                              Icons.visibility,
                              color: passwordErrorMessage == ''
                                  ? Colors.grey
                                  : Colors.red,
                            ),
                      onTap: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                    border: getInputBorder(passwordErrorMessage == ''),
                    focusedBorder: getInputBorder(passwordErrorMessage == '',
                        outlineColor: Colors.blue, thickness: 2.0),
                    fillColor: Colors.grey[350]),
                onChanged: (value) {
                  if (value.length < 8) {
                    setState(() {
                      passwordErrorMessage =
                          'password must be more than 8 characters';
                    });
                  } else {
                    setState(() {
                      passwordErrorMessage = '';
                    });
                  }
                },
              ),
            ),
            FormItem(
                verticalPadding: 2.0,
                child: Center(
                  child: TextButton(
                      onPressed: () {
                        bool validEmail =
                            EmailValidator.validate(emailController.text);
                        if (!validEmail) {
                          setState(() {
                            emailErrorMessage = 'Invalid email address';
                          });
                        } else {
                          emailErrorMessage = '';
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        child: const Center(
                          child: Text(
                            softWrap: true,
                            'Signup',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      )),
                ))
          ]),
        ));
  }
}
