import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final String serverAddress;

  LoginScreen({required this.serverAddress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          // Background circles
          Positioned(
            left: -59,
            top: -66,
            child: CircleAvatar(
              radius: 130,
              colors: [theme.colorScheme.secondary, theme.colorScheme.error],
            ),
          ),
          Positioned(
            right: 0,
            top: 91,
            child: CircleAvatar(
              radius: 130,
              colors: [theme.colorScheme.primary, theme.colorScheme.primary],
            ),
          ),
          // Login form
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: 'Maple Mono',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 70,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: 50),
                _buildTextField(
                  label: 'Email',
                  theme: theme,
                ),
                SizedBox(height: 30),
                _buildTextField(
                  label: 'Password',
                  theme: theme,
                  obscureText: true,
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    // Implement login logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Maple Mono',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required ThemeData theme, bool obscureText = false}) {
    return Container(
      width: 624,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: false, // Ensure the background is not filled
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Maple Mono',
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 40,
            color: theme.colorScheme.onSurface,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.5),
            borderSide: BorderSide(color: Color(0xFF333343), width: 5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.5),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 5),
          ),
        ),
        style: TextStyle(color: theme.colorScheme.onBackground),
      ),
    );
  }
}

class CircleAvatar extends StatelessWidget {
  final double radius;
  final List<Color> colors;

  CircleAvatar({required this.radius, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
