import 'package:flutter/material.dart';
import 'package:getgodriver/widgets/home/countDownAnimation.dart';

class AcceptOrRejectTrip extends StatelessWidget {
  const AcceptOrRejectTrip(
      {super.key, required this.accept, required this.reject});
  final Function accept;
  final Function reject;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style:const  ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 188, 0, 0))),
          onPressed: () {reject();},
          child: const Text("Từ chối"),
        ),
        const SizedBox(width: 20),
        const SizedBox(height: 40, width: 40, child: CountdownAnimation()),
        const SizedBox(width: 20),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Theme.of(context).primaryColor)),
            onPressed: () {accept();},
            child: const Text("Chấp nhận")),
      ],
    );
  }
}
