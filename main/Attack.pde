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
 
   ALLOC, //Creates an array of doubles of size n ; TBH this is stupid and I should just use an arraylist instead but it's just cooler this way
   SELINDEX, //Selects index n in the array
   WRITE, //Writes value n to the selected index in the array
   
   ALLOCOBJ, //Creates an array of objects of size n ; same thing as the other alloc.
   
   BUFFERLASTOBJ, //buffers the last selected object to index n of the array as well as binds it to the "last object" pointer.
   
   WRITEVLASTOBJ, //writes the total velocity of the last selected object to index n of the array. Binds the used object to a pointer. 
   WRITEVSELOBJ, //writes the total velocity of the object that was appointed by the previous function. 

   WRITEVLASTOBJ, //writes the total velocity of the last object in selection and put sit into the Selected Index of ALLOC.
   WRITEVOBJ, //writes the total velocity of the nth object in AllocObj and puts 
   
   
   //Logic
   
   IFLESSTHAN, //Compares selected index of n, if it is false it skips the next instruction, otherwise it skips the instruction after, In theory if loops are possible then this would make the program turing complete. 
   ELSE, //Syntax for the above function, refer to the explanation below tbh. n does not matter for this function.
   END, //More syntax for the if statement. Also applies to the WHILELESSTHAN. 
   /*
     IFLESSTHAN-N-Instruction1-N-ELSE-N-Instruction2-N-ENDIF
     If sel < N, Instruction 1 gets executed and Instruction 2 does not. 
     If sel > N, Instruction 2 gets executed and Instruction 1 does not. 
     ELSE and ENDIF allow for usage of more than 1 instruction per case. 
     No else or endif will result in everything crashing and burning. There is no compile time checking. 
   */
  
   WHILELESSTHAN, //Like IFLESSTHAN, but it repeats the instructions in front instead of branching. This should in theory make the level editor turing complete. Requires END to not crash. 
   
   //Functions with _ mean that they use the selected memory value in them. arr[index] is the selected value. 
   
   MUL_N_SPEED, //Multiplies the speed of the first n selected objects by arr[index]
}
