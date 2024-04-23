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


### PINGPONG

## Paper Prototype:


https://github.com/UoB-COMSM0110/2024-group-2/assets/97231049/45da8ef0-ad25-4813-b634-399775141c4c

## Introduction
Our team’s game is developed based on the well-known tank battle game. For the purpose of making our game more enjoyable and entertaining compared with the classic one on the Internet, we added some new twists to the game, such as one-player mode (the AI mode), map shuffle, and so on. Besides, we also made some improvements to the game's interaction design, which could be more surprising and immersive for players. These distinct features mentioned above brought us lots of challenges during the development process. Therefore, it was reasonable for us to use some development techniques throughout like agile workflow to manage the development cycle and improve our development capability. 

### Requirements

**Ideation, Use-cases and User stories**

To start the ideation process, each team member had the task to come up with at least two game ideas. We then met together to discuss the possible game ideas. After going through the details of each idea, we decided on two games: a game similar to Pong but with a few twists and a tank-battle game where the terrain changes randomly after a certain period of time. For both games we designed the initial requirements based on a use-case diagram, use-case specifications and user stories. We then used these to create mock-up paper prototypes for both games. These paper-prototypes were then used to create videos that provide a simple demonstration of how both the Pong and the Tank games would be played. Shortly after we met again and decided to pursue the tank-battle game as our final idea.
<br>

<img src="/ReportMaterial/paperProtoGif.gif">

<br>


**User stories**
* As a single player, I want a fun, challenging game that I can improve at over time .
* As a single player, I would like to be able to set the difficulty level so that as improve I can keep the game interesting by playing against a more challenging AI opponent.
* As multiplayer, I want to be able to play the game with my friends (online)
* As a player, I would like the game to have lots of different maps to keep the game interesting the more I play.
* As a player, I would like to be able to upgrade my tank and weapons as I earn points throughout the game
* As a marker, I want a game that I can learn to play quickly that demonstrate what students have learned during the module
* As developers, we want to create a game that is fun to play and satisfies the assignement requirements.
* (As an online player, I would like to have skill-based matching so that I can player against players online who are of similar ability.)
* As developers we want to engage with players to see what features are most important to them.

<br>

**Use case diagram**

![UML diagram](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/UML_diagram.png)

<br>

**User case specifications**

*No map shuffle*

<img src="/ReportMaterial/UserCaseSpecNoShuffle2.png"/>

<br>

*Map shuffle*

<img src="/ReportMaterial/UserCaseSpecShuffle2.png"/>

<br>

**Statement of Services**

>With our game, one or two players will be able to engage in tank-battle style gameplay as they attempt to defeat the other player before losing themselves. When the game first loads, the user can choose to view the instructions or play with one or two other players. The arrow keys are used to control the tank and  the space bar, ‘-‘ and ‘=’ buttons are used to control the shot trajectory. With our "twist," the existing map is shuffled to provide fresh, unpredictable landscapes for the player to explore.

<br>

**Inputs and Situations**

The user can use the keyboard to interact with the game. Using left and right keys will move the tank along the map. The user can angle the tank barrel by using the up and down arrow. When the map shuffle is activated, a the terrain will be re-generated into a new and different map. The damage to each tank, money collected and weapons’ stock remains the same. The round is won when the user destroys the opponent’s tank. After each round, the user will be taken to a ‘shop’ where they’ll be able to buy assorted weaponry to aid in their next round. When all rounds are finished an end game screen will be displayed with the results and they will have the option to play again or exit the game.

<br>

**Constraints**

We made the decision to include a time limit for how long a user can take to complete their move. This is to avoid slow gameplay and to not allow users total freedom when planning their move. This way, the users feel the pressure to making their decisions propmtly and does not allow them to take advantage of an infinite round, they will always be constrined by a time limit.

---


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

## Implementation

When planning this project, the three prospective challenges we identified were:

1. The physics of projectile trajectory
2. Implementing damage to the terrain
3. Endless map generation

Ultimately, the second two of these challenges proved to be rather trivial to implement. As there are no complex textures in our game, we were able to base collisions on pixel colour detection. This meant that damage to the terrain could be implemented by drawing a sky-blue circle over the terrain where projectiles impacted. Endless map generation was also straightforward to implement. A random waveform shape could be generated using the built-in `noise()` function. This has a random component so whenever a map shuffle or new round begins, a new and different terrain shape could be easily generated. Retrospectively, we were able to identify two alternative challenges:

* Game state switching and integration
* A computer-controlled opponent for single player mode

### 1. The physics of projectile trajectory

The trajectory of the missile needed to look realistic. To achieve this, we needed to update the x and y positions of the missile each frame after a missile has been fired until impact. In order to do this, we used trigonometry to calculate and initial `xSpeed` and `ySpeed` as a factor of shot power. After each call of `Weapon.update()` the missile's x position would update by `+xSpeed` and its y position by `+ySpeed`. `ySpeed` would also decrement by a constant value (g) each call to simulate the effect of gravity. The position of the weapon would stop upon impact, detected by monitioring the pixel colour at the missiles location, and a yellow circle would be drawn at a reduced frame rate to simulate an explosion. There were several iterations of this function before the realistic final representation was achieved.

### 2. Game state switching and integration

#### 2.1. State Transition Logic Management
While developing the GameStart class for the Tank Battle game's start interface, we faced the challenge of efficiently managing the transition logic between different button selections, such as moving from the start menu to single-player, two-player, or viewing the game instructions. Furthermore, to ensure the game's fluidity, multiple states needed to be seamlessly integrated, and we determined that implementing this functionality in the Main class would be more appropriate. However, we needed to ensure the accuracy and appropriateness of the timing and logic of state transitions.

*Solution:*
The logic for game state transitions relies directly on the `mousePressed()` method, which uses conditional checks to centrally manage user click events and directly updates the gameState variable to effect state transitions. For example, it determines whether a click is within the `1 Player` or `2 Players` button areas and, based on the result, hardcodes a state transition to `GameState.GAME_PLAY_1` or `GameState.GAME_PLAY_2`. This method centralizes all state transition logic within the event handling function, facilitating the tracking and maintenance of state flow.

In the Main class, we manage different game states through a central control mechanism (gameState and playingState). Within the `draw()` function, we employ a switch-case statement based on the current gameState to decide which module of the code to execute, ensuring the proper timing of game state transitions. This setup guarantees that each state has a clear entry and exit point, enhancing the structure and manageability of state transitions.

#### 2.2. Validating User Input
Validating user input for setting the number of game rounds presents a significant programming challenge. It is crucial to ensure that the input is a valid and reasonable number.

*Solution:*
The `setNumberOfRounds()` method is implemented with recursive calling to enforce the entry of a valid number of game rounds. If the user inputs an invalid number (either non-numeric or less than or equal to zero), the method recursively calls itself until valid input is received. This approach simplifies the error-handling logic and ensures the accuracy of the input.

#### 2.3. Asynchronous Operations and State Consistency
In the game, certain operations such as AI calculations and resource loading may require asynchronous processing. These asynchronous operations must be synchronized with the game's main state mechanism to prevent issues where operations are not completed before a state transition occurs.

*Solution:*
Time control variables such as `endRound` and `shuffleDelay` are used to manage the timing of state transitions, ensuring that all necessary preliminary operations are completed before any critical state changes are made.

### 3. A computer controlled opponent for single-player mode

A computer-controlled opponent needed to be able to carry out several tasks autonomously:

* Fire at the opponent tank accurately
* Purchase items from the shop between rounds
* Select an appropriate weapon from its inventory

Although it is possible for tanks to move over the terrain and adjust their turret angle during the game, our lead developer reasoned that this would not be necessary in order for a computer-controlled tank to operate effectively. Thus, its position was fixed and its turret angle fixed at either 45 degrees or 135 degrees depending on the direction of its opponent, with a view to these angles allowing the tank to accurately fire at most positions on the map, simply by varying the shot power. Thus, for the first task we needed to devise a way of accurately calculating the required power to hit the opponent. In the first instance, our developer reasoned that the point of the parabola at which `ySpeed` was zero should be realised at the halfway point of the parabola. Thus, he reasoned that the required power could be calculated as shown below:

![CPU fire attempt 1](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/ai_attempt1.png)

Although this proved relatively accurate over some distances it proved to be an over simplification so an alternative method needed to be implemented. After some research our developer found the following trajectory formula and rearranged it to solve for v:

![CPU fire attempt 2](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/ai_attempt2.png)

* y is the y position of the opponent
* x is the x position of the oppnent
* theta is the launch angle i.e., 45 degrees
* g is the acceleration due to gravity
* v is the required power

This method was almost 100% accurate. In easy mode, the power calculated was doubled every other shot to reduce the computer controlled tank's accuracy to 50%.

In order to automate purchasing from the shop a simple algorithm was devised by which the computer controlled tank would purchase the most expensice weapon it could with its available funds and iterate this process until it could no longer purchase anymore weapons. Finally, to allow switching between weapons a method was written which meant that the computer controlled tank would always used the most powerful weapon in its inventory.

## Evaluation

We divided the evaluation into two phases. The first phase used qualitative methods and the second phase used a combination of qualitative and quantitative methods. Through the two phases of evaluation, we found some bugs in the code and user interaction problems, and improved them to make our game more reasonable in design and more playable.

**Stage 1 Qualitative Evaluations:**

>*Think Aloud Evaluation 1: 11/03/2024*
>>Positives:
>> 1. Smoothness of the landscape seems to be good.
>>Negatives: 
>> 1. Player not sure what objective is nor how to play, as no instructions or start screen are presented.
>> 2. There was no indication of which character/tank the player was controlling.
>> 3. No indication of when the turn to play is switched to the player.
>> 4. Accidently pressed space bar too long which led to firing for opponent, which could be explored for cheating.


>*Think Aloud Evaluation 2: 11/03/2024*
>>Positives:
>>  1.	Health bars good are a good feature.
>> Negatives:
>>  1.	Need to implement more features that allow for strategic gameplay.
>>  2.	Loop hole which allows cheating, specifically when firing. 
>>  3.	Game can drag for too long, as there is no time limit, and subsequent pressure, for each player to make a move.
>>  4.	Certain aspects can allow players to cheat.


>*Heuristic Evaluation 1: 11/03/2024*    
>>| Interface | Issue | Heuristic | Frequency | Impact | Persistence | Severity |
>>|---------- |------- | --------- | --------------- | ------------ | ----------------- | -------------------- |
>>| Game Page | Control can be hard to get used to | User control and freedom | 2 | 3 | 0 | 1.7 |
>>| Game Page | The movement of tank can break gravity constraints | Metaphor | 2 | 4 | 4 | 3.3 |
>>| Game Page | Shoot straight if tank barrel if completly horizontal | Metaphor | 3 | 1 | 4 | 2.6 |
>>| Game Page | No damage to tank unless directly hit | Metaphor | 3 | 2 | 4 | 3 |


Based on the feedbacks from our first stage think alouds and heuristic evaluation, we found that most problems come up when game was on and focused on mathematical logic and tank-player interaction. So we needed to review corresponding codes and changed them in order to make our game more grounded in reality. This will also make us more aware of this aspect in the future developmemt;


## Conclusion
During the development of this game, we realized that teamwork and the assistance of   professional techniques are indispensable. They helped us to manage the development cycle and improve the efficiency of the development. In the early stages of the game development, our team lagged behind other teams considering that we didn’t make good use of the agile development technique or communicate on a consistent basis. After we realized this problem, our team decided to work collectively offline to develop this game   and maintain communication online and offline, which sped up our development process and made our game more attractive. Although our requirements were changing from time to time, we were still capable of implementing them well thanks to the flexibility of the agile development technique. The problems raised in project development made us realize that completing a project requires not only strong coding skills but also teamwork and professional approaches.

The game we have now is quite completed but we can go further to add some interesting features to it such as upgrades and teleportation. We can even make the game run online and players can archive it when they are offline, which will make our game more playable and make it possible to build a commercial-quality game.


