import 'package:cgcflutter/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cgcflutter/HomeScreen.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  final AuthService _authService = AuthService();
  bool _isSignedIn = false;
  String? _userName;
  String? _userEmail;
  String? _userPhotoUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    setState(() => _isLoading = true);
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        setState(() {
          _isSignedIn = true;
          _userName = currentUser.displayName;
          _userEmail = currentUser.email;
          _userPhotoUrl = currentUser.photoURL;
        });
      }
    } catch (e) {
      print('Error checking user: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signIn() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final user = await _authService.signInWithGoogle();

      if (user != null) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );

      }

    } catch (e) {
      print("Sign in error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign in failed"),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  Future<void> _signOut() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      await _authService.signOut();
      setState(() {
        _isSignedIn = false;
        _userName = null;
        _userEmail = null;
        _userPhotoUrl = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed out successfully')),
      );
    } catch (e) {
      print('Sign out error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFFFE4EC),

      body: SafeArea(

        child: Center(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(25),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const Icon(

                  Icons.icecream,

                  size: 90,

                  color: Colors.pink,

                ),

                const SizedBox(height: 15),


                const Text(

                  "Ice Cream Paradise",

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    color: Colors.pink,

                  ),

                ),


                const SizedBox(height: 10),


                const Text(

                  "Personalize your favorite ice cream!",

                  style: TextStyle(

                    color: Colors.black54,

                    fontSize: 16,

                  ),

                ),


                const SizedBox(height: 40),


                Container(

                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius: BorderRadius.circular(20),

                    boxShadow: const [

                      BoxShadow(

                        blurRadius: 12,

                        color: Colors.black12,

                        offset: Offset(0, 5),

                      ),

                    ],

                  ),

                  child: Column(

                    children: [

                      if (_isSignedIn) ...[

                        CircleAvatar(

                          radius: 45,

                          backgroundImage: _userPhotoUrl != null

                              ? NetworkImage(_userPhotoUrl!)

                              : null,

                          child: _userPhotoUrl == null

                              ? const Icon(Icons.person, size: 45)

                              : null,

                        ),

                        const SizedBox(height: 15),


                        Text(

                          _userName ?? "User",

                          style: const TextStyle(

                            fontSize: 22,

                            fontWeight: FontWeight.bold,

                          ),

                        ),


                        const SizedBox(height: 5),


                        Text(

                          _userEmail ?? "",

                          style: const TextStyle(color: Colors.grey),

                        ),


                        const SizedBox(height: 25),


                        SizedBox(

                          width: double.infinity,

                          height: 50,

                          child: ElevatedButton.icon(

                            onPressed: _isLoading ? null : _signOut,

                            icon: const Icon(Icons.logout),

                            label: Text(

                              _isLoading ? "Signing Out..." : "Sign Out",

                            ),

                            style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.pink,

                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(15),

                              ),

                            ),

                          ),

                        ),

                      ] else
                        ...[

                          SizedBox(

                            width: double.infinity,

                            height: 55,

                            child: ElevatedButton.icon(

                              onPressed: _isLoading ? null : _signIn,

                              icon: Image.asset(

                                "assets/google_icon.png",

                                height: 24,

                                errorBuilder: (_, __, ___) =>

                                const Icon(Icons.g_mobiledata),

                              ),

                              label: Text(

                                _isLoading

                                    ? "Signing In..."

                                    : "Continue with Google",

                              ),

                              style: ElevatedButton.styleFrom(

                                backgroundColor: Colors.pink,

                                foregroundColor: Colors.white,

                                shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(15),

                                ),

                              ),

                            ),

                          ),


                          const SizedBox(height: 15),


                          const Text(

                            "Secure Google Authentication",

                            style: TextStyle(color: Colors.grey),

                          ),

                        ],

                    ],

                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );
  }
}