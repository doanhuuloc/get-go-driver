import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class VerificationScreen extends StatefulWidget {
  final String phone;
  const VerificationScreen({super.key, required this.phone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int remainingTime = 60;
  bool isRequestOTP = false;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          isRequestOTP = true;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  requestOTP(){
    setState(() {
      remainingTime =60;
      startCountdown();
      isRequestOTP =false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    print("cout<< ${widget.phone}");
    print("cout<< $args");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Xác thực OTP"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text:
                          "Hãy kiểm tra tin nhắn, chúng tôi vừa gữi OTP đến số ",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    TextSpan(
                      text: widget.phone,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Mã OTP của tôi là",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Center(
                child: Pinput(
                  // defaultPinTheme: PinTheme(
                  //   textStyle: TextStyle(fontSize: 20)
                  // ),
                  length: 6,
                  showCursor: true,
                  autofocus: true,
                  onCompleted: (pin) => print(pin),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Bạn không nhận được mã?",
                
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w200),
              ),
              const SizedBox(height: 10),
              isRequestOTP
                  ? GestureDetector(
                      onTap: requestOTP,
                      child: Text(
                        "Gữi lại OTP",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Yêu cầu gữi lại OTP sau",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: " ${remainingTime}s",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
