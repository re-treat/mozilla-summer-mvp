class Exercise {
  String id;
  String name;
  String image;
  List<String> labelsTargetEmotion;
  List<String> labelsCauseOfEmotion;
  List<String> labelsEffectAndGoal;
  List<Instruction> instructions;
  List<String> references;

  Exercise(String id, String name, String image,
      List<String> labelsTargetEmotion, List<String> labelsCauseOfEmotion, List<String> labelsEffectAndGoal){
    this.id = id;
    this.name = name;
    this.image = image;
    this.labelsTargetEmotion = labelsTargetEmotion;
    this.labelsCauseOfEmotion = labelsCauseOfEmotion;
    this.labelsEffectAndGoal = labelsEffectAndGoal;

    this.instructions = new List<Instruction>();
    this.references = new List<String>();
  }

  void addInstruction(String type, String content){
    var instruction = Instruction(type, content);
    this.instructions.add(instruction);
  }

  void addReference(String reference){
    this.references.add(reference);
  }

  String toString() {
    return
      """
      name: ${this.name}
      id:   ${this.id}
      image:${this.image}
      labelsTargetEmotion: ${this.labelsTargetEmotion.length}
      labelsCauseOfEmotion: ${this.labelsCauseOfEmotion.length}
      labelsEffectAndGoal: ${this.labelsEffectAndGoal.length}
      instructions: ${this.instructions.length}
      references: ${this.references.length}
      """;
  }
}

class Instruction {
  String type;
  String content;
  Instruction(this.type, this.content);
}


/*
Map<String, Exercise> exercises = {

  'visualizing_best_possible_self': Exercise(
    id: 'visualizing_best_possible_self',
    name: 'Visualizing Best Possible Self',
    image: 'images/visualizing-best-possible-self-mostafa-meraji.jpeg',
    labelsTargetEmotion: ['paralyzed', 'pessimistic', 'vulnerable'],
    labelsCauseOfEmotion: ['work', 'academics', 'interpersonal relationships'],
    labelsEffectAndGoal: ['confident', 'motivated'],
    instructions: [
      Instruction(
          type: 'pure instruction',
          detail:
          'Imagine what is it like to live the best possible self in the future. You may consider just one aspect of your life or multiple of them, like your work, your social relationships and things you love to do.'),
      Instruction(
          type: 'text entry',
          detail:
          'Use specific words to describe your visions for that best possible future, and try to focus on future and details: when, where, who...'),
    ],
    whyItWorks: [
      'Sheldon, K. M., & Lyubomirsky, S. (2006). How to increase and sustain positive emotion: The effects of expressing gratitude and visualizing best possible selves. Journal of Positive Psychology, 1(2), 73-82.'
    ],
  ),
  'feeling_compassion_for_yourself': Exercise(
    id: 'feeling_compassion_for_yourself',
    name: 'Feeling Compassion for Yourself',
    image: 'images/feeling-compassion-for-yourself-timothy-l-brock.jpeg',
    labelsTargetEmotion: ['vulnerable', 'guilty', 'self-conscious'],
    labelsCauseOfEmotion: [
      'work',
      'academics',
      'financial',
      'interpersonal relationships'
    ],
    labelsEffectAndGoal: ['relieved', 'confident'],
    instructions: [
      Instruction(
          type: 'pure instruction',
          detail:
          'To re-direct our compassion to ourselves, let\'s together draft a letter to reflect on something distressing happening to you during the day.'),
      Instruction(
          type: 'text entry',
          detail:
          'To start this letter, first let’s briefly describe the event that was distressing for you by 1 sentence and feel that part of you that can be kind and understanding of others...'),
      Instruction(
          type: 'text entry',
          detail:
          'From a first-person perspective, write down 1-2 sentences of what you would say to a friend in your position, or what a friend would say to you in this situation.'),
      Instruction(
          type: 'text entry',
          detail:
          'Then write down 1-2 sentences showing understanding and validation for your distress and the reason behind it.'),
      Instruction(
          type: 'text entry',
          detail:
          'End the letter with a sentence/phrase for yourself that you think you need to hear in order to feel nurtured and soothed about your stressful situation or event.'),
    ],
    whyItWorks: [
      'Breines, J. G., & Chen, S. (2012). Self-compassion increases self-improvement motivation. Personality and Social Psychology Bulletin, 18(9), 1133-1143.',
      'Shapira, L. B., & Mongrain, M. (2010). The benefits of self-compassion and optimism exercises for individuals vulnerable to depression. Journal of Positive Psychology, 5, 377-389.'
    ],
  ),
  'get_it_started_5_step_tackling_procrastination_bit_by_bit': Exercise(
    id: 'get_it_started_5_step_tackling_procrastination_bit_by_bit',
    name: 'Get It Started: 5-Step Tackling Procrastination Bit by Bit',
    image:
    'images/get_it_started-5-step-tackling-procrastination-bit-by-bit-sarah-kilian.jpeg',
    labelsTargetEmotion: ['paralyzed', 'stressed', 'frustrated'],
    labelsCauseOfEmotion: [
      'work',
      'academics',
    ],
    labelsEffectAndGoal: ['motivated'],
    instructions: [
      Instruction(
          type: 'pure instruction',
          detail:
          'Acknowledge the distress: Without judging or criticizing yourself, take a moment to acknowledge and accept that you are, to a certain extent, disturbed by some kind of task that you think "I should do it today" but feel reluctant to start in it.'),
      Instruction(
          type: 'text entry',
          detail:
          'Break it up: Let\'s break the task or the event that may sound intimidating into 3-5 smaller, specific and manageable steps. For example, when you plan to write an essay, you 1) brainstorm, 2) outline, 3) draft, 4) polish, 5) ask for advice, 6) final draft and submit.'),
      Instruction(
          type: 'text entry',
          detail:
          'Find meaning and purpose: Reflect on what are some potential impact of the work you are going to do. Can you think of the meaning of this task for you or for somebody else, for now or for the future.'),
      Instruction(
          type: 'text entry',
          detail:
          'A ritual for starting: While starting the task may sound unpleasant in anyway, why don\'t we create a little 5-10min ritual for ourselves to kick start the work and bring in some excitement. For someone this starting ritual can be a cup of coffee, a quick journal entry, a post-it notes or a youtube video. Come up with your starting ritual today.'),
      Instruction(
          type: 'text entry',
          detail:
          'Treat yourself for hitting the goal: Envision how you will treat yourself after finishing this task or one of the steps. Or, you can also imagine some positive feelings you might have upon successfully accomplishing what you want to achieve today.'),
    ],
    whyItWorks: [
      'The Why of Work (2010) by Dave Ulrich, Marshall Goldsmith, and Wendy Ulrich',
      'Atomic Habits: An Easy & Proven Way to Build Good Habits & Break Bad Ones (2018)  by James Clear',
      'Flett, A. & Pychyl, T.A. (2014). Procrastination, Rumination, and Distress in Students: An Analysis of the Roles of Self-Compassion and Mindfulness. Poster to be presented at the Canadian Psychological Association Annual Conference.',
      'Sirois, F. & Pychyl, T.A. (2013). Procrastination and the priority of short-term mood regulation: Consequences for future self. Social and Personality Psychology Compass, 7, 115-127. DOI: 10.1111/spc3.12011.',
      'http://cogbtherapy.com/cbt-blog/2013/12/25/5-tips-to-curb-procrastination',
      'https://www.sciencedirect.com/science/article/pii/S1747938X18300472',
    ],
  ),
  'directing_kindness_to_yourself': Exercise(
    id: 'directing_kindness_to_yourself',
    name: 'Directing Kindness to Yourself',
    image: 'images/directing-kindness-to-yourself-chris-liu.jpeg',
    labelsTargetEmotion: [
      'stressed',
      'regretful',
      'frustrated',
      'vulnerable',
      'guilty',
      'self-conscious'
    ],
    labelsCauseOfEmotion: [
      'work',
      'academics',
      'financial',
      'interpersonal relationships'
    ],
    labelsEffectAndGoal: ['relaxed', 'relieved', 'confident'],
    instructions: [
      Instruction(
          type: 'pure instruction',
          detail:
          'What does it mean to be kind to ourselves and to accept ourselves? Let\'s start with the three components of self-compassion.'),
      Instruction(
          type: 'text entry',
          detail:
          'Recognize our discomfort as an unavoidable part of every human being - Do you think at this moment, there are someone else who are experiencing similarly uncomfortableness as you are? If yes, take a moment to imagine 1 or 2 example(s) of another person\'s discomfort.'),
      Instruction(
          type: 'text entry',
          detail:
          'Face our painful thoughts directly, but not exaggerate them - Let\'s retell what\'s troubling ourselves right now by 2-3 sentences. How would you describe what is making you feel bad and why?'),
      Instruction(
          type: 'text entry',
          detail:
          'Treat ourselves kindly when we perceive our inadequacy - At this moment, could you write down a short note that is caring, non-judgmental and accepting to yourself?'),
    ],
    whyItWorks: [
      'Neff, K. D. (2003a). Self-compassion: An alternative conceptualization of a healthy attitude toward oneself. Self and Identity, 2, 85–101. doi:10.1080/15298860309032.',
      'https://link.springer.com/article/10.1007/s11031-008-9119-8',
      'https://link.springer.com/article/10.1007/s11031-008-9119-8',
    ],
  ),
  'reframe_your_negative_thoughts': Exercise(
    id: 'reframe_your_negative_thoughts',
    name: 'Reframe Your Negative Thoughts',
    image: 'images/reframe-your-negative-thoughts-aziz-acharki.jpeg',
    labelsTargetEmotion: [
      'stressed',
      'frustrated',
      'self-conscious',
      'worried',
      'pessimistic',
    ],
    labelsCauseOfEmotion: [
      'work',
      'academics',
      'financial',
      'interpersonal relationships'
    ],
    labelsEffectAndGoal: ['relieved', 'confident', 'thankful', 'relaxed'],
    instructions: [
      Instruction(
          type: 'pure instruction',
          detail:
          'Reframing is a simple cognitive-behavioral tool you can resort to when any negative thought comes to your mind. To reframe, we simply turn our attention from things disturbing us to things that you feel positive about at this moment. For example, when we enter a strange space, our first thought might be "I hate the color of the wall". By reframing, we shift our mind away from the wall to other more pleasant stimuli in the room, like a beautiful carpet in the room.'),
      Instruction(
          type: 'text entry',
          detail:
          'This is a very simple 1-step exercise: Let\'s list out such things around you now that bring any kind of positivity and if you have time, try to add in some details about why they make you feel positively. Feel free to select from the emoji board to help you brainstorm' +
              smile.code),
    ],
    whyItWorks: [
      'Anderson, J. (2014, June 12). 5 get-positive techniques from cognitive behavioral therapy. Retrieved from http://www.everydayhealth.com/hs/major-depression-living-well/cognitive-behavioral-therapy-techniques/'
    ],
  ),
  'feeling_the_vastness_practice_awe_narrative': Exercise(
    id: 'feeling_the_vastness_practice_awe_narrative',
    name: 'Feeling the Vastness: Practice Awe Narrative',
    image:
    'images/feeling-the-vastness-practice-awe-narrative-mostafa-meraji.jpeg',
    labelsTargetEmotion: [
      'stressed',
      'frustrated',
      'self-conscious',
      'worried',
      'regretful',
    ],
    labelsCauseOfEmotion: [
      'work',
      'academics',
      'financial',
      'interpersonal relationships'
    ],
    labelsEffectAndGoal: ['relieved', 'thankful', 'relaxed'],
    instructions: [
      Instruction(
          type: 'pure instruction',
          detail:
          'This is a simple one-step exercise. Think back to a time when you felt a sense of awe regarding something you witnessed or experienced. Awe can be elicited in many ways, like when you witness the natural beauty or when you are impressed by a brilliant story. Sometimes negative events can also elicit awe, like natural disasters that make us feel overwhelmed and small.'),
      Instruction(
        type: 'text entry',
        detail:
        'Write down 2-4 sentences to describe one moment when you felt awe with as many details as possible. Not only include the thing that makes you feel this sense of awe, but also what exactly you were feeling at that moment. (Did you have a new understanding of the world or your life? Was there a sense of a small self or a broadened world? etc.)',
      ),
    ],
    whyItWorks: [
      'Rudd, M., Vohs, K. D., & Aaker, J. (2012). Awe expands people’s perception of time, alters decision making, and enhances well-being. Psychological Science, 23(10), 1130-1136.',
    ],
  ),
  'learn_and_practice_financial_self_care': Exercise(
    id: 'learn_and_practice_financial_self_care',
    name: 'Learn and Practice Financial Self-Care',
    image: 'images/learn-and-practice-financial-self-care-fotografierende.jpeg',
    labelsTargetEmotion: [
      'stressed',
      'frustrated',
      'worried',
      'pessimistic',
      'paralyzed',
      'vulnerable',
    ],
    labelsCauseOfEmotion: [
      'financial',
    ],
    labelsEffectAndGoal: ['relaxed', 'relieved', 'confident', 'motivated'],
    instructions: [
      Instruction(
          type: 'text entry',
          detail:
          'Let\'s actually start thinking and talking about our financial issues and money first. What does money make you feel? What are the first things coming to your mind when thinking about money?'),
      Instruction(
          type: 'text entry',
          detail:
          'Face your fear and anxiety: What are the exact thing(s) about money or budget that makes you feel in such ways? Write down 1-2 sentence with specific language to summarize the source of your emotion.'),
      Instruction(
          type: 'text entry',
          detail:
          'Find what you haven\'t been clear about and what you can control: It is hard to assess our financial health if money in our mind is just a vague idea and we are afraid of actually knowing the numbers. Can you list out several financial items (e.g. your monthly income, monthly expenditure on food) that you haven\'t had a clear picture (i.e. the exact number) of?'),
      Instruction(
          type: 'text entry',
          detail:
          'Find what we can control and set up feasible goals: If we don\'t know where we are going to, we will not know how we can get there. Instead of a general statement like "I don\'t want to spend too much" or "I want financial stability", let\'s list out 3 to-do items that are related to what we can control and are action-oriented. An example can be "I want to print out my bank statement and review the deductions."'),
      Instruction(
          type: 'pure instruction',
          detail:
          'Take actions for step 3 and 4:) 70% people avoided talking about financial concerns, but today you have managed to start this conversation and plan for your next steps. Cheers!'),
    ],
    whyItWorks: [
      'https://www.lendingclub.com/research/financial-health',
      'https://blog.lendingclub.com/financial-self-care',
      'https://www.helpguide.org/articles/stress/coping-with-financial-stress.htm',
    ],
  ),
  'your_assertive_script_build_assertiveness_for_yourself': Exercise(
    id: 'your_assertive_script_build_assertiveness_for_yourself',
    name: 'Your Assertive Script: Build Assertiveness for Yourself',
    image:
    'images/your-assertive-script-build-assertiveness-for-yourself-thom-holmes.jpeg',
    labelsTargetEmotion: [
      'stressed',
      'frustrated',
      'vulnerable',
      'worried',
      'disappointed',
      'self-conscious'
    ],
    labelsCauseOfEmotion: ['work', 'academics', 'interpersonal relationships'],
    labelsEffectAndGoal: ['relieved', 'confident'],
    instructions: [
      Instruction(
          type: 'pure instruction',
          detail:
          'Recognize Your Rights. Behind a feeling of anxious, depressed or unfulfilled, sometimes deep down in our mind there is a sense of our rights being denied or neglected. First step is always recognition. Can you recollect the recent circumstances that you felt in such ways, and detail in how your rights, wishes or ideas were not valued or acknowledged.'),
      Instruction(
          type: 'text entry',
          detail:
          'Practice Your Assertive Script. We all have a right to express our thoughts, feelings, and needs to others, as long as we do so in a respectful but assertive way. Assertiveness can be learned through scripting. For the following prompt, please use 1 sentence for each to practice your own assertive script: \n \u{2192} An objective and detailed description of the situation that troubles you without accusing or assuming others. What did the other(s) actually do? \n \u{2192} An "I statement" like "I feel __ because ___" of your feeling that will help you take responsibility for yourself. \n \u{2192} Describe the changes you would like to make or see. That is, to make some reasonable requests and make them specific and clear.'),
      Instruction(
          type: 'text entry',
          detail:
          'Mental Broken Record. This is a technique you can use in real-life or in your mind, just by repeating the last part of the step 2, making reasonable and assertive requests, over and over in a calm and peaceful way, regardless of what responses you get. You can either mentally repeat this sentence to yourself or type it again.'),
    ],
    whyItWorks: [
      'Chapter 13: Assertiveness Training of Psychological Self-Help (1996) by Dr. Clayton E. Tucker-Ladd.',
      'Speed, B. C., Goldstein, B. L., & Goldfried, M. R. (2017). Assertiveness Training: A Forgotten Evidence‐Based Treatment. Clinical Psychology: Science and Practice.',
      'When I say no, I feel guilty (1975) by Manuel J. Smith',
    ],
  ),
};
 */