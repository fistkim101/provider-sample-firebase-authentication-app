import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';
import 'repositories/repositories.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FirebaseAuthApp());
}

class FirebaseAuthApp extends StatefulWidget {
  const FirebaseAuthApp({Key? key}) : super(key: key);

  @override
  State<FirebaseAuthApp> createState() => _FirebaseAuthAppState();
}

class _FirebaseAuthAppState extends State<FirebaseAuthApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: fbAuth.FirebaseAuth.instance,
          ),
        ),
        Provider<UserRepository>(
          create: (context) => UserRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        StreamProvider<fbAuth.User?>(
          create: (context) => context.read<AuthRepository>().user,
          initialData: null,
        ),
        StateNotifierProvider<AuthProvider, AuthState>(
          create: (context) => AuthProvider(),
        ),
        StateNotifierProvider<SignInProvider, SignInState>(
          create: (context) => SignInProvider(),
        ),
        StateNotifierProvider<SignUpProvider, SignUpState>(
          create: (context) => SignUpProvider(),
        ),
        StateNotifierProvider<ProfileProvider, ProfileState>(
          create: (context) => ProfileProvider(),
        ),
        // Provider<AuthRepository>(
        //   create: (context) => AuthRepository(
        //     firebaseFirestore: FirebaseFirestore.instance,
        //     firebaseAuth: fbAuth.FirebaseAuth.instance,
        //   ),
        // ),
        // Provider<UserRepository>(
        //   create: (context) => UserRepository(
        //     firebaseFirestore: FirebaseFirestore.instance,
        //   ),
        // ),
        // StreamProvider<fbAuth.User?>(
        //   create: (context) => context.read<AuthRepository>().user,
        //   initialData: null,
        // ),
        // ChangeNotifierProxyProvider<fbAuth.User?, AuthProvider>(
        //   create: (context) => AuthProvider(
        //     authRepository: context.read<AuthRepository>(),
        //   ),
        //   update: (
        //     BuildContext context,
        //     fbAuth.User? userStream,
        //     AuthProvider? authProvider,
        //   ) =>
        //       authProvider!..update(userStream),
        // ),
        // ChangeNotifierProvider<SignInProvider>(
        //   create: (context) => SignInProvider(
        //     authRepository: context.read<AuthRepository>(),
        //   ),
        // ),
        // ChangeNotifierProvider<SignUpProvider>(
        //   create: (context) => SignUpProvider(
        //     authRepository: context.read<AuthRepository>(),
        //   ),
        // ),
        // ChangeNotifierProvider<ProfileProvider>(
        //   create: (context) => ProfileProvider(
        //     userRepository: context.read<UserRepository>(),
        //   ),
        // ),
      ],
      child: MaterialApp(
        title: 'Auth Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: {
          SignUpScreen.routeName: (context) => SignUpScreen(),
          SignInScreen.routeName: (context) => SignInScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
        },
      ),
    );
  }
}
