class GhostPositionModel{
  bool isLeft;
  bool isDown;
  bool isXAxisMovement;
  bool isYAxisMovement;

  GhostPositionModel({required this.isLeft,required this.isDown,required this.isXAxisMovement, required this.isYAxisMovement});

  @override
  String toString() {
    return 'GhostPositionModel{isLeft: $isLeft, isDown: $isDown, isXAxisMovement: $isXAxisMovement, isYAxisMovement: $isYAxisMovement}';
  }
}