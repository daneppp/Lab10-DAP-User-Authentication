import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../main.dart';

/**
 * Name: Dane Patzlaff
 * Date: 11/11/25
 * Description: Login page for Cluans that takes advantage of auth_ui's Widget: SupaEmailAuth
 * Bugs: N/A
 * Reflection: 
 * I was a little confused how auth_ui's SupaEmailAuth handles registration, but I now
 * see that it just requires email verification before logging in works. Way easier than building it myself 
 * 
 */

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cluan Login... You're in the right place!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SupaEmailAuth(
              redirectTo: null,
              onSignInComplete: (response) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainApp()),
                );
              },

              onSignUpComplete: (response) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please verify through the given email to confirm your account',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
