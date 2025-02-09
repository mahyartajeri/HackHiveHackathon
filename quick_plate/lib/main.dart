import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_plate/models/my_user.dart';
import 'package:quick_plate/screens/auth_screen.dart';
import 'package:quick_plate/screens/recipes_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_plate/providers/user_provider.dart';

const ColorScheme kColorScheme = ColorScheme(
  brightness: Brightness.light, // Change to Brightness.dark for a dark theme
  primary: Color.fromARGB(255, 92, 45, 202), // Vibrant purple
  onPrimary: Color(0xFFFFFFFF), // White text/icons on primary
  secondary: Color(0xFF03DAC6), // Teal accent
  onSecondary: Color(0xFF000000), // Black text/icons on secondary
  tertiary: Color(0xFFFFB300), // Gold/Amber tertiary accent
  onTertiary: Color(0xFF000000),
  error: Color(0xFFB00020), // Standard error red
  onError: Color(0xFFFFFFFF), // Dark text on light background
  surface: Color.fromARGB(255, 92, 45, 202), // White surface (cards, sheets)
  onSurface: Color(0xFFFFFFFF), // Black text on white surface
  surfaceContainerHighest: Color(0xFFEEEEEE), // Light gray for differentiation
  onSurfaceVariant: Color(0xFF333333),
  outline: Color(0xFF757575), // Neutral outline color
  shadow: Color(0xFF000000), // Standard shadow color
  inverseSurface: Color(0xFF121212), // Inverse for dark mode
  onInverseSurface: Color(0xFFF2F2F2),
  inversePrimary: Color(0xFFBB86FC), // Lighter purple for contrast
  scrim: Color(0xFF000000), // Scrim for overlays
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: const Color(0xFF3E5F41),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  void _updateUserProvider(MyUser user, WidgetRef ref) {
    ref.read(userProvider.notifier).setUser(user);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.hasData) {
            // after 1ms delay, update provider with user data
            Future.delayed(const Duration(milliseconds: 1), () {
              if (ref.read(userProvider.notifier).isUserEmpty()) {
                _updateUserProvider(
                  MyUser(
                    uid: snapshot.data!.uid,
                    email: snapshot.data!.email!,
                    name: snapshot.data!.displayName!,
                    recipes: [],
                  ),
                  ref,
                );
              }
            });

            return RecipesScreen(
              recipes: ref.read(userProvider).recipes,
            );
          } else {
            return AuthScreen(
              onTapTermsAndConditions: (context) {},
            );
          }
        },
      ),
    );
  }
}
