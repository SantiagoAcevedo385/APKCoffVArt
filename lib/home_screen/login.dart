import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_screen/lista.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.red, // Color corporativo
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 211, 207, 207),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        '../asset/burdeo_logo.png',
                        height: 120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: emailController,
                        style: const TextStyle(
                            color: Colors.black), // Color de texto corporativo
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 247, 238, 238),
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: passwordController,
                        style: const TextStyle(
                            color: Colors.black), // Color de texto corporativo
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 231, 223, 223),
                          border: OutlineInputBorder(),
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final route = MaterialPageRoute(
                                builder: (context) => const MyList());
                            Navigator.push(context, route);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill input'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .red, // Color de fondo del botón corporativo
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white, // Color de texto del botón
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
    );
  }
}
