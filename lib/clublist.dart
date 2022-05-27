import 'dart:convert';
import 'dart:developer';

import 'package:allaboutclubs/club_data/club_data.dart';
import 'package:allaboutclubs/club_item/club_detail.dart';
import 'package:allaboutclubs/club_item/club_item.dart';
import 'package:allaboutclubs/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

TextStyle normal = const TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.normal,
);
TextStyle bold = const TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

class ClubList extends StatefulWidget {
  const ClubList({Key? key}) : super(key: key);

  @override
  State<ClubList> createState() => _ClubListState();
}

class _ClubListState extends State<ClubList> {
  List clubs = [];

  @override
  void initState() {
    super.initState();
    try {
      if (Uri.parse(Global.dataUrl).host.isNotEmpty) {
        http.get(Uri.parse(Global.dataUrl)).then((itemList) {
          clubs = json.decode(utf8.decode(itemList.bodyBytes));
          setState(() {
            clubs = clubs.map((item) => ClubData.fromJson(item)).toList();
          });
        });
      }
    } catch (e) {
      log("Error: " + e.toString());
    }
  }

  bool filterByName = true;

  Future refresh() async {
    try {
      if (Uri.parse(Global.dataUrl).host.isNotEmpty) {
        final response = await http.get(Uri.parse(Global.dataUrl));
        List newClubs = [];
        if (response.statusCode == 200) {
          newClubs = json.decode(utf8.decode(response.bodyBytes));
        }
        setState(() {
          clubs = newClubs.map((item) => ClubData.fromJson(item)).toList();
        });
      }
    } catch (e) {
      log("Error: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    filterByName
        ? clubs.sort(
            (clubA, clubB) => clubA.name.compareTo(clubB.name),
          )
        : clubs.sort((clubA, clubB) => clubB.value.compareTo(clubA.value));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            onPressed: () {
              if (clubs.isNotEmpty) {
                setState(() => filterByName = !filterByName);
              }
            },
            icon: Icon(Icons.filter_list, key: UniqueKey()),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: (clubs.isNotEmpty && Uri.parse(Global.dataUrl).host.isNotEmpty)
            ? ListView.builder(
                itemCount: clubs.length,
                itemBuilder: (context, index) {
                  final club = clubs[index];
                  return ClubItem(clubData: club);
                },
              )
            : Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ListView(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.failedToDownloadData,
                          textAlign: TextAlign.center,
                          style: normal,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!
                              .pullDownOrPressButtonToRefresh,
                          textAlign: TextAlign.center,
                          style: bold,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 170,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: refresh,
                            child: Text(
                              AppLocalizations.of(context)!.refresh,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
