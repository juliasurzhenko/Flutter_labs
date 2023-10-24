import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FamilyExpenseTrackerApp extends StatefulWidget {
  const FamilyExpenseTrackerApp({Key? key}) : super(key: key);

  @override
  _FamilyExpenseTrackerAppState createState() =>
      _FamilyExpenseTrackerAppState();
}

class _FamilyExpenseTrackerAppState extends State<FamilyExpenseTrackerApp> {
  List<FamilyMember> familyMembers = [
    FamilyMember('Батько', 0.0),
    FamilyMember('Мати', 0.0),
    FamilyMember('Дитина 1', 0.0),
    FamilyMember('Дитина 2', 0.0),
  ];

  String selectedMember = 'Батько';
  double expenseAmount = 0.0;

  void addExpense() {
    final member = familyMembers.firstWhere((m) => m.name == selectedMember);
    member.expenses += expenseAmount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Витрати сім\'ї'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: selectedMember,
              items: familyMembers.map((member) {
                return DropdownMenuItem<String>(
                  value: member.name,
                  child: Text(member.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMember = newValue ?? 'Батько';
                });
              },
            ),
            TextField(
              onChanged: (value) {
                expenseAmount = double.tryParse(value) ?? 0.0;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Сума витрат'),
            ),
            ElevatedButton(
              onPressed: () {
                addExpense();
              },
              child: const Text('Додати витрати'),
            ),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: familyMembers
                      .map((member) => PieChartSectionData(
                            title: member.name,
                            value: member.expenses,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyMember {
  String name;
  double expenses;

  FamilyMember(this.name, this.expenses);
}

void main() {
  runApp(const MaterialApp(
    home: FamilyExpenseTrackerApp(),
  ));
}
