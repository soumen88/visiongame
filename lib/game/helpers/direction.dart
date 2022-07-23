import 'dart:math';

enum Direction { up, down, left, right, none }

extension DirectionEnumsExt on Direction {
  static List<Direction> generateRandomDifficultyLevel(int n) {
    var rnd = Random();
    return List.generate(n, (i) => Direction.values[rnd.nextInt(Direction.values.length)]);
  }

  static List<Direction> generateRandomUniqueLevelTwo(int n) {
    var list = List<Direction>.from(Direction.values)..shuffle();
    return list.take(n).toList();
  }

  static Direction generateRandomUniqueDirection() {
    var list = List<Direction>.from(Direction.values)..shuffle();
    Direction randomDirection;
    if(list.first == Direction.none){
      randomDirection = Direction.down;
    }
    else{
      randomDirection = list.first;
    }
    return randomDirection;
  }

}
