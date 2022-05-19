import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_place_flutter_app/entities/client.dart';
import 'package:market_place_flutter_app/provider/constants.dart';
import 'package:market_place_flutter_app/provider/size_config.dart';
import 'package:market_place_flutter_app/screens/home/home_screen.dart';
import 'package:market_place_flutter_app/screens/home/navigation_screen.dart';
import 'package:market_place_flutter_app/widget/default_button.dart';
import 'package:market_place_flutter_app/widget/form_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  final String email;
  final String password;
  const SignInScreen({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _pwd;
  bool? _remember = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = widget.email;
    _pwd = widget.password;
    debugPrint('init $_email');
    loadUserEmailPassword();

    //ClientPreferences.getClient();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,
                color: Theme.of(context).primaryColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  /*decoration: const BoxDecoration(
                       gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff753B99),
                          Color(0xcc753B99),
                          Color(0x99753B99),
                          Color(0x66753B99),
                        ]),
                      ),*/
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 120,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Sign in with your email and password",
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        form(),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }

  buildEmailFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            //initialValue: _email,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => _email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                ),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  buildPassFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            //initialValue: _pwd,
            controller: _passwordController,
            obscureText: true,
            onSaved: (newValue) => _pwd = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              }
              return null;
            },
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                ),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(height: 10),
          buildPassFormField(),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: _remember,
                activeColor: Colors.deepPurple,
                onChanged: (value) {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    SharedPreferences.getInstance().then(
                      (prefs) {
                        prefs.setBool("remember_me", value!);
                        prefs.setString('email', _email!);
                        prefs.setString('password', _pwd!);
                      },
                    );
                  }
                  setState(() {
                    _remember = value;

                    debugPrint('$_remember');
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  //Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
                },
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 30),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                signIn();
              }
            },
          ),
        ],
      ),
    );
  }

  signIn() async {
    debugPrint('holaaaaaaaaaaaaaaaa');
    String token = await ClientApi.login(_email!, _pwd!);
    if (token.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NavigationScreen()),
      );
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text("Please try again !"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  loadUserEmailPassword() async {
    debugPrint("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      debugPrint('load $_email');

      var pemail = _prefs.getString("email") ?? widget.email;
      var ppwd = _prefs.getString("password") ?? widget.password;
      var premember = _prefs.getBool("remember_me") ?? false;
      debugPrint(' informationsssssss $pemail');
      if (premember) {
        setState(() {
          _remember = true;
        });
        _emailController.text = pemail;
        _passwordController.text = ppwd;
        debugPrint(' informationsssssss $_email');
      }
      _emailController.text = pemail;
      _passwordController.text = ppwd;
    } catch (e) {
      debugPrint('$e');
    }
  }
}
