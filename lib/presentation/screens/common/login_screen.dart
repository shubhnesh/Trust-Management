// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:manage_trust/presentation/screens/common/home_page.dart';
// import 'package:manage_trust/presentation/screens/common/signup_screen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscure = true;
//   bool _isLoading = false;
//   String? _errorMessage;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 800),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 1),
//       end: Offset(0, 0),
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final url = Uri.parse(
//       "https://govtsoftware-backend.onrender.com/api/auth/login",
//     );
//     final body = jsonEncode({
//       "email": _emailController.text,
//       "password": _passwordController.text,
//     });

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: body,
//       );

//       print("Response Status: ${response.statusCode}");
//       print("Response Body: ${response.body}");

//       final responseData = jsonDecode(response.body);
//       if (response.statusCode == 200 && responseData['success'] == true) {
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => HomePage()),
//         // );
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder:
//               (context) => AlertDialog(
//                 title: Text("Login Successful"),
//                 content: Text("Welcome to the app!"),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomePage()),
//                       );
//                     },
//                     child: Text("OK"),
//                   ),
//                 ],
//               ),
//         );
//       } else {
//         setState(() {
//           _errorMessage = responseData['message'] ?? "Invalid credentials";
//         });
//       }
//     } catch (error) {
//       setState(() {
//         _errorMessage = "Network error. Please try again.";
//       });
//     }

//     setState(() => _isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/login_background.jpg'),
//                     fit: BoxFit.cover,
//                     colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(0.3),
//                       BlendMode.darken,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildLogo(),
//                       SizedBox(height: 20),
//                       SlideTransition(
//                         position: _slideAnimation,
//                         child: _buildGlassmorphicLoginCard(screenWidth),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLogo() {
//     return Text(
//       "Login",
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         letterSpacing: 1.2,
//       ),
//     );
//   }

//   Widget _buildGlassmorphicLoginCard(double screenWidth) {
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withOpacity(0.3)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 15,
//             spreadRadius: 3,
//           ),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             _buildTextField(Icons.email, "Email"),
//             SizedBox(height: 16),
//             _buildPasswordField(),
//             SizedBox(height: 20),
//             _buildLoginButton(screenWidth),
//             SizedBox(height: 16),
//             _buildAdditionalOptions(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(IconData icon, String label) {
//     return TextFormField(
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.white70),
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.white70),
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.1),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       style: TextStyle(color: Colors.white),
//       validator:
//           (value) =>
//               value == null || value.isEmpty ? "$label cannot be empty" : null,
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       obscureText: _isObscure,
//       decoration: InputDecoration(
//         prefixIcon: Icon(Icons.lock, color: Colors.white70),
//         labelText: "Password",
//         labelStyle: TextStyle(color: Colors.white70),
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.1),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             _isObscure ? Icons.visibility_off : Icons.visibility,
//             color: Colors.white70,
//           ),
//           onPressed: () => setState(() => _isObscure = !_isObscure),
//         ),
//       ),
//       style: TextStyle(color: Colors.white),
//       validator:
//           (value) =>
//               value == null || value.isEmpty
//                   ? "Password cannot be empty"
//                   : value.length < 6
//                   ? "Password must be at least 6 characters"
//                   : null,
//     );
//   }

//   Widget _buildLoginButton(double screenWidth) {
//     return ElevatedButton(
//       onPressed: _isLoading ? null : _login,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.deepPurpleAccent,
//         padding: EdgeInsets.symmetric(
//           vertical: 14,
//           horizontal: screenWidth * 0.3,
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       child:
//           _isLoading
//               ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
//               : Text(
//                 "Login",
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//     );
//   }

//   Widget _buildAdditionalOptions() {
//     return Column(
//       children: [
//         TextButton(
//           onPressed: () {},
//           child: Text(
//             "Forgot Password?",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         TextButton(
//           onPressed:
//               () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignupScreen()),
//               ),
//           child: Text(
//             "Don't have an account? Sign Up",
//             style: TextStyle(color: Colors.blueAccent),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:manage_trust/presentation/screens/common/home_page.dart';
// import 'package:manage_trust/presentation/screens/common/signup_screen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscure = true;
//   bool _isLoading = false;
//   String? _errorMessage;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 800),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: Offset(0, 1),
//       end: Offset(0, 0),
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final url = Uri.parse(
//       "https://govtsoftware-backend.onrender.com/api/auth/login",
//     );
//     final body = jsonEncode({
//       "email": _emailController.text.trim(),
//       "password": _passwordController.text.trim(),
//     });

//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: body,
//       );

//       print("Response Code: ${response.statusCode}");
//       print("Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         print("📢 Full Response from API: $responseData");

//         if (responseData.containsKey('success') &&
//             responseData['success'] == true) {
//           String token = responseData['token']; // Extract token
//           print("✅ Login Successful! Token: $token");

//           // Save token in SharedPreferences
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setString('auth_token', token);
//           print("✅ Token saved in SharedPreferences");

//           setState(() => _isLoading = false);

//           if (!mounted) return;

//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//               (route) => false,
//             );
//           });

//           return;
//         } else {
//           print("❌ Login Failed: ${responseData['message']}");
//           setState(() {
//             _errorMessage = responseData['message'] ?? "Invalid credentials.";
//             _isLoading = false;
//           });
//         }
//       } else {
//         print("❌ Server error: ${response.statusCode}");
//         setState(() {
//           _errorMessage = "Server error. Please try again later.";
//           _isLoading = false;
//         });
//       }
//     } catch (error) {
//       print("❌ Exception: $error");
//       setState(() {
//         _errorMessage =
//             "Unable to connect. Please check your internet connection.";
//         _isLoading = false;
//       });
//     }
//   }

//   /// Function to retrieve the token from SharedPreferences
//   Future<String?> _getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildLogo(),
//                   SizedBox(height: 20),
//                   SlideTransition(
//                     position: _slideAnimation,
//                     child: _buildLoginForm(),
//                   ),
//                   if (_errorMessage != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Text(
//                         _errorMessage!,
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogo() {
//     return Text(
//       "Login",
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildLoginForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           _buildTextField(Icons.email, "Email", _emailController),
//           SizedBox(height: 16),
//           _buildPasswordField(),
//           SizedBox(height: 20),
//           _buildLoginButton(),
//           _buildSignupOption(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(
//     IconData icon,
//     String label,
//     TextEditingController controller,
//   ) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.grey),
//         labelText: label,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       validator:
//           (value) =>
//               value == null || value.isEmpty ? "$label cannot be empty" : null,
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: _passwordController,
//       obscureText: _isObscure,
//       decoration: InputDecoration(
//         prefixIcon: Icon(Icons.lock, color: Colors.grey),
//         labelText: "Password",
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         suffixIcon: IconButton(
//           icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
//           onPressed: () => setState(() => _isObscure = !_isObscure),
//         ),
//       ),
//       validator:
//           (value) =>
//               value == null || value.isEmpty
//                   ? "Password cannot be empty"
//                   : value.length < 6
//                   ? "Password must be at least 6 characters"
//                   : null,
//     );
//   }

//   Widget _buildLoginButton() {
//     return ElevatedButton(
//       onPressed: _isLoading ? null : _login,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue,
//         padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
//       ),
//       child:
//           _isLoading
//               ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
//               : Text(
//                 "Login",
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//     );
//   }

//   Widget _buildSignupOption() {
//     return TextButton(
//       onPressed:
//           () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => SignupScreen()),
//           ),
//       child: Text(
//         "Don't have an account? Sign Up",
//         style: TextStyle(color: Colors.blueAccent),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manage_trust/presentation/screens/common/home_page.dart';
import 'package:manage_trust/presentation/screens/common/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isLoading = false;
  String? _errorMessage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle login
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse(
      "https://govtsoftware-backend.onrender.com/api/auth/login",
    );
    final body = jsonEncode({
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("📢 Full Response from API: $responseData");

        if (responseData.containsKey('success') &&
            responseData['success'] == true) {
          String token = responseData['token']; // Extract token
          print("✅ Login Successful! Token: $token");

          // Save token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          print("✅ Token saved in SharedPreferences");

          setState(() => _isLoading = false);

          if (!mounted) return;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          });
        } else {
          print("❌ Login Failed: ${responseData['message']}");
          setState(() {
            _errorMessage = responseData['message'] ?? "Invalid credentials.";
            _isLoading = false;
          });
        }
      } else {
        print("❌ Server error: ${response.statusCode}");
        setState(() {
          _errorMessage = "Server error. Please try again later.";
          _isLoading = false;
        });
      }
    } catch (error) {
      print("❌ Exception: $error");
      setState(() {
        _errorMessage =
            "Unable to connect. Please check your internet connection.";
        _isLoading = false;
      });
    }
  }

  // Function to retrieve the token from SharedPreferences
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  SizedBox(height: 20),
                  SlideTransition(
                    position: _slideAnimation,
                    child: _buildLoginForm(),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for the logo
  Widget _buildLogo() {
    return Text(
      "Login",
      style: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Widget for the login form
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(Icons.email, "Email", _emailController),
          SizedBox(height: 16),
          _buildPasswordField(),
          SizedBox(height: 20),
          _buildLoginButton(),
          _buildSignupOption(),
        ],
      ),
    );
  }

  // Widget for the text field (email or password)
  Widget _buildTextField(
    IconData icon,
    String label,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator:
          (value) =>
              value == null || value.isEmpty ? "$label cannot be empty" : null,
    );
  }

  // Widget for password field with visibility toggle
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.grey),
        labelText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _isObscure = !_isObscure),
        ),
      ),
      validator:
          (value) =>
              value == null || value.isEmpty
                  ? "Password cannot be empty"
                  : value.length < 6
                  ? "Password must be at least 6 characters"
                  : null,
    );
  }

  // Widget for the login button
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
      ),
      child:
          _isLoading
              ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
              : Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
    );
  }

  // Widget for the sign-up option link
  Widget _buildSignupOption() {
    return TextButton(
      onPressed:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignupScreen()),
          ),
      child: Text(
        "Don't have an account? Sign Up",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
