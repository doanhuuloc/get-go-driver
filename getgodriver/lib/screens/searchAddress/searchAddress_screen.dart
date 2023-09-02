import 'package:flutter/material.dart';
import 'package:getgodriver/widgets/searchAddress/itemSearchAddress.dart';
import 'package:getgodriver/widgets/textInputField.dart';

class SearchAddressScreen extends StatefulWidget {
  const SearchAddressScreen({super.key});

  @override
  State<SearchAddressScreen> createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  final TextEditingController _inputAddress = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Nhập điểm đến"),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextInputField(
              controller: _inputAddress,
              hintText: "Nhập địa chỉ đến",
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 1,
              color: Colors.black26,
            ),
            const SizedBox(height: 10),
            ItemSearchAddress(),
            ItemSearchAddress(),
            ItemSearchAddress(),
            ItemSearchAddress(),
          ],
        ),
      ),
    ));
  }
}
