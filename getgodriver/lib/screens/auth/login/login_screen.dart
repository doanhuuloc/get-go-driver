import 'package:flutter/material.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controller = TextEditingController();
  PhoneNumber phone = new PhoneNumber();
  bool validPhone = false;

  login() {
    if (validPhone) {
      Navigator.pushNamed(context,Routes.verification, arguments: phone.phoneNumber);
    } else {
      _notifyErrorMessage("lỗi");
    }
  }

  signup() {}

  _notifyErrorMessage(String message) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("Thông báo"),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text("Thoát"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(
                  image: AssetImage("assets/imgs/title.png"),
                ),
                Column(children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              
                            phone = number;
                            });
                            print(phone);
                          },
                          onInputValidated: (bool value) {
                            validPhone = value;
                            print(value);
                          },
                          cursorColor: Colors.black,
                          formatInput: false,
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          inputDecoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(bottom: 15, left: 0),
                            border: InputBorder.none,
                            hintText: "Your phone number",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500, fontSize: 16),
                          ),

                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          initialValue: PhoneNumber(isoCode: 'VN'),
                          textFieldController: controller,
                          // keyboardType: TextInputType.numberWithOptions(
                          //     signed: true, decimal: true),
                          inputBorder: const OutlineInputBorder(),
                          // onSaved: (PhoneNumber number) {},
                        ),
                      ),
                      Positioned(
                        left: 90,
                        top: 8,
                        bottom: 8,
                        child: Container(
                          height: 40,
                          width: 1,
                          color: Colors.black.withOpacity(0.13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: login,
                    child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).primaryColor),
                        child: const Text(
                          "ĐÂNG NHẬP",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: signup,
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(
                          "ĐĂNG KÝ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                        )),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
