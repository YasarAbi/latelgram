import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latelgram/resources/auth_methods.dart';
import 'package:latelgram/screens/home_screen.dart';
import 'package:latelgram/screens/signup_screen.dart';
import 'package:latelgram/utils/colors.dart';
import 'package:latelgram/utils/utils.dart';
import 'package:latelgram/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passController.text);

    if(res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // svg resim
              SvgPicture.asset(
                'assets/LaTelGram.svg',
                color: primaryColor,
                height: 64,
              ),
              SizedBox(
                height: 64,
              ),
              // text field input for email
              TextFieldInput(
                hintText: 'E-Posta Adresi',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              SizedBox(
                height: 24,
              ),
              // text field input for pass
              TextFieldInput(
                hintText: 'Şifre',
                textInputType: TextInputType.text,
                textEditingController: _passController,
                isPass: true,
              ),
              SizedBox(
                height: 24,
              ),
              // button login
              InkWell(
                onTap: loginUser,
                child: _isLoading 
                ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
                :Container(
                  child: const Text('Giriş Yap'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // Transitioning to signing up
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignupScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text('Hesabın yok mu? '),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Üye ol.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
