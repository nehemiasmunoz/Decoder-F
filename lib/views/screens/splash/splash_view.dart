import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final LocalAuthentication auth;
  bool _supportState = false;
  @override
  void initState() {
    super.initState();

    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSuported) => setState(
            () {
              _supportState = isSuported;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              size: 90,
            ),
            const Text(
              "Decoder",
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () async {
                  _getAvailableBiometrics;
                  await _authenticate();
                  Navigator.pushReplacementNamed(context, "home");
                },
                child: const Text("Ingresar"))
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: "Verifica tu identidad",
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true));
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (!mounted) return;
  }
}
