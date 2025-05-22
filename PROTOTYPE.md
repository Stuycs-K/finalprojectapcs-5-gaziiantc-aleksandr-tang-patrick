Period 5

Members: Aleksandr Gaziiantc, Patrick Tang

Group Name: Better than (F)Art Majors 


Project Description: This game is a tower defense game where you try and protect your base from attacks. You can spend money to buy building defenses, such as a wood plank or a metal sheet, or special defenses, such as a void or black hole spell. Attacks will become progressively harder and in greater number.



Critical Features: First we make physics, then we add gameplay. These are the required features. 
Nice to have features: Multiplayer PVP
Diagrams

![image](https://github.com/user-attachments/assets/fac54002-5361-4e1d-870a-b6f93a9b8bba)

![image](https://github.com/user-attachments/assets/bab33820-3c73-4390-98fd-2296761bd0be)

![image](https://github.com/user-attachments/assets/e85c9c3c-b670-46ae-9029-1f236c137c59)

Nice to have features:
![image](https://github.com/user-attachments/assets/157cf15b-f2ce-4843-8280-be41f1cd4cea)




# Technical Details:

We will be using a stack to make fast collision detection

# Project Design

![image](https://github.com/user-attachments/assets/39f1c8c4-cb6a-4cb7-8e36-9629b4a913b1)


Objects will be handled with an abstract AObject class. This AObject class will contain some basic info about the object and an abstract tick() method. 

Every single object will be taking up a certain number of chunks. Chunks will be a grid of 4x4 pixels that span the entire screen. Only one object can take up the chunk at a time. That is how the physics will work. Chunks will be stored in the object using a Stack.

The center will contain an object that the player will have to build defenses for. The building system will not be bound by chunks, but it will take up chunks because stuff will be needing to collide with it.


    
# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

A timeline with expected completion dates of parts of the project. (CHANGE THIS!!!!!)

