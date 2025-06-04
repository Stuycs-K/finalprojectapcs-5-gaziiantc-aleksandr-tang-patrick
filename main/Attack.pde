enum Attack{
   //very basic actions, take n as parameter
  
   PAUSE, //Pause until space bar
   LASER, //Spawn a laser
   FRAMES, //Wait n frames
   TRAIN, //Spawn a train
   SEL, //add n objects to selection
   DESEL, //remove n objects from selection, removes from the end. 
   ALTDESEL, //remove n objects from selection, removes from the start. 
   FREEZE, //Set dy + dx of the first n selected objects in selection to 0
   MULSPEED, //Multiply speed of selected objects by n;

   //Memory management
 
   ALLOC, //Creates an array of size n ; TBH this is stupid and I should just use an arraylist instead but it's just cooler this way
   SELINDEX, //Selects index n in the array
   WRITE, //Writes value to index n in the array 
   
   //Functions with _ mean that they use the selected memory value in them. arr[index] is the selected value. 
   
   MUL_N_SPEED, //Multiplies the speed of the first n selected objects by arr[index]
}
