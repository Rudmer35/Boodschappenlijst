import 'package:flutter/material.dart';

class WeekPlanning extends StatefulWidget {
  const WeekPlanning({super.key});

  @override
  State<WeekPlanning> createState() => _WeekPlanningState();
}

class _WeekPlanningState extends State<WeekPlanning> {
  final days = [
    'Maandag',
    'Dinsdag',
    'Woensdag',
    'Donderdag',
    'Vrijdag',
    'Zaterdag',
    'Zondag',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: days.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 150,
          child: Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    days[index],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 32,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
