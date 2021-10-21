import 'package:t2p/screen/bottom_navpage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:t2p/style.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();



  final TextEditingController number = TextEditingController();
  final TextEditingController otp = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController referralCode = TextEditingController();

  late TabController tabController = TabController(length: 2, vsync: this);
  bool isChecked = false;

  Color? getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red[700];
    }
    return Colors.red[700];
  }

  // @override
  // void initState() {
  //   tabController = TabController(length: 2, vsync: this);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset(
              "assets/logo.png",
              width: 150,
              height: 150,
            ),
          ),
          TabBar(
            controller: tabController,
            labelColor: Colors.red[700],
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.red[700],
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text('LOGIN'),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text('SIGN UP'),
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[buildLogin(), buildSignUp()],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLogin() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: textFieldDecoration('smartphone.png', "Mobile Number"),
              ),
              const SizedBox(height: 20),

              TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: textFieldDecoration('mobile-phone.png', "Otp"),

              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 58,
                width: 400,
                //padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (number.text.isNotEmpty) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavPage()),
                          (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red[700],
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text('enter mobile number'),
                            ],
                          )));
                    }
                  },
                  style: elevatedButtonStyle(),
                  child: const Text(
                    "GET OTP",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignUp() {
    return SingleChildScrollView(
      child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
                controller: email,
                keyboardType: TextInputType.text,
                decoration:
                    textFieldDecoration('mail.png', "Email")),
            const SizedBox(height: 20),
            TextFormField(
                controller: number,
                keyboardType: TextInputType.number,
                decoration: textFieldDecoration(
                    'smartphone.png', "Mobile Number")),
            const SizedBox(height: 20),
            TextFormField(
                controller: referralCode,
                keyboardType: TextInputType.name,
                decoration: textFieldDecoration(
                    'mobile-phone.png', "Referral Code (optional)")),
            const SizedBox(height: 20),
            TextFormField(
                controller: otp,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: textFieldDecoration('mobile-phone.png', "Otp")),
            const SizedBox(height: 20),

            Wrap(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                SizedBox(
                  width: 280,
                  height: 35,
                  child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: " By signing up, you agree to our ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://tastes2plate.com/terms-and-condition');
                          },
                      ),
                      const TextSpan(
                        text: "  and  ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: 'Conditions',
                        style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                           ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://tastes2plate.com/terms-and-condition');
                          },
                      ),
                    ],
                  ),
              ),
                ),]
            ),
            SizedBox(
              height: 58,
              width: 400,
              child: ElevatedButton(
                onPressed: () async {
                  if (number.text.isNotEmpty &&
                      email.text.isNotEmpty) {
                    await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavPage()),
                        (Route<dynamic> route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red[700],
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text('oops login failed'),
                          ],
                        )));
                  }
                },
                style: elevatedButtonStyle(),
                child: const Text(
                  "GET OTP",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }

}
