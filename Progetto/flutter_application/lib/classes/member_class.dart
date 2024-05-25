import 'package:flutter/material.dart';
import 'package:flutter_application/classes/all.dart';

class Member {
  String name;
  String surname;
  String role;

  String getMemberName() {
    return name;
  }

  bool exists(Member otherMember) {
    
    if(this.name.toLowerCase() == otherMember.name.toLowerCase() &&
    this.surname.toLowerCase() == otherMember.surname.toLowerCase() &&
    this.role.toLowerCase() == otherMember.role.toLowerCase()) return true;
    return false;
  }

  

  Member(this.name, this.surname, this.role);
}