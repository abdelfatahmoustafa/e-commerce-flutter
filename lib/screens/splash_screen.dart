import 'package:flutter/material.dart';
import '../utils/storage.dart';
import '../models/user.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Storage.getUser(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!context.mounted) return;
          await Navigator.pushReplacementNamed(
            context,
            snapshot.data != null ? '/home' : '/login',
          );
        });
        return const Scaffold(body: Center(child: Text('Loading...')));
      },
    );
  }
}
