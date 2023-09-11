import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  final TextEditingController messageController = TextEditingController();
  bool _isKeyboardOpen = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xfff1f3f5),
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 30,
        title: const Text(
          'Chọn loại xe',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Icon color is black
          ),
          onPressed: () {
            Navigator.of(context).pop();
            // Handle back button press here
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x11000000),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: const FittedBox(
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0x7f595555),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: context.watch<TripViewModel>().message.map((e) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: e['0'] == null
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: e['0'] == null
                                    ? Color(0xccfa8d1d)
                                    : Color(0xFFDBD7D7),
                                borderRadius: BorderRadius.only(
                                  topLeft: e['0'] == null
                                      ? Radius.circular(10)
                                      : Radius.circular(0),
                                  topRight: e['0'] != null
                                      ? Radius.circular(10)
                                      : Radius.circular(0),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context)
                                                .size
                                                .width /
                                            2.1, // Giới hạn chiều rộng tối đa là 100
                                      ),
                                      child: Text(
                                        e['0'] != null
                                            ? e['0'].toString()
                                            : e[context
                                                    .read<DriverViewModel>()
                                                    .driverId
                                                    .toString()]
                                                .toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      e['time'].toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0x84000000),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                )
              ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: _isKeyboardOpen ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: SlideTransition(
                position: _animation,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {
                      DateTime now = DateTime.now();
                      String formattedTime = DateFormat('HH:mm').format(now);
                      context.read<TripViewModel>().pushMessage(
                          value,
                          context.read<DriverViewModel>().driverId.toString(),
                          formattedTime);
                      SocketService.sendMessage(value, context);
                      // Xử lý sự kiện khi người dùng nhấn nút Enter
                      // Điều này xảy ra khi người dùng nhấn Enter và không điều hướng đến trường khác
                      print("Người dùng đã nhấn Enter với giá trị: $value");
                      messageController.clear();
                    },
                    decoration: InputDecoration(
                      hintText: "Tin nhắn",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.5)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(
                                0.5)), // Màu của border khi không được focus
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            color: Theme.of(context)
                                .primaryColor), // Màu của border khi được focus
                      ),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardOpen = WidgetsBinding.instance?.window.viewInsets.bottom != 0;
    setState(() {
      _isKeyboardOpen = keyboardOpen;
    });
    if (_isKeyboardOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
