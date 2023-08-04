import 'package:flutter/material.dart';
import 'dart:convert';

import '../api/communication.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String nameOrEmail = "";
  String password = "";
  Map currentUser = {};

  @override
  Widget build(BuildContext context) {
    Communication communication = Communication();
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 36,
        ),
        child: Center(
          child: Column(
            children: [
              TextField(
                style: const TextStyle(fontSize: 18,),
                decoration: const InputDecoration(
                  hintText: 'ユーザー名またはメールアドレスを入力してください',
                ),
                onChanged: (value) => {
                  setState(() {
                    nameOrEmail = value;
                  })
                }
              ),
            
              TextField(
                style: const TextStyle(fontSize: 18,),
                decoration: const InputDecoration(
                  hintText: 'パスワードを入力してください',
                ),
                onChanged: (value) => {
                  setState((){
                    password = value;
                  })
                }
              ),

              OutlinedButton(
                child: const Text('サインインする'),
                onPressed: () async {
                  dynamic res = await communication.post('/api/sign_in', { 
                    'session': {
                      'name_or_email': nameOrEmail,
                      'password': password
                    }
                  });
                  if(res.statusCode == 200) {
                    setState(() {
                      currentUser = jsonDecode(res.body)['session'];
                    });
                    Navigator.pop(context, currentUser);
                  }
                }
              )
            ]
          )
        )
      )
    );
  }
}
