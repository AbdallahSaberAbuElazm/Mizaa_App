import 'package:flutter/material.dart';
import 'package:mizaa/views/widgets/icon_search.dart';
import 'package:mizaa/views/widgets/sorted_by_icon.dart';

class SearchInSubCategories extends StatelessWidget {
  final dynamic searchOnPressed;
  final dynamic sortedByOnPressed;

  const SearchInSubCategories(
      {Key? key,
      required this.searchOnPressed,
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
          Expanded(
              child: SortedByIcon(
            sortedByOnPressed: sortedByOnPressed,
          )),
        ],
      ),
    );
  }
}
