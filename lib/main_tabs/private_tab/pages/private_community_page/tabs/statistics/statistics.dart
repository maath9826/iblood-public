import 'package:flutter/material.dart';
import 'package:iblood/providers/private_communities_provider.dart';
import 'package:iblood/widgets/popable_page.dart';

import 'widgets/capsule_card.dart';
import 'widgets/statistics_section.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final _statistics = PrivateCommunitiesProvider.currentPrivateCommunity!.statistics;

  late List<Statistic> _membersStatistics;
  late final List<List> _bloodGroupsStatistics;

  late List<Statistic> _donorsStatistics;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _membersStatistics = [
      Statistic(label: 'Total', icon: Icons.people, count: _statistics.totalMembers),
      Statistic(label: 'Males', icon: Icons.male, count: _statistics.males),
      Statistic(label: 'Females', icon: Icons.female, count: _statistics.females),
    ];

    _bloodGroupsStatistics = [
      [
        Statistic(label: 'A+', count: _statistics.bloodGroupsNumbers['aPos']!),
        Statistic(label: 'A-', count: _statistics.bloodGroupsNumbers['aNeg']!),
        Statistic(label: 'B+', count: _statistics.bloodGroupsNumbers['bPos']!),
        Statistic(label: 'B-', count: _statistics.bloodGroupsNumbers['bNeg']!),
      ],
      [
        Statistic(label: 'AB+', count: _statistics.bloodGroupsNumbers['abPos']!),
        Statistic(label: 'AB-', count: _statistics.bloodGroupsNumbers['abNeg']!),
        Statistic(label: 'O+', count: _statistics.bloodGroupsNumbers['oPos']!),
        Statistic(label: 'O-', count: _statistics.bloodGroupsNumbers['oNeg']!),
      ],
    ];

    _donorsStatistics = [
      Statistic(label: 'Total', icon: Icons.person_pin, count: _statistics.totalDonors),
      Statistic(label: 'Male donor', icon: Icons.male, count: _statistics.maleDonors),
      Statistic(label: 'Female donor', icon: Icons.female, count: _statistics.femaleDonors),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatisticsSection(
            statistics: _membersStatistics,
            label: 'Members',
          ),
          StatisticsSection(
            label: 'Blood Groups',
            customBody: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: _bloodGroupsStatistics
                    .map(
                      (row) => Row(
                        children: row.map((el) {
                          if (isNegativeBloodGroup(el.label)) {
                            return CapsuleCard(
                              footerLabel: '${el.count}',
                              headerLabel: el.label,
                              headerColor: const Color(0xfff64747),
                              headerBackgroundColor: const Color(0xfffba3a3),
                            );
                          }
                          return CapsuleCard(
                            footerLabel: '${el.count}',
                            headerLabel: el.label,
                          );
                        }).toList(),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          StatisticsSection(
            statistics: _donorsStatistics,
            label: 'Donors',
          ),
        ],
      ),
    );
  }

  isNegativeBloodGroup(String bloodGroup) {
    if (bloodGroup[bloodGroup.length - 1] == '-') return true;
    return false;
  }
}

class Statistic {
  final String label;
  final IconData? icon;
  int count;

  Statistic({
    required this.label,
    required this.count,
    this.icon,
  });
}
