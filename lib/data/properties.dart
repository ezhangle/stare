const List<String> moods = [
  "Do Not Disturb",
  "Angry",
  "Sad",
  "Tired",
  "Calm",
  "Happy",
  "Delighted",
];
const List<String> exerciseOptions = [
  "Eye",
  "Posture",
  "Breathing",
  "Before-Bed",
  "Morning",
];
const Map<String, List<Map<String, String>>> exerciseSubOptions = {
  "Eye": [
    {
      "title": "Rapid Eye Movement",
      "duration": "2 min",
      "description":
          "Rapid eye movements to break the stale nature of your eyes. Facilitates your eye muscles.",
    },
    {
      "title": "Blink",
      "duration": "1 min",
      "description":
          "Blinking lubricates and cleans your eyes by spreading your tears over its outer surface.",
    },
    {
      "title": "Warm Compress",
      "duration": "5 min",
      "description":
          " A warm compress is an easy way to increase blood flow to sore areas of your body. This increased blood flow can reduce pain.",
    },
  ],
  "Posture": [],
  "Breathing": [],
  "Before-Bed": [],
  "Morning": [],
};
const List<String> performOptions = [
  "Mindfulness",
  "Relax",
  "Meditation",
  "Sleep",
];
const List<String> months = [
  'JANUARY',
  'FEBRUARY',
  'MARCH',
  'APRIL',
  'MAY',
  'JUNE',
  'JULY',
  'AUGUST',
  'SEPTEMBER',
  'OCTOBER',
  'NOVEMBER',
  'DECEMBER'
];
const Map<int, List<bool>> ledNumberDisplay = {
  0: [true, true, true, false, true, true, true],
  1: [false, false, true, false, false, true, false],
  2: [true, false, true, true, true, false, true],
  3: [true, false, true, true, false, true, true],
  4: [false, true, true, true, false, true, false],
  5: [true, true, false, true, false, true, true],
  6: [true, true, false, true, true, true, true],
  7: [true, false, true, false, false, true, false],
  8: [true, true, true, true, true, true, true],
  9: [true, true, true, true, false, true, true],
  10: [false, false, false, false, false, false, false],
};
const List<String> alarmSounds = [
  "Choose your own >",
  "Drumbeats",
  "Rooster",
  "Tinkle",
  "Claps",
  "Bells",
  "Heavy Metal"
];
