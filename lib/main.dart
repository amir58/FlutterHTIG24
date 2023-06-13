import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Page"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print('Search');
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => print('Notifications'),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      // Layouts => Column , Row , Stack
      body: Container(
        width: double.infinity,
        child: Column(
          // Main  => Vertical
          // Cross => Horizontal
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Body",
              style: TextStyle(
                fontSize: 44,
                color: Colors.purple,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Test",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Test",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(),
            TextFormField(),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Login",
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Register",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
