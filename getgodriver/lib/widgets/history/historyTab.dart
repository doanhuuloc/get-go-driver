import 'package:flutter/material.dart';
import 'package:getgodriver/widgets/history/lineHistory.dart';
import 'package:getgodriver/widgets/history/statsDriver.dart';


class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key, required this.type, required this.data});
  final String type;
  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                )),
            Column(
              children: [
                type == 'day'
                    ? Text("Ngày 27/07/2023")
                    : type == 'week'
                        ? Text("Tuần 20/07/2023 - 27/07/2023")
                        : Text("Tháng 7/2023"),
                const SizedBox(height: 5),
                Text(
                  "500.000đ",
                  style: TextStyle(fontSize: 20, color: themeData.primaryColor),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                )),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          height: 1,
          decoration: const BoxDecoration(color: Colors.black12),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatsDriver(
                  title: "Mức đánh giá", stats: "5.00", isStarRate: true),
              Container(
                width: 1,
                height: 50,
                decoration: BoxDecoration(color: Colors.black12),
              ),
              StatsDriver(
                  title: "Tỷ lệ nhận đơn", stats: "100.0%", isStarRate: false),
              Container(
                width: 1,
                height: 50,
                decoration: BoxDecoration(color: Colors.black12),
              ),
              StatsDriver(
                  title: "Tỷ lệ hủy đơn", stats: "0.00%", isStarRate: false)
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: Colors.grey.shade400),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10),
          height: 30,
          alignment: Alignment.centerLeft,
          child: Text("Lịch sử", style: themeData.textTheme.bodyLarge),
        ),
        LineHistory(),
        LineHistory(),
        LineHistory(),
        LineHistory(),
        LineHistory(),
        LineHistory(),
        LineHistory(),
        LineHistory(),
      ],
    );
  }
}
