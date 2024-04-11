## group photo
![WechatIMG376](https://p.ipic.vip/zxwuml.jpg)


# 2024-group-2
game idea

## ping pong game 
URL: https://openprocessing.org/sketch/821675

## twist: 
Based on the games aboves, add some attributes of board when game's on, such as: expanding, shrinking, even inertia

## challenge:
how to define the class board and add new features on it


## Tanks
* Based on the tanks game
* Two player vs or single player vs AI
* Earn money for damging your opponent
* opportunity to use earnings for upgrades between levels: buying new weapons or ungrading tank
* Items: fuel, teleport, repair kit
* Move and adjust barrel angle with arrow keys
* Power bar to adjust power, could control with + and - keys

### Potential twists:
* Shot clock to add time pressure
* Map shuffle, i.e., option to randomly change the terrain/move the players around the map
* Wind change
* Earn rewards for completing objectives e.g., using certain weapons or winning the level in a certain number of turns
* Online multiplayer. This may be too challenging to implement.

### Challenges;
* Physics of the projectile trajectory
* Implementing damage to terrain
* Endless map generation: maybe random wave form to determine terrain?

### Paper Prototype:


https://github.com/UoB-COMSM0110/2024-group-2/assets/97231049/cf039080-044a-4d90-8d83-29755e836485


## PINGPONG

### Paper Prototype:


https://github.com/UoB-COMSM0110/2024-group-2/assets/97231049/45da8ef0-ad25-4813-b634-399775141c4c

## Requirements

### 
* Singler player
* Multiplayer player
* Markers
* Us as developers

### User stories
* As a single player, I want a fun, challenging game that I can improve at over time .
* As a single player, I would like to be able to set the difficulty level so that as improve I can keep the game interesting by playing against a more challenging AI opponent.
* As multiplayer, I want to be able to play the game with my friends (online)
* As a player, I would like the game to have lots of different maps to keep the game interesting the more I play.
* As a player, I would like to be able to upgrade my tank and weapons as I earn points throughout the game
* As a marker, I want a game that I can learn to play quickly that demonstrate what students have learned during the module
* As developers, we want to create a game that is fun to play and satisfies the assignement requirements.
* (As an online player, I would like to have skill-based matching so that I can player against players online who are of similar ability.)
* As developers we want to engage with players to see what features are most important to them.

### Use case diagram

![UML diagram](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/UML_diagram.png)

## Design

Based on the requirements, we were able to formulate a system architecture. The user would first interact with a start menu where they would be able to view instructions, and select single, or multiplayer game modes. This start screen would represent the start game state and selecting a play mode would transition the player into one of the two playing game states. Within the playing state, would be able to move their tank, adjust shot power and angle and fire a shot. We decided to have a Main class that would handle game state switching and running the gameplay engine. As processing is an object-oriented language, we determined that all other game objects (e.g., the tank, power bar, health bar, weapon display, weapon) would be best represented as ancillary classes with proprietary methods to execute their required functions. Between rounds a shop game state would also be launched to allow players to purchase additional items to improve their gameplay.

### Class diagram

This [class diagram](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/Tanks_Class_Diagram.png) represents the final implementation of our game. For simplicity, the getting and setting methods for the majority of private class attributes have not been shown. In retrospect, we could have made more use of inheritance to simplify the codebase. More specifically, the design could be improved by having an abstract GameScreen class from which the Shop, GameOver, and GameStart classes inherit, as these classes share common functionality with very similar implementations of button drawing and detection of button pressing. This highlights the importance of investing time in designing a software system upfront, before beginning to implement it. This is particularly evident for a project in which several members of the team are developing features concurrently, as duplication of effort for similar features can happen which would likely have been avoided by a single developer. However, it is often difficult to fully anticipate all design considerations upfront. As we adopted an agile approach to development for this project, we decided to prioritise producing a minimum viable product early in the development cycle over investing more time in considering the design of the software system.

![Class diagram](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/Tanks_Class_Diagram.png)

### Communication diagrams

As many of our classes are aggregations of other classes in the game, we realised that it would be important to model how user interactions would be communicated between those classes to achieve the desired outcomes. For what we perceived to be the more complicated communication flows, we decided to make communication diagrams to support design and implementation of these interactions. Below is a communication diagram for when an actor clicks on a button to purchase an item in the shop. The Shop class needs to initiate communications as follows:

* get the price of that item from the associated Item object
* communicate with the current player (Tank) object to see if there are enough funds to purchase this item
* if there are send a message to the Tank object to buy this item decreasing the Tank's total money
* the tank object will in turn send a message to weapon class object which corresponds to that item type so that the count is increased
* the shop will then update its display to reflect the Tank's new item count for the purchased item and the money left to spend.

![Purchasing an item from the shop](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/shopPurchase_communication.png)

We also designed a communication diagram for firing a weapon; which proved to have a complex series of communications between objects. Before firing, the objects will need to communicate to determine shot power and trajectory. After impact, objects will need to communicate to determine if the shot impacted the opponent and to adjust the health and money of the respective players accordingly, as well as displaying any damage done by the weapon to the map.

![Firing a shot](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/fireWeapon_communication.png)

While the above diagram was somewhat useful in helping is to think about implementing this feature of the game, it is difficult to interpret due to the number of messages which are sent between objects. In practice it also proved not to capture the true complexity of the interactions with many more messages actually sent in the final implementation. The inability to represent control flow in communication diagrams also limits their usability.


