import 'package:dr_ai/data/model/place_suggetion.dart';
import 'package:dr_ai/logic/maps/maps_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:uuid/uuid.dart';

import '../../core/constant/color.dart';

class MyFloatingSearchBar extends StatefulWidget {
  const MyFloatingSearchBar({super.key});
  @override
  MyFloatingSearchBarState createState() => MyFloatingSearchBarState();
}

class MyFloatingSearchBarState extends State<MyFloatingSearchBar> {
  FloatingSearchBarController searchBarController =
      FloatingSearchBarController();

  void Function(String)? onQueryChanged(query) {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .getPlaceSuggetions(place: query, sessionToken: sessionToken);
    return null;
  }

  List<PlaceSuggestionModel> placeSuggestionList = [];
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: searchBarController,
      borderRadius: BorderRadius.circular(14),
      height: 50,
      hint: 'Find a hospital...',
      scrollPadding: const EdgeInsets.only(bottom: 56, top: 0),
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: onQueryChanged,
      clearQueryOnClose: true,
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.apartment_rounded,
                color: MyColors.green, size: 30),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return BlocBuilder<MapsCubit, MapsState>(
          builder: (context, state) {
            if (state is MapsLoadedSuggestionsSuccess) {
              placeSuggestionList = state.placeSuggestionList;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: placeSuggestionList.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    trailing: const Icon(
                      Icons.apartment_rounded,
                      color: MyColors.green,
                    ),
                    leading: const Icon(
                      Icons.place,
                      color: MyColors.green,
                    ),
                    title: Text(
                      placeSuggestionList[index].mainText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      placeSuggestionList[index].secondaryText,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      final sessionToken = const Uuid().v4();
                      BlocProvider.of<MapsCubit>(context).getPlaceLocation(
                          placeId: placeSuggestionList[index].placeId,
                          description: placeSuggestionList[index].description,
                          sessionToken: sessionToken);
                      searchBarController.close();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              );
            }
            if (state is MapsLoading) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: MyColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircularProgressIndicator(
                    color: MyColors.green,
                  ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
