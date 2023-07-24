import 'package:flutter/material.dart';
import 'package:getgodriver/widgets/map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          InkWell(
            onTap: () {
              setState(() {
                if (isOnline) {
                  isOnline = false;
                } else {
                  isOnline = true;
                }
              });
            },
            child: Container(
              width: 180,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:const  BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: isOnline ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      Container(
                        margin:const  EdgeInsets.only(left: 10),
                        child: Text(
                          isOnline ? "Trực tuyến" : "Ngoại tuyến",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                ],
              ),
            ),
          )
        ]),
        body: MapScreen(),
      ),
    );
  }
}
