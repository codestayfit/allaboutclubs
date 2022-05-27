import 'package:allaboutclubs/club_data/club_data.dart';
import 'package:allaboutclubs/club_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClubItem extends StatefulWidget {
  final ClubData clubData;
  const ClubItem({required this.clubData, Key? key}) : super(key: key);

  @override
  State<ClubItem> createState() => _ClubItemState();
}

class _ClubItemState extends State<ClubItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Container(
        margin: const EdgeInsets.only(bottom: 1),
        child: MaterialButton(
          key: UniqueKey(),
          elevation: 1,
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ClubDetail(clubData: widget.clubData)));
          },
          child: Row(
            children: [
              SizedBox(
                key: UniqueKey(),
                width: 5,
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(widget.clubData.image),
              ),
              SizedBox(
                key: UniqueKey(),
                width: 25,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(
                      key: UniqueKey(),
                      flex: 7,
                    ),
                    Text(
                      widget.clubData.name,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Spacer(
                      key: UniqueKey(),
                      flex: 1,
                    ),
                    Text(
                      widget.clubData.country,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                    Spacer(
                      key: UniqueKey(),
                      flex: 1,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Text(
                          widget.clubData.value.toString() +
                              " " +
                              AppLocalizations.of(context)!.million,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      key: UniqueKey(),
                      flex: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
