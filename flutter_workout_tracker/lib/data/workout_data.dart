import 'package:flutter/material.dart';
import 'package:flutter_workout_tracker/models/exercise.dart';

import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  /*
  WORKOUT DATA STRUCTURE
  - this overall list contains the different workouts
  - Each workout has a name, and list of excercises
  */

  List<Workout> workoutList = [
    // default workout
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(
          name: "Bicep Curls",
          weight: "10",
          reps: "10",
          sets: "3",
        )
      ],
    ),
    Workout(
      name: "Lower Body",
      exercises: [
        Exercise(
          name: "Squats",
          weight: "20",
          reps: "10",
          sets: "3",
        )
      ],
    ),
  ];

  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // get length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout releventWorkout = getReleventWorkout(workoutName);

    return releventWorkout.exercises.length;
  }

  // add a workout
  void addWorkout(String name) {
    // add a new workout with a blank list of exercises
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  // add an exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    // find the relevent workout
    Workout releventWorkout = getReleventWorkout(workoutName);

    releventWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
      ),
    );

    notifyListeners();
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    // find the relevent workout and relevent exercise in that workout
    Exercise releventExercise = getReleventExercise(workoutName, exerciseName);

    // check off boolean to show user completed the workout
    releventExercise.isCompleted = !releventExercise.isCompleted;

    notifyListeners();
  }

  // return relevent workout object, given a workout name
  Workout getReleventWorkout(String workoutName) {
    Workout releventWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return releventWorkout;
  }

  // return relevent exercise object, given a workout name + exercise name
  Exercise getReleventExercise(String workoutName, String exerciseName) {
    // find relevent workout first
    Workout releventWorkout = getReleventWorkout(workoutName);

    // then find the relevent exercise in that workout
    Exercise releventExercise = releventWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return releventExercise;
  }  
}
