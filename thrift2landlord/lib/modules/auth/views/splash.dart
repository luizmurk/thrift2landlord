part of '../index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AuthController _authController = Get.put(AuthController());
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        _authController.checkLoggedInUser();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                isDarkMode
                    ? 'assets/images/transparent_logo.png'
                    : 'assets/images/transparent_logo.png',
                width: 150.w,
                height: 150.h,
              ),
              Text('First step to becoming A Landlord')
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
