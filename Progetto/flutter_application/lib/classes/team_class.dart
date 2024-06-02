import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';

class Team {
  String name;
  AssetImage thumbnail;

  String getName() {
    return name;
  }

  AssetImage getThumbnail() {
    return thumbnail;
  }

  Team({required this.name, required this.thumbnail,});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'thumbnail': thumbnail.assetName,
    };
  }

  @override
  String toString() {
    return 'Team{name: $name, ${(thumbnail).assetName}}';
  }


}