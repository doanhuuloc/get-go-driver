import 'package:flutter/material.dart';
import 'package:getgodriver/routes/routes.dart';

class FloatingButtonMap extends StatelessWidget {
  const FloatingButtonMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, Routes.scheduledTrips);
            },
            child: const Icon(Icons.calendar_month_outlined),
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {},
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
