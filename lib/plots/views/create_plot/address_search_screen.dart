import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({super.key, required this.result, required this.session, required this.query});

  final Future<SearchSessionResult> result;
  final SearchSession session;
  final String query;

  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  // final searchController = TextEditingController();
  // static const _countryBoundingBox =
  //     BoundingBox(northEast: Point(latitude: 43.3000, longitude: 76.9800), southWest: Point(latitude: 43.2000, longitude: 76.8300));
  // final List<SearchSessionResult> results = [];

  final List<SearchSessionResult> results = [];
  bool _progress = true;
  late SearchItemToponymMetadata selectedToponym;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void dispose() {
    super.dispose();

    _close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text(
          'Поиск',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0D0D0D),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _getList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Scaffold(
    //   backgroundColor: const Color(0xFF0D0D0D),
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
    //           child: CreatePlotTextField(
    //             controller: searchController,
    //             hintText: 'Адрес',
    //             keyboardType: TextInputType.text,
    //             enabled: true,
    //             onChanged: (val) async {
    //               print(val);
    //               await YandexSearch.searchByText(
    //                 searchText: val.trim(),
    //                 geometry: Geometry.fromBoundingBox(_countryBoundingBox),
    //                 searchOptions: const SearchOptions(
    //                   searchType: SearchType.geo,
    //                   geometry: true,
    //                 ),
    //               ).then((value) => value.$2.then((searchSession) => results.add(searchSession)));

    //               setState(() {});
    //               // results.add(result.$2);
    //             },
    //           ),
    //         ),
    //         Expanded(
    //             child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: _getList(),
    //         )
    //             ),
    //       ],
    //     ),
    //   ),
    // );
  }

  List<Widget> _getList() {
    final list = <Widget>[];

    if (results.isEmpty) {
      list.add((const Text('Nothing found')));
    }

    for (var r in results) {
      r.items!.asMap().forEach((i, item) {
        list.add(
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item.toponymMetadata!.address.formattedAddress,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onTap: () {
              setState(() {
                selectedToponym = item.toponymMetadata!;
              });
              Navigator.of(context).pop(selectedToponym);
            },
          ),
        );
      });
    }

    return list;
  }

  Future<void> _cancel() async {
    await widget.session.cancel();

    setState(() {
      _progress = false;
    });
  }

  Future<void> _close() async {
    await widget.session.close();
  }

  Future<void> _init() async {
    await _handleResult(await widget.result);
  }

  Future<void> _handleResult(SearchSessionResult result) async {
    setState(() {
      _progress = false;
    });

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    print('Page ${result.page}: $result');

    setState(() {
      results.add(result);
    });

    if (await widget.session.hasNextPage()) {
      print('Got ${result.found} items, fetching next page...');
      setState(() {
        _progress = true;
      });
      await _handleResult(await widget.session.fetchNextPage());
    }
  }
}
