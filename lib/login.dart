import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/shared/components/form.dart';
import 'package:messenger_app/shared/helper_functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailErrorMessage = '';
  String passwordErrorMessage = '';

  bool hidePassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Login')),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: CustomForm(children: [
            FormItem(
              verticalPadding: 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child:
                        Text('Enter you email address and password to sign in'),
                  ),
                ],
              ),
            ),
            FormItem(
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
                    focusedBorder: getInputBorder(emailErrorMessage == ''),
                    enabledBorder: getInputBorder(emailErrorMessage == ''),
                    fillColor: Colors.grey[350]),
              ),
            ),
            FormItem(
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
                    enabledBorder: getInputBorder(passwordErrorMessage == ''),
                    focusedBorder: getInputBorder(passwordErrorMessage == ''),
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
                verticalPadding: 10.0,
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
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      )),
                )),
            FormItem(
              verticalPadding: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ))
                ],
              ),
            )
          ]),
        ));
  }
}
