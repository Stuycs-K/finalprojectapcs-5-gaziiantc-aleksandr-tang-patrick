Period 5

Members: Aleksandr Gaziiantc, Patrick Tang

Group Name: 







Critical Features: First we make physics, then we add gameplay. These are the required features. 
Nice to have features: Multiplayer PVP
Diagrams

![image](https://github.com/user-attachments/assets/f80c1f82-36f6-4c8b-be68-d4bd06547dfe)



# Technical Details:

We will be using a stack to make fast collision detection

# Project Design

![image](https://github.com/user-attachments/assets/75676294-061d-449d-81c2-7dd7c356e8cd)


Objects will be handled with an abstract AObject class. This AObject class will contain some basic info about the object and an abstract tick() method. 

Every single object will be taking up a certain number of chunks. Chunks will be a grid of 4x4 pixels that span the entire screen. Only one object can take up the chunk at a time. That is how the physics will work. Chunks will be stored in the object using a Stack.

The center will contain an object that the player will have to build defenses for. The building system will not be bound by chunks, but it will take up chunks because stuff will be needing to collide with it.


    
# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

A timeline with expected completion dates of parts of the project. (CHANGE THIS!!!!!)

