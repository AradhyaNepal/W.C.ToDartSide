import 'package:flutter/material.dart';
import 'package:privacy_screen/eye_custom_paint.dart';
import 'package:privacy_screen/privacy_setup.dart';

class SecretScreen extends StatefulWidget {
  const SecretScreen({super.key});

  @override
  State<SecretScreen> createState() => _SecretScreenState();
}

class _SecretScreenState extends State<SecretScreen>
    with SingleTickerProviderStateMixin {
  bool _isSecure = true;
  bool _isSecureLoading = false;
  late final AnimationController _textShaderAnimation;
  late final Animation<Color?> _colorOne;

  Color get colorOne => _colorOne.value ?? Colors.white;

  Color get colorTwo => _colorTwo.value ?? Colors.white;

  Color get backgroundColor => _backgroundColor.value ?? Colors.white;
  late final Animation<Color?> _colorTwo;
  late final Animation<Color?> _backgroundColor;

  @override
  void initState() {
    super.initState();
    _textShaderAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..repeat(reverse: true)
      ..addListener(() {
        setState(() {});
      });
    _colorOne = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(
        parent: _textShaderAnimation,
        curve: Curves.bounceOut,
      ),
    );
    _colorTwo = ColorTween(begin: Colors.green, end: Colors.purple).animate(
      CurvedAnimation(
        parent: _textShaderAnimation,
        curve: Curves.bounceIn,
      ),
    );
    _backgroundColor =
        ColorTween(end: Colors.yellow.shade100, begin: Colors.blue.shade100)
            .animate(
      CurvedAnimation(
        parent: _textShaderAnimation,
        curve: const Interval(
          0.25,
          0.75,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorTwo,
          title: Text(
            _isSecure ? "Is Secure" : "Is Not Secure",
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: _isSecureLoading
                  ? const CircularProgressIndicator()
                  : IconButton(
                      onPressed: () async {
                        setState(() {
                          _isSecureLoading = true;
                        });
                        if (_isSecure) {
                          await AppScreenPrivacyService()
                              .disableScreenPrivacy();
                        } else {
                          await AppScreenPrivacyService().enableScreenPrivacy();
                        }
                        setState(() {
                          _isSecureLoading = false;
                          _isSecure = !_isSecure;
                        });
                      },
                      icon: Icon(
                        _isSecure ? Icons.sports_gymnastics : Icons.security,
                        color: colorOne,
                      ),
                    ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: CustomPaint(
                    painter: EyeCustomPaint(),
                    child: SizedBox(
                      height: 200,
                      width: size.width * 0.75,
                    ),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.0,
                      colors: <Color>[
                        colorOne,
                        colorTwo,
                        colorOne,
                        colorTwo,
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: const Text(
                    "Welcome to the\nDart Side!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "This is very private place.\n"
                  "If someone else founds you here,"
                  "\nThen they will directly call police.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorOne,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
