import 'package:flutter/material.dart';
import 'package:football/Providers/LiveMatchesProvider.dart';
import 'package:football/Weidgets/SearchField.dart';
import 'package:football/constant/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../Weidgets/HeadLineWeidget.dart';
import '../../../../Weidgets/MatchCardWeidget.dart';
import '../../../../Weidgets/MatchesPageViewWeidget.dart';
import '../../../../Weidgets/SmallMatchCard.dart';
import '../../../../Weidgets/outlinedContainer.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selected = 0;
  selected(int number) {
    if (_selected != number) {
      setState(() {
        _selected = number;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'Matchboard',
                  style: TextStyle(
                      color: kTextWhiteColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SearchField(),
              SizedBox(height: 2.h),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => selected(0),
                  child: OutLinedBoxWidget(
                    title: 'all',
                    icon: Icons.align_horizontal_left_sharp,
                    selected: _selected == 0 ? true : false,
                  ),
                ),
                InkWell(
                  onTap: () => selected(1),
                  child: OutLinedBoxWidget(
                      title: 'Live',
                      icon: Icons.circle,
                      selected: _selected == 1 ? true : false),
                ),
                InkWell(
                  onTap: () => selected(2),
                  child: OutLinedBoxWidget(
                      title: 'Top',
                      icon: Icons.sports_baseball_outlined,
                      selected: _selected == 2 ? true : false),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: SizedBox(
              height: 25.h,
              child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const MatchesPageViewWeidget();
                  }),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text('Games',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: SizedBox(
              height: 10.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(viewportFraction: 0.2),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.sports_baseball_outlined,
                      size: 20.w,
                      color: kUnselectedcolor,
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: HeadLineWidget(title: 'Live Matches'),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: SizedBox(
              height: 10.h,
              child: Consumer<LiveMatchesProvider>(
                  builder: (_, matchesProvider, __) {
                return matchesProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: PageController(viewportFraction: 0.5),
                        itemCount: matchesProvider.matchesList.length,
                        itemBuilder: (context, index) {
                          return SmallMatchCard(
                            matchid:
                                matchesProvider.matchesList[index].matchId!,
                            team1Logo:
                                matchesProvider.matchesList[index].team1!.logo!,
                            team2Logo:
                                matchesProvider.matchesList[index].team2!.logo!,
                            team1Score: matchesProvider
                                .matchesList[index].score!.fullTime!.team1!,
                            team2Score: matchesProvider
                                .matchesList[index].score!.fullTime!.team2!,
                          );
                        });
              }),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: HeadLineWidget(title: 'Matches'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Consumer<LiveMatchesProvider>(
                builder: (_, matchesProvider, __) {
              return ListView.builder(
                  itemCount: matchesProvider.matchesList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return matchesProvider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MatchCardWeidget(
                            matchid:
                                matchesProvider.matchesList[index].matchId!,
                            title:
                                matchesProvider.matchesList[index].leagueName,
                            team1Logo:
                                matchesProvider.matchesList[index].team1!.logo!,
                            team2Logo:
                                matchesProvider.matchesList[index].team2!.logo!,
                            team1Score: matchesProvider
                                .matchesList[index].score!.fullTime!.team1!,
                            team2Score: matchesProvider
                                .matchesList[index].score!.fullTime!.team2!,
                            team1Name:
                                matchesProvider.matchesList[index].team1!.name!,
                            team2Name:
                                matchesProvider.matchesList[index].team2!.name!,
                          );
                  });
            }),
          ),
        ],
      ),
    ));
  }
}
