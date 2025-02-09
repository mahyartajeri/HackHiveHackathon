import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quick_plate/models/my_user.dart';
import 'package:quick_plate/providers/user_provider.dart';

enum LoadingState {
  loading,
  authenticating,
  done,
}

final _firebase = FirebaseAuth.instance;

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({
    super.key,
    required this.onTapTermsAndConditions,
  });

  final void Function(BuildContext context) onTapTermsAndConditions;

  @override
  ConsumerState<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  var _loadingState = LoadingState.done;

  // String randomNonceString(int length) {
  //   if (length < 1) return '';
  //   const charset =
  //       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //   final random = Random.secure();
  //   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
  //       .join();
  // }

  void _updateUserProvider(MyUser user, WidgetRef ref) {
    print('updating user');
    ref.read(userProvider.notifier).setUser(user);
    print('aftor');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void signInCallback() async {
      // If not signed in, return
      if (_firebase.currentUser == null) {
        return;
      }
      final uc = _firebase.currentUser!;
      // if user is new, add to firestore
      final docRef = FirebaseFirestore.instance.collection('users').doc(uc.uid);

      final snapshot = await docRef.get();

      // final timestamp = DateTime.now().toUtc();
      final name = uc.email!.split('@')[0];
      if (!snapshot.exists) {
        final userData = {
          'uid': uc.uid,
          'email': uc.email,
          'name': name,
          'handle': name,
          // 'bio': '',
          // 'profilePictureUrl': null,
          // 'bannerUrl': null,
          // 'createdAt': timestamp,
          // 'lastLoginAt': timestamp,
          // 'doneIntro': false,
          // 'requests': [],
          // 'friends': [],
          // 'pinnedChats': [],
          // 'blockedUsers': [],
          // 'deleted': false,
        };
        await docRef.set(userData);
      } else {
        // await docRef.update({
        //   'lastLoginAt': timestamp,
        // });
      }
      // print('done');
    }

    void signInWithGoogle() async {
      // Once signed in, return the UserCredential
      try {
        setState(() {
          _loadingState = LoadingState.loading;
        });
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        setState(() {
          _loadingState = LoadingState.authenticating;
        });
        await _firebase.signInWithCredential(credential);
        signInCallback();

        // HelperFunctions.startPeriodicUpdate(timer);
      } on FirebaseAuthException catch (error) {
        print(error);
        if (!context.mounted) {
          setState(() {
            _loadingState = LoadingState.done;
          });
          return;
        }

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed'),
          ),
        );
      } catch (e) {
        print(e);
        if (context.mounted) {
          setState(() {
            _loadingState = LoadingState.done;
          });
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Authentication failed due to unknown error'),
            ),
          );
          return;
        }
      } finally {
        if (mounted) {
          setState(() {
            _loadingState = LoadingState.done;
          });
        }
      }
    }

    return Scaffold(
      body: _loadingState == LoadingState.done
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'QuickPlate',
                    style: theme.textTheme.displayLarge!.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 66,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Macros made easy',
                    style: theme.textTheme.displaySmall!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    onPressed: signInWithGoogle,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Sign in with Google',
                          style: theme.textTheme.headlineMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => widget.onTapTermsAndConditions(context),
                    child: const Text('Terms and Conditions'),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
