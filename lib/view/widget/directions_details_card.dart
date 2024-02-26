import 'package:dr_ai/data/model/place_directions.dart';
import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class DistanceAndTime extends StatelessWidget {
  final PlaceDirectionsModel? placeDirections;
  final bool isTimeAndDistanceVisible;

  const DistanceAndTime(
      {super.key,
      this.placeDirections,
      required this.isTimeAndDistanceVisible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isTimeAndDistanceVisible,
      child: Positioned(
        top: 0,
        bottom: 570,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: MyColors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.access_time_filled,
                    color: MyColors.blue,
                    size: 30,
                  ),
                  title: Text(
                    placeDirections!.totalDuration,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Flexible(
              flex: 1,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: MyColors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0,
                  leading: const Icon(
                    Icons.directions_car_filled,
                    color: MyColors.blue,
                    size: 30,
                  ),
                  title: Text(
                    placeDirections!.totalDistance,
                    style: const TextStyle(color: MyColors.black, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
