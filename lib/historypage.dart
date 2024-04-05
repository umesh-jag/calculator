import 'package:calculator/history.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  void deleteAllHistory() {
    setState(() {
      history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("History")),
        actions: [
          GestureDetector(
            onTap: deleteAllHistory,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final calculation = history[index];
          return Padding(
            padding: const EdgeInsets.all(12),
            child: ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  calculation.expression,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
              ),
              subtitle: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "=${calculation.result}",
                  style: const TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 100, 98, 98)),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              isThreeLine: true,
              dense: true,
              visualDensity: VisualDensity.compact,
              horizontalTitleGap: 0,
            ),
          );
        },
      ),
    );
  }
}
