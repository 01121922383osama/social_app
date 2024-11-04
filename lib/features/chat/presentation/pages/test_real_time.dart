import 'package:flutter/material.dart';
import 'package:social_app/ecport_injection.dart';

class TestRealTime extends StatefulWidget {
  const TestRealTime({super.key});

  @override
  State<TestRealTime> createState() => _TestRealTimeState();
}

class _TestRealTimeState extends State<TestRealTime> {
  List<ExtractName> names = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Real Time'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('name').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator.adaptive();
          }
          final data = snapshot.data!.docs;
          for (var i = 0; i < data.length; i++) {
            names.add(ExtractName.fromJson(data[i].data()));
          }
          return ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  'name: ${names[index].name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ExtractName {
  final String name;

  ExtractName({required this.name});

  factory ExtractName.fromJson(Map<String, dynamic> json) {
    return ExtractName(name: json['name']);
  }
}
