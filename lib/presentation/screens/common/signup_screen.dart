// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class SignupScreen extends StatefulWidget {
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscurePassword = true;
//   bool _isObscureConfirmPassword = true;
//   bool _isLoading = false;

//   late AnimationController _controller;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1000),
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
//   }

//   void _signup() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       Future.delayed(Duration(seconds: 2), () {
//         setState(() {
//           _isLoading = false;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               height: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/login_background.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.08,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildLogo(),
//                         SizedBox(height: 20),
//                         SlideTransition(
//                           position: _slideAnimation,
//                           child: _buildGlassmorphicSignupCard(screenWidth),
//                         ),
//                       ],
//                     ),
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
//     return Column(
//       children: [
//         Text(
//           "Create Account",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGlassmorphicSignupCard(double screenWidth) {
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withOpacity(0.3)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blueAccent.withOpacity(0.2),
//             blurRadius: 15,
//             spreadRadius: 5,
//           ),
//         ],
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             _buildTextField(Icons.person, "Full Name", false),
//             SizedBox(height: 16),
//             _buildTextField(Icons.email, "Email", false),
//             SizedBox(height: 16),
//             _buildPasswordField(),
//             SizedBox(height: 16),
//             _buildConfirmPasswordField(),
//             SizedBox(height: 20),
//             _buildSignupButton(screenWidth),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(IconData icon, String label, bool obscureText) {
//     return TextFormField(
//       obscureText: obscureText,
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
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "$label cannot be empty";
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       obscureText: _isObscurePassword,
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
//         suffixIcon: GestureDetector(
//           onTap: () {
//             setState(() {
//               _isObscurePassword = !_isObscurePassword;
//             });
//           },
//           child: Icon(
//             _isObscurePassword ? Icons.visibility_off : Icons.visibility,
//             color: Colors.white70,
//           ),
//         ),
//       ),
//       style: TextStyle(color: Colors.white),
//     );
//   }

//   Widget _buildConfirmPasswordField() {
//     return TextFormField(
//       obscureText: _isObscureConfirmPassword,
//       decoration: InputDecoration(
//         prefixIcon: Icon(Icons.lock, color: Colors.white70),
//         labelText: "Confirm Password",
//         labelStyle: TextStyle(color: Colors.white70),
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.1),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         suffixIcon: GestureDetector(
//           onTap: () {
//             setState(() {
//               _isObscureConfirmPassword = !_isObscureConfirmPassword;
//             });
//           },
//           child: Icon(
//             _isObscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//             color: Colors.white70,
//           ),
//         ),
//       ),
//       style: TextStyle(color: Colors.white),
//     );
//   }

//   Widget _buildSignupButton(double screenWidth) {
//     return ElevatedButton(
//       onPressed: /* _isLoading ? null :*/ _signup,
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
//                 "Sign Up",
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  bool _isLoading = false;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
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
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a delay for signup process
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        // Show Custom SnackBar at the top
        OverlayEntry? overlayEntry;
        overlayEntry = OverlayEntry(
          builder:
              (context) => Positioned(
                top: 50, // Position the SnackBar at the top
                left: 150,
                right: 150,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Signup Successful",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ), // Add spacing between text and progress indicator
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 1.0, end: 0.0),
                          duration: Duration(seconds: 3),
                          builder: (context, value, child) {
                            return LinearProgressIndicator(
                              value: value, // Reverse progress
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              backgroundColor: Colors.green.shade200,
                            );
                          },
                          onEnd: () {
                            overlayEntry
                                ?.remove(); // Remove the SnackBar after the duration
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        );

        // Insert the overlay entry
        Overlay.of(context)?.insert(overlayEntry);

        // Redirect to Login Screen after the SnackBar duration
        Future.delayed(Duration(seconds: 3), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login_background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLogo(),
                        SizedBox(height: 20),
                        SlideTransition(
                          position: _slideAnimation,
                          child: _buildGlassmorphicSignupCard(screenWidth),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassmorphicSignupCard(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(Icons.person, "Full Name", false),
            SizedBox(height: 16),
            _buildTextField(Icons.email, "Email", false),
            SizedBox(height: 16),
            _buildPasswordField(),
            SizedBox(height: 16),
            _buildConfirmPasswordField(),
            SizedBox(height: 20),
            _buildSignupButton(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, bool obscureText) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label cannot be empty";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: _isObscurePassword,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.white70),
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isObscurePassword = !_isObscurePassword;
            });
          },
          child: Icon(
            _isObscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      obscureText: _isObscureConfirmPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.white70),
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isObscureConfirmPassword = !_isObscureConfirmPassword;
            });
          },
          child: Icon(
            _isObscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildSignupButton(double screenWidth) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _signup,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        padding: EdgeInsets.symmetric(
          vertical: 14,
          horizontal: screenWidth * 0.3,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child:
          _isLoading
              ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
              : Text(
                "Sign Up",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
    );
  }
}
