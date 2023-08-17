import 'package:flutter/material.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/widgets/home/bottomSheetAcceptTrip.dart';
import 'package:location/location.dart';

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
            onPressed: () {
              Location location = Location();
              location.getLocation().then((value) => {});


              showModalBottomSheet(
                enableDrag: false,
                isDismissible: false,
                context: context,
                builder: (context) {
                  return BottomSheetAcceptTrip(
                    stripId: {'1': 1},
                  );
                },
              );
            
            },
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
