class Setting {
  String name;
  int number;

  String getName(){
    return name;
  }

  int getNumber(){
    return number;
  }

  Setting({required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
    };
  }
}