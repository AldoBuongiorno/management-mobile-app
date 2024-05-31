import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';

class Team {
  String name;

  String getName() {
    return name;
  }

  Team({required this.name});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Team{name: $name}';
  }


}