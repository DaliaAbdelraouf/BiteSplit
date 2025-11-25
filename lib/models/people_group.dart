import 'package:hive/hive.dart';

part 'people_group.g.dart'; 

@HiveType(typeId: 1)
class PeopleGroup extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> people;

  PeopleGroup({required this.name, required this.people});
}
