class Exercise {
  String id;
  String name;
  String image;
  List<String> labelsTargetEmotion;
  List<String> labelsCauseOfEmotion;
  List<String> labelsEffectAndGoal;
  List<Instruction> instructions;
  List<String> whyItWorks;

  Exercise(
      {this.id,
      this.name,
      this.image,
      this.labelsTargetEmotion,
      this.labelsCauseOfEmotion,
      this.labelsEffectAndGoal,
      this.instructions,
      this.whyItWorks});
}

class Instruction {
  String type;
  String detail;
  Instruction({this.type, this.detail});
}
