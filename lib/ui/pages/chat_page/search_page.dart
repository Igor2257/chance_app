import 'package:chance_app/ui/constans.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _testUsers = <String>[
    'Olives',
    'Tomato',
    'Cheese',
    'Pepperoni',
    'Bacon',
    'Onion',
    'Jalapeno',
    'Mushrooms',
    'Pineapple',
  ];
  late List<String> _searchList = List.from(_testUsers);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _unFocus(context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.words,
                  onChanged: _onChanged,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 24 / 16,
                    color: darkNeutral800,
                    letterSpacing: 0.5,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                    isDense: true,
                    suffixIconConstraints: const BoxConstraints(
                      maxWidth: 18.0,
                      maxHeight: 18.0,
                    ),
                    suffixIcon: IconButton(
                      iconSize: 18,
                      padding: EdgeInsets.zero,
                      onPressed: _onClearBtnTap,
                      icon: const Icon(Icons.close),
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              TextButton(
                onPressed: () => _onCloseSearchPage(context),
                child: Text(
                  'Скасувати',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 24 / 16,
                    color: darkNeutral1000,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: _controller.text.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                itemBuilder: (context, index) {
                  return Text(
                    _searchList[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 24 / 16,
                      color: darkNeutral1000,
                      letterSpacing: 0.5,
                    ),
                  );
                },
                itemCount: _searchList.length,
              )
            : ListView(
                padding: const EdgeInsets.only(top: 24.0),
                children: _generateSortMap(_testUsers)
                    .entries
                    .map(_buildSortedList)
                    .toList(),
              ),
      ),
    );
  }

  Widget _buildSortedList(MapEntry<String, List<String>> entry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: darkNeutral300,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            entry.key,
            style: const TextStyle(
              fontSize: 14,
              height: 20 / 14,
              letterSpacing: 0.1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: entry.value.map(_buildChatTile).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChatTile(String val) {
    return GestureDetector(
      onTap: () => _openChat(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          val,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: 0.5,
            color: darkNeutral1000,
          ),
        ),
      ),
    );
  }

  Map<String, List<String>> _generateSortMap(List<String> list) {
    Map<String, List<String>> map = {};
    list.sort();
    for (String item in list) {
      String firstLetter = item[0].toUpperCase();
      map.putIfAbsent(firstLetter, () => []);
      map[firstLetter]!.add(item);
    }

    return map;
  }

  void _onClearBtnTap() {
    _unFocus(context);
    _controller.clear();
    setState(() {
      _searchList = _testUsers;
    });
  }

  void _unFocus(BuildContext context) => FocusScope.of(context).unfocus();

  _onCloseSearchPage(BuildContext context) => Navigator.of(context).pop();

  void _onChanged(String value) {
    setState(() {
      _searchList = _testUsers
          .where((v) => v.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    });
  }

  _openChat(BuildContext context) {}
}
