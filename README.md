# NutriLink-Assessment-2
This repository explores an OOP application developed through Swift UI. Nutrilink is an IOS application that represents a complete provess of developing a app solution and design that assists people in improving eating habits for a healthier lifestyle. The app acheives this through meal suggestion and nutrition tracking. Furthermore, users can set and manage tasks in order to achieve specific goals. 

The app showcases both object-oriented and protocol oriented design, in order to achieve what had been proposed in the project proposel for Assessment Task 1.

# **Features**

The following features are integrated in the application to achieve a satisfactory app design for users:

> Meal Suggestion

- Allows users to add ingredients interactively and attain recommended recipes based on the ingredients that are inputted.
- The recipes that are provided include ingredients, instructions and the cooking time (below 20 minutes for user convinience).
- The view also intakes user preferences entered in the app in order to custom the type of meals they want to attain,

> Nutrition Dashboard

- Tracks the calorie of meal intake by the user through a meal log. Users can enter their meals consumed for the day through from the meal suggestion tab.
- Provides the Goal set for calorie intake for the day, calories consumed and the remaining calories until the goal is reached.
- A progress bar is provided to see how close the user is to reach their daily goal.

> Task Manager

- Users can add, edit and delete tasks.
- Organize tasks based in categories (Personal, Shopping, Meal Preperation).
- Toggle tasks that are complete.
- Sample tasks are provided to assist users.

> Preferences

- Users can set dietary preferences (vegetarian, vegan, gluten-free, etc).
- Set a daily calorie goal
- Option to include quick meals only.

# **Object-Oriented Concepts**

To develop the application, the following object oriented concepts were integrated to ensure common functionality through all views:

> Classes/Structs/Enums:

- Task
- TaskStore
- Recipe
- MealSuggestionViewModel
- UserPreferences
- DietType
  
> Encapsulation:

- In regard to this each model that is developed utilises its own data and behaviour for the convinience of developing the views.

> Composition:

- Tasks can include a variety of types such as shopping items or specific recipe (related recipes) without the use of subclasses.

# **Protocol-Oriented Design**

- FilterableMeal protocol develops a contract for any function setting preference for user meals.
- Recipe utilises FilterableMeal by implementing the "matches" function.
- The Validatable protocol defines a re-usable valodation rules for models like Task
- Protocol extensions were used in order toenable flecible behaviours for specific classes without utilising an inheritence model.

# **User Interface (UI)**

The UI was developed through the following views:

- IngredientInputView – Enables adding ingredient, validating recipe inputs, and triggering filters via preferences and ingredients listed. 
- RecipeListView – Display the suggested meals provided by the app database. 
- RecipeDetailView – Display the ingredients of the recipe and details such as the cooking details. User are also provided a button that can allow them to log the recipe in the log list.
- DailyNutritionView – Provides a dashboard with statistical cards and pregress bar of user nutrition intake and goals.  
- PreferencesView – Adjust the dietary preferences to custom meal recommendations 
- TaskListView / TaskEditorView – Manage and filter the tasks that are added.

# **Error Handling**

- Input validation is included in IngredientInputView: users are prevented from entering empty or duplicate ingredients in the list, where an alert is provided when this action ios commited.
- No Result Alert: when there are no recipes that match with user preferences, an alert is provided to users.
- Input Validation: the Task section implements Validatable protocol to ensure tasks have valid formats.

# **Author**
The project is develope by Shaiyan Khan for Assessment Task 2 of Advanced IOS Development.

  







  

