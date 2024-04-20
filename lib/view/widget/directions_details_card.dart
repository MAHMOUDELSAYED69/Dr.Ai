import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/data/model/place_directions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        top: context.height * 0.13,
        left: 0,
        right: 0,
        child: Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 6,
              child: _buildDetailsCard(context,
                  data: placeDirections?.totalDuration,
                  iconData: Icons.access_time_filled),
            ),
            const Spacer(),
            Expanded(
              flex: 6,
              child: _buildDetailsCard(context,
                  data: placeDirections?.totalDistance,
                  iconData: Icons.directions_car_filled),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context,
      {String? data, IconData? iconData}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side:
            BorderSide(width: 2.w, color: ColorManager.black.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(8.dm),
      ),
      color: ColorManager.white,
      child: ListTile(
        dense: true,
        horizontalTitleGap: 0,
        leading: Icon(
          iconData,
          color: ColorManager.green,
          size: 20.r,
        ),
        title: Text(
          data ?? "Empty",
          style: context.textTheme.bodyMedium,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
