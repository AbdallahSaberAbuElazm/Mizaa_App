import 'package:flutter/material.dart';
import 'package:mizaa/views/widgets/icon_search.dart';
import 'package:mizaa/views/widgets/sorted_by_icon.dart';
import 'package:mizaa/views/widgets/filteration_icon.dart';

class SearchInCategories extends StatelessWidget {
  final dynamic searchOnPressed;
  final dynamic filterOnPressed;
  final dynamic sortedByOnPressed;

  const SearchInCategories(
      {Key? key,
      required this.searchOnPressed,
      required this.filterOnPressed,
      required this.sortedByOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconSearch(searchOnPressed: searchOnPressed),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 142,
              child: SortedByIcon(
                sortedByOnPressed: sortedByOnPressed,
              )),
          const SizedBox(
            width: 10,
          ),
          FilterationIcon(filterOnPressed: filterOnPressed),
        ],
      ),
    );
  }
}
