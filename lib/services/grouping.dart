import 'package:boodschappen/models/boodschappen_items.dart';

class Grouping {

  Map<String, List<Boodschap>> group (List<Boodschap> items) {
    final Map<String, List<Boodschap>> grouped = {};

    for (var item in items) {
      grouped.putIfAbsent(item.naam, ()=> []);
      grouped[item.naam]!.add(item);
    }

    return grouped;
  }

}
