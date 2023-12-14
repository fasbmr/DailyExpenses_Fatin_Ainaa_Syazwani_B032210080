import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dailyexpenses.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ipaddressController = TextEditingController();

  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: "https://cdn.inprnt.com/thumbs/d3/88/d38839e05a9325783e6875f55e2c7e51.jpg?response-cache-control=max-age=2628000")
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: ipaddressController,
                decoration: const InputDecoration(
                  labelText: 'REST API address',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;
                String ipaddress = ipaddressController.text;

                if(username == 'ainaa' && password == 'nanamin') {

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString("username", username);
                  await prefs.setBool("isLogin", true);
                  await prefs.setString("ipaddress", "http://$ipaddress");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DailyExpensesApp(username: username),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text('Login Failed'),
                        content: const Text('Invalid username or password.'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}