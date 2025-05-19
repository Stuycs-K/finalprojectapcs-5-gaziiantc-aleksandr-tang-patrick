Period 5

Members: Aleksandr Gaziiantc, Patrick Tang

Group Name: 







Critical Features: First we make physics, then we add gameplay. These are the required features. 
Nice to have features: Multiplayer PVP
Diagrams

![image](https://github.com/user-attachments/assets/c6d3f27b-9015-4f67-bdc5-359bb8f5cc4b)


# Technical Details:

We will be using a stack to make fast collision detection

# Project Design

![image](https://github.com/user-attachments/assets/1ce60827-d4e1-4d6d-b55c-f0a49d89178f)

Objects will be handled with an abstract AObject class. This AObject class will contain some basic info about the object and an abstract tick() method. 

Every single object will be taking up a certain number of chunks. Chunks will be a grid of 4x4 pixels that span the entire screen. Only one object can take up the chunk at a time. That is how the physics will work. Chunks will be stored in the object using a Stack.

The center will contain an object that the player will have to build defenses for. The building system will not be bound by chunks, but it will take up chunks because stuff will be needing to collide with it.


    
# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

A timeline with expected completion dates of parts of the project. (CHANGE THIS!!!!!)

