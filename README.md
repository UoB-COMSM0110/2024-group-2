# 2024-group-2

## Game video

[<img src="/ReportMaterial/TitleScreen.png" />](https://youtu.be/UvxcvMR0Fco)

Click here [here](https://youtu.be/UvxcvMR0Fco) or on the image above to watch our game video!

## Group photo

![WechatIMG376](https://p.ipic.vip/zxwuml.jpg)

From left to right:

* **Hamish Partington**, fw23740@bristol.ac.uk, hamishpartington
* **Dominic Barros**, mq23630@bristol.ac.uk, domgb19
* **Jinnan Lu**, wi23748@bristol.ac.uk, JinnanLu
* **Jianzhao Mai**, ou23341@bristol.ac.uk, StrongMak
* **Hanyang Lin**, xf23024@bristol.ac.uk, huiyuanaidianxfx

## Introduction

Our team’s game is developed based on the well-known tank battle game. For the purpose of making our game more enjoyable and entertaining compared with the classic one on the Internet, we added some new twists to the game, such as one-player mode (the AI mode), map shuffle, and so on. Besides, we also made some improvements to the game's interaction design, which could be more surprising and immersive for players. These distinct features mentioned above brought us lots of challenges during the development process. Therefore, it was reasonable for us to use some development techniques throughout like agile workflow to manage the development cycle and improve our development capability.

## Requirements

### Ideation

To start the ideation process, each team member had the task to come up with at least two game ideas. We then met together to discuss the possible game ideas. After going through the details of each idea, we decided on two games: a game similar to Pong but with a few twists and a tank-battle game where the terrain changes randomly after a certain period of time. For both games we designed the initial requirements based on a use-case diagram, use-case specifications and user stories. We then used these to create mock-up paper prototypes for both games. These paper-prototypes were then used to create videos that provide a simple demonstration of how both the Pong and the Tank games would be played. Shortly after we met again and decided to pursue the tank-battle game as our final idea. The details of these two game ideas are below.

#### Pong game

An idea that needs no introduction; based on the classic pong game.

Potential twists:

* Expanding/shrinking paddles
* Inertia of paddles

Challenge:

* How to define the class board and add new features on it

##### Pong Paper Prototype

https://github.com/UoB-COMSM0110/2024-group-2/assets/97231049/45da8ef0-ad25-4813-b634-399775141c4c

<br>

<img src="/ReportMaterial/paperProtoGif.gif">

<br>

#### Tanks

Initial idea:

* Based on the tanks game
* Two player vs or single player vs AI
* Earn money for damaging your opponent
* Opportunity to use earnings for upgrades between levels: buying new weapons or ungrading tank
* Items: fuel, teleport, repair kit
* Move and adjust barrel angle with arrow keys
* Power bar to adjust power, could control with + and - keys

Potential twists:

* Shot clock to add time pressure
* Map shuffle, i.e., option to randomly change the terrain/move the players around the map
* Earn rewards for completing objectives e.g., using certain weapons or winning the level in a certain number of turns
* Online multiplayer. This may be too challenging to implement.

Potential challenges:

* Physics of the projectile trajectory
* Implementing damage to terrain
* Endless map generation: maybe random wave form to determine terrain?

##### Tanks Paper Prototype

https://github.com/UoB-COMSM0110/2024-group-2/assets/97231049/cf039080-044a-4d90-8d83-29755e836485

### User stories

* As a single player, I want a fun, challenging game that I can improve at over time .
* As a single player, I would like to be able to set the difficulty level so that as improve I can keep the game interesting by playing against a more challenging AI opponent.
* As a multiplayer, I want to be able to play the game with my friends.
* As a player, I would like the game to have lots of different maps to keep the game interesting the more I play.
* As a player, I would like to be able to upgrade my tank and weapons as I earn points throughout the game
* As a marker, I want a game that I can learn to play quickly that demonstrate what students have learned during the module
* As developers, we want to create a game that is fun to play and satisfies the assignement requirements.
* As developers we want to engage with players to see what features are most important to them.

### Use case diagram

![UML diagram](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/UML_diagram.png)

### User case specifications

#### No map shuffle

<img src="/ReportMaterial/UserCaseSpecNoShuffle2.png"/>

#### Map shuffle

<img src="/ReportMaterial/UserCaseSpecShuffle2.png"/>

### Statement of Services

>With our game, one or two players will be able to engage in tank-battle style gameplay as they attempt to defeat the other player. When the game first loads, the user can choose to view the instructions or play with one or two other players. The arrow keys are used to control the tank and  the space bar, `-` and `=` buttons are used to control the shot trajectory. With our "twist," the existing map is shuffled to provide fresh, unpredictable landscapes for the player to explore.

### Inputs and Situations

The user can use the keyboard to interact with the game. Using left and right keys will move the tank along the map. The user can angle the tank barrel by using the up and down arrow. When the map shuffle is activated, a the terrain will be re-generated into a new and different map. The damage to each tank, money collected and weapons' stock remains the same. The round is won when the user destroys the opponent's tank. After each round, the user will be taken to a 'shop' where they will be able to buy assorted weaponry to aid in their next round. When all rounds are finished, an end game screen will be displayed with the results and they will have the option to play again or exit the game.

### Constraints

We made the decision to include a time limit for how long a user can take to complete their move. This is to avoid slow gameplay and to not allow users total freedom when planning their move. This way, the users feel the pressure to making their decisions propmtly and does not allow them to take advantage of an infinite round.

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

While the above diagram was somewhat useful in helping us to think about implementing this feature of the game, it is difficult to interpret due to the number of messages which are sent between objects. In practice it also proved not to capture the true complexity of the interactions with many more messages actually sent in the final implementation. The inability to represent control flow in communication diagrams also limits their usability.

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

Although this proved relatively accurate over some distances it proved to be an over simplification so an alternative method needed to be implemented. After some research our developer found the following trajectory formula and rearranged it to solve for *v*:

![CPU fire attempt 2](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/ai_attempt2.png)

* *y* is the y position of the opponent
* *x* is the x position of the oppnent
* *theta* is the launch angle i.e., 45 degrees
* *g* is the acceleration due to gravity
* *v* is the required power

This method was almost 100% accurate. In easy mode, the power calculated was doubled every other shot to reduce the computer controlled tank's accuracy to 50%.

In order to automate purchasing from the shop a simple algorithm was devised by which the computer controlled tank would purchase the most expensive weapon it could with its available funds and iterate this process until it could no longer purchase anymore weapons. Finally, to allow switching between weapons a method was written which meant that the computer controlled tank would always used the most powerful weapon in its inventory.

## Evaluation

We divided the evaluation into two phases. The first phase used qualitative methods and the second phase used a combination of qualitative and quantitative methods. Through the two phases of evaluation, we found some bugs in the code and user interaction problems, and improved them to make our game more reasonable in design and more playable.

### Stage 1: Qualitative Evaluations

>*Think Aloud Evaluation 1: 11/03/2024*
>>Positives:  
>>
>> 1. Smoothness of the landscape seems to be good.
>>
>>Negatives:
>>
>> 1. Player not sure what objective is nor how to play, as no instructions or start screen are presented.
>> 2. There was no indication of which character/tank the player was controlling.
>> 3. No indication of when the turn to play is switched to the player.
>> 4. Accidently pressed space bar too long which led to firing for opponent, which could be exploited for cheating.

>*Think Aloud Evaluation 2: 11/03/2024*
>>Positives:  
>>
>> 1. Health bars good are a good feature.
>>
>>Negatives:
>>
>> 1. Need to implement more features that allow for strategic gameplay.
>> 2. Loop hole which allows cheating, specifically when firing. 
>> 3. Game can drag for too long, as there is no time limit, and subsequent pressure, for each player to make a move.
>> 4. Certain aspects can allow players to cheat.

>*Heuristic Evaluation 1: 11/03/2024*
>>| Interface | Issue | Heuristic | Frequency | Impact | Persistence | Severity |
>>|---------- |------- | --------- | --------------- | ------------ | ----------------- | -------------------- |
>>| Game Page | Control can be hard to get used to | User control and freedom | 2 | 3 | 0 | 1.7 |
>>| Game Page | The movement of tank can break gravity constraints | Metaphor | 2 | 4 | 4 | 3.3 |
>>| Game Page | Shoot straight if tank barrel is completly horizontal (no gravity effect on projectile) | Metaphor | 3 | 1 | 4 | 2.6 |
>>| Game Page | No damage to tank unless directly hit | Metaphor | 3 | 2 | 4 | 3 |

Based on the feedback from our first stage think alouds and heuristic evaluation, we found that most problems were related to mathematical logic and tank-player interaction. So we needed to refine the corresponding code to make our game more grounded in reality.

### Stage 2: Qualitative Evaluations

>*Think Aloud Evaluation 3: 15/04/2024*
>>Positives:
>>
>> 1. The start screen's button layout is clearly designed, facilitating user navigation and smooth entry into the game.
>> 2. The weapon purchasing feature in the shop effectively extends player engagement time.
>> 3. Earning coins by hitting enemy tanks enhances players' sense of achievement.
>>
>>Negatives:
>>
>> 1. The rules of the game are unclear, especially regarding which player starts first.
>> 2. The cursor design, while thematically consistent with tanks, resembles the tanks used in gameplay, which can confuse players.
>> 3. There is little distinction between Easy and Hard modes, making the Easy mode challenging for players.

>*Think Aloud Evaluation 4: 15/04/2024*
>>Positives:
>>
>> 1. When the map shuffle bar is empty, updating the terrain and resetting coins and weapons provide new opportunities for gameplay.
>> 2. Using the `-` and `=` keys to adjust missile size and shooting power enhances the game's flexibility and efficiency.
>>
>>Negatives:
>>
>> 1. The background styles of the start screen and the shop are inconsistent.
>> 2. After pressing the space bar, there is a significant delay before the projectile hits the target.
>> 3. If the health bar is not depleted, the game may enter an infinite loop state, with no option for players to pause the game.

During the second phase of our Think Aloud evaluation, our user interface design and feature expansion received numerous positive reviews. One month after our initial assessment, we have thoroughly addressed user requirements and anticipated functional features based on use cases and story points, achieving the desired experience for our Tank Battle game. We developed a more precise auto-targeting AI for the single-player mode and addressed the physics calculations for missile trajectories. While many issues identified in the first-phase evaluation have been substantially resolved, feedback from the second phase suggests there is still room for improvement in optimizing the gaming experience, particularly in reducing the stress players may feel during gameplay. This will be the primary focus of our team's efforts moving forward.

### Quantitative evaluation - NASA TLX

>**Evaluating one player's game**
>>**Evaluation 1 - 'Easy' mode**
>>
>>*Scores*
>>| Tester ID | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
>>|-----------|----|----|----|----|----|----|----|----|----|----|
>>| Mental demand   | 75 | 65 | 65 | 70 | 75 | 65 | 60 | 60 | 65 | 70 |
>>| Physical demand | 5  | 5  | 0  | 5  | 0  | 5  | 5  | 5  | 0  | 0  |
>>| Temporal demand | 55 | 60 | 55 | 55 | 60 | 60 | 60 | 55 | 60 | 55 |
>>| Performance     | 25  | 60 | 65 | 40  | 60 | 45 | 50 | 55 | 60 | 55 |
>>| Effort          | 65 | 65 | 65 | 60 | 65 | 55 | 65 | 55 | 60 | 60 |
>>| Frustration     | 25  | 35  | 25  | 25  | 40  | 30  | 35  | 40  | 45 | 25  |
>>
>>*Dimension weighting*
>>| Tester ID | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
>>|-----------|---|---|---|---|---|---|---|---|---|----|
>>| Mental demand   | 4 | 3 | 4 | 3 | 4 | 4 | 2 | 1 | 3 | 4 |
>>| Physical demand | 0 | 1 | 0 | 0 | 0 | 1 | 0 | 2 | 0 | 1 |
>>| Temporal demand | 2 | 3 | 4 | 2 | 3 | 2 | 4 | 3 | 3 | 2 |
>>| Performance     | 4 | 3 | 3 | 5 | 3 | 4 | 4 | 4 | 4 | 4 |
>>| Effort          | 2 | 3 | 3 | 4 | 3 | 3 | 4 | 2 | 3 | 3 |
>>| Frustration     | 3 | 2 | 1 | 1 | 2 | 1 | 1 | 3 | 2 | 0 |
>>
>>*Final Scores*
>>| Score Type | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
>>|------------|----|----|----|----|----|----|----|----|----|----|
>>| Raw        | 42 | 48 | 46 | 43 | 50 | 43 | 46 | 45 | 48 | 44 |
>>| Weighted   | 48 | 55 | 60 | 52 | 62 | 51 | 57 | 46 | 59 | 57 |
>>
>>**Evaluation 2 - 'Hard' mode**
>>
>>*Scores*
>>| Tester ID     | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
>>|---------------|----|----|----|----|----|----|----|----|----|----|
>>| Mental demand | 75 | 70 | 70 | 75 | 80 | 75 | 65 | 70 | 70 | 80 |
>>| Physical demand| 5  | 5  | 0  | 5  | 0  | 5  | 5  | 5  | 0  | 0  |
>>| Temporal demand| 55 | 50 | 45 | 50 | 55 | 55 | 50 | 45 | 55 | 50 |
>>| Performance   | 45 | 70 | 55 | 60 | 60 | 50 | 70 | 60 | 55 | 50 |
>>| Effort        | 65 | 75 | 70 | 65 | 75 | 65 | 70 | 65 | 70 | 60 |
>>| Frustration   | 55 | 50 | 65 | 60 | 55 | 50 | 65 | 55 | 60 | 50 |
>>
>>*Dimension weighting*
>>|   Tester ID   | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
>>|---------------|----|----|----|----|----|----|----|----|----|----|
>>| Mental demand | 5  | 5  | 4  | 4  | 4  | 3  | 5  | 4  | 4  | 3  |
>>| Physical demand | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 1 |
>>| Temporal demand | 4 | 4 | 3 | 3 | 4 | 4 | 4 | 4 | 5 | 4 |
>>| Performance     | 2 | 3 | 4 | 3 | 1 | 2 | 1 | 2 | 2 | 3 |
>>| Effort          | 1 | 0 | 1 | 0 | 1 | 3 | 1 | 0 | 2 | 1 |
>>| Frustration     | 3 | 3 | 3 | 4 | 5 | 3 | 4 | 4 | 2 | 3 |
>>
>>*Final Scores*
>>| Score Type | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
>>|------------|----|----|----|----|----|----|----|----|----|----|
>>| Raw        | 50 | 53 | 51 | 53 | 54 | 50 | 54 | 50 | 52 | 48 |
>>| Weighted   | 61 | 61 | 60 | 58 | 60 | 59 | 62 | 58 | 62 | 53 |
>>
> **Statistical testing**  
> We carried out sattistical testing of this data using the Wilcoxon Signed-Rank Test which is tailored for the analysis of dual assessments conducted by an individual participant. The aim is to ascertain the presence of a statistically significant variance in the perceived workload across two levels of difficulty within a single-player mode of our game. This investigation seeks to establish whether the differing designs manifestly alter the user experience.  
>>
>> **Wilcoxon sign-ranked test**  
>> We choose to test the NASA TLX data with weights as detailed in the following steps:  
>>
>> *1. Data and Calculation Steps*  
>> Weighted NASA TLX data pairs:  
>>| Easy | Hard |
>>|------|------|
>>| 48   | 61   |
>>| 55   | 61   |
>>| 60   | 60   |
>>| 52   | 58   |
>>| 62   | 60   |
>>| 51   | 59   |
>>| 57   | 62   |
>>| 46   | 58   |
>>| 59   | 62   |
>>| 57   | 53   |
>>
>> * Calculate Differences: For each pair of data (*x*, *y*), compute *x* - *y*.
>> * Rank the Differences: Rank the absolute values of the differences, assigning ranks to each. In case of ties, average ranks are assigned (a standard method for handling ties in rankings).  
>> * Assign Signs to Ranks: Assign signs to the ranks based on the positive or negative nature of the differences.  
>> * Compute the W Value: The W value is the sum of the smaller rank totals (i.e., the sum of either all the positive ranks or all the negative ranks, whichever is less).  
>>  
>> *2. Manual Example Calculation*  
>>| Data Pair (*x*, *y*) | *x* - *y* (Difference) | Abs Difference | Rank | Signed Rank |
>>|------------------|--------------------|----------------|------|-------------|
>>| (48, 61)         | -13                | 13             | 5.5  | -5.5        |
>>| (55, 61)         | -6                 | 6              | 4    | -4          |
>>| (60, 60)         | 0                  | 0              | -    | 0           |
>>| (52, 58)         | -6                 | 6              | 4    | -4          |
>>| (62, 60)         | 2                  | 2              | 2    | 2           |
>>| (51, 59)         | -8                 | 8              | 7    | -7          |
>>| (57, 62)         | -5                 | 5              | 3    | -3          |
>>| (46, 58)         | -12                | 12             | 5.5  | -5.5        |
>>| (59, 62)         | -3                 | 3              | 1    | -1          |
>>| (57, 53)         | 4                  | 4              | 2.5  | 2.5         |
>>
>> * Rank Assignment: Note that the ranking here is based on the absolute value of the differences, with ties in absolute value (like -6 and -6) sharing the same average rank (4). Differences of zero are typically excluded from the rank assignment.  
>>  
>> * Calculate the W Value:  
>> Positive rank sum = 2 + 2.5 = 4.5  
>> Negative rank sum = |−5.5| + |−4| + |−4| + |−7| + |−3| + |−5.5| + |−1| = 30  
>> In the Wilcoxon Signed-Rank Test, we typically take the smaller of the positive or negative rank sums as the W value. In this instance, W = 4.5.  
>>  
>> * Look up the calculated W test statistic in the table of critical values  
>> ![Critical values](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/ReportMaterial/TableofCriticalValues.png)
>>  
>> Given that the sample size is n=10, the table does not display a value directly corresponding to a W value of 4.5. This is because the table typically lists only integer W values, and our W value is 4.5. In practice, we commonly round down the W value to the nearest whole number for p-value determination, thus we use W = 4.
>>
>> With n=10 paired samples and a critical W value of 5 at an α=0.025 significance level, our calculated W value of 4.5 (rounded down to 4) is less than 5. This indicates that at the α=0.025 level, there is a statistically significant difference in the medians between the two sets of data. Therefore, we can reject the null hypothesis, concluding that there is a significant difference in workload between the "Easy" and "Hard" modes.
>>
**Quantitative evaluation - SUS**  
To investigate the system usability of two player modes, we selected the System Usability Scale (SUS) as the measurement tool. This approach required users to rate 10 items using a 5-point Likert scale, ranging from "strongly disagree" to "strongly agree," corresponding to scores from 1 to 5. Below are the final statistical results of the survey:

>>| Tester ID | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
>>|-----------|---|---|---|---|---|---|---|---|---|----|
>>| I think that I would like to use this system frequently | 4 | 4 | 4 | 4 | 3 | 4 | 4 | 4 | 3 | 4 |
>>| I found the system unnecessarily complex | 3 | 2 | 3 | 3 | 2 | 3 | 3 | 3 | 2 | 3 |
>>| I thought the system was easy to use | 4 | 3 | 3 | 3 | 3 | 4 | 4 | 4 | 3 | 3 |
>>| I think that I would need the support of a technical person to use the system | 2 | 2 | 2 | 2 | 2 | 2 | 1 | 2 | 2 | 2 |
>>| I found the various functions in the system were well integrated | 5 | 4 | 4 | 4 | 5 | 4 | 5 | 5 | 4 | 4 |
>>| I thought there was too much inconsistency in the system | 1 | 2 | 2 | 1 | 1 | 2 | 1 | 1 | 2 | 2 |
>>| I would imagine that most people would learn to use this system very quickly | 4 | 5 | 5 | 3 | 3 | 5 | 5 | 3 | 3 | 4 |
>>| I found the system very cumbersome to use | 3 | 3 | 2 | 2 | 3 | 3 | 2 | 3 | 3 | 2 |
>>| I felt very confident using the system | 4 | 3 | 3 | 2 | 4 | 3 | 4 | 3 | 3 | 2 |
>>| I needed to learn a lot of things before getting going with the system | 3 | 3 | 3 | 3 | 2 | 3 | 3 | 3 | 3 | 3 |
>>
>>Since the score of individual items alone is not meaningful for research purposes, it is necessary to holistically assess the overall system usability.
>>For odd-numbered items (1, 3, 5, 7, and 9), the scores are calculated by subtracting 1 from the scale position. For even-numbered items (2, 4, 6, 8, and 10), the scores are obtained by subtracting the scale position from 5. Each item's score ranges from 0 to 4.
>>-To calculate the SUS score, sum the scores of all items and then multiply by 2.5 to derive the total score.
>>
>>**System Usability Scale (SUS) Survey Results**
>>| Questions    | Tester 1 | Tester 2 | Tester 3 | Tester 4 | Tester 5 | Tester 6 | Tester 7 | Tester 8 | Tester 9 | Tester 10 |
>>|--------------|----------|----------|----------|----------|----------|----------|----------|----------|----------|-----------|
>>| Question 1   | 3        | 3        | 3        | 4        | 2        | 2        | 3        | 3        | 3        | 3         |
>>| Question 2   | 2        | 3        | 2        | 3        | 3        | 2        | 2        | 2        | 3        | 2         |
>>| Question 3   | 3        | 2        | 2        | 2        | 2        | 3        | 3        | 3        | 2        | 2         |
>>| Question 4   | 3        | 3        | 3        | 3        | 3        | 3        | 4        | 3        | 3        | 3         |
>>| Question 5   | 4        | 3        | 3        | 4        | 4        | 3        | 4        | 3        | 3        | 3         |
>>| Question 6   | 4        | 3        | 3        | 4        | 4        | 3        | 3        | 4        | 3        | 3         |
>>| Question 7   | 3        | 4        | 3        | 3        | 3        | 3        | 4        | 3        | 4        | 3         |
>>| Question 8   | 2        | 2        | 3        | 2        | 3        | 3        | 3        | 2        | 2        | 3         |
>>| Question 9   | 3        | 2        | 2        | 2        | 3        | 3        | 2        | 3        | 2        | 1         |
>>| Question 10  | 2        | 2        | 2        | 3        | 2        | 2        | 2        | 3        | 2        | 2         |
>>| Sum          | 29       | 27       | 25       | 27       | 30       | 27       | 30       | 29       | 27       | 25        |
>>| Scores       | 72.5     | 67.5     | 62.5     | 67.5     | 75       | 67.5     | 75       | 72.5     | 67.5     | 62.5      |
>>
>>Based on the statistics in the table above, the average total score for the 10 users was calculated to be 69, which is slightly higher than the usability threshold of 68, inidcating that our game is usable.

## Process

In this course, our team worked together to develop a game based on tank versus tank combat. During our team's game development, the application of Agile development principles greatly improved the flexibility and efficiency of the project. This not only enabled us to acquire the necessary software development skills, but also allowed us to gain valuable experience in team management and project collaboration, laying a solid foundation for our future careers.

In order to efficiently manage the source code of the project, we adopted two tools, Git and GitHub, to effectively carry out version control and code backup to ensure the smooth progress of the project and the safety of the data. The code sharing and review function of GitHub greatly facilitates the synchronization and collaboration among the team members, and keep the code running neatly and efficiently. To allow simultaneous development of different features, each feature would be developed on a new branch. When implemented, a pull request would be generated on GitHub. This would allow other memebers of the team to review the code and test the new feature. When a reviewer had established that the code was working effectively, they would approve the pull request, allowing the new feature to be merged into the master branch. This process ensured that the version of the game on the master branch was always operational.

The curriculum is set up so that we have regular weekly play-testing and discussion time. These hands-on sessions are at the heart of our iterative development process. By working on the game ourselves, we were able to identify problems and target improvements. From basic features such as movement, random map generation and projectile launching, the game gradually added rich features such as wind speed adjustment, multiple weapon choices, human-vs-machine battles, and a virtual shop, which greatly enhanced the game's appeal and player immersion.

We also set up a WhatsApp group as the main communication platform. This allowed is to communicate the progress of various tasks, to delegate work, and to organise in person meetings. However, response times varied among team members, perhaps indicating that it did not suit the communication style of all team members. Overall, communication between team members could have been significantly better, likely contributing to an imbalance in relative contributions accross the team.

The division of labour in the team is also very important. We can assign tasks and take on different roles according to our strengths and preferences. We had a project manager, who was responsible for the design of the game, overall project planning and team coordination; several programmers, who were responsible for the coding implementation of the game; and art designers, who were responsible for the visual elements of the game and the user interface design.

During the project collaboration, we deeply experienced the complexity of code integration. While the modules developed by each team member may perform well in the local environment, compatibility issues often arise when merged together. This requires us to have a good understanding of the code of other team members that is related to what we are responsible for, and this is an important thing we learn from this course: not only do we need to read and understand the code of other team members, but it is also better to make our own code easy to read and understand by others, which means that we need to improve the readability and maintainability of our code, so that we can easily modify the code whenever we need to.

In addition, we recognize the importance of good communication in reducing misunderstandings and conflicts, which can significantly improve team efficiency. We also realized the importance of checking the progress of the project on a regular basis, which not only helped us to monitor the completion of each stage, but also motivated our team members to keep working efficiently, and Github's Kanban (see below) provided us with a clear picture of pending and completed projects, which made it easier for us to assign tasks according to our own strengths and preferences. During the Easter holidays, we had a full, uninterrupted three weeks off from work, and we met in the lab, which allowed us to progress more effectively.

![Kanban](https://github.com/UoB-COMSM0110/2024-group-2/blob/main/.github/images/KanBan.png)

We also encountered some challenges, notably an imbalance in the distribution of tasks. Sometimes individual members were overloaded with work, which affected the overall coordination of the team and the morale of the members. To address this issue, we plan to adopt a more detailed method of task assessment and allocation in future projects to ensure that the workload of each member is within a manageable range. This improvement will further enhance the success rate of future projects and team cohesion.

## Conclusion

During the development of this game, we realised that teamwork proper project management processes are indispensable. They helped us to manage the development cycle and improve the efficiency of the development. In the early stages of the game development, our team lagged behind other teams considering that we did not make good use of the agile development technique or communicate on a consistent basis. After we realized this problem, our team decided to work collectively offline to develop this game and maintain communication online and offline, which sped up our development process and made our game more attractive. Although our requirements were changing from time to time, we were still capable of implementing them well thanks to the flexibility of the agile development technique. The problems raised in project development made us realise that completing a project requires not only strong coding skills but also teamwork and professional approaches.

The game we have now is quite complete but we can go further to add some interesting features to it such as tank upgrades and more shop items such as teleports. We could also make the game run online. This would allow players to archive it when they are offline, and engage in online multiplayer which would further enhance the playablility of our game.

## Individual Contribution and Roles

| Name       | Role               | Contribution                                 | Individual Weight  |
|------------|--------------------|----------------------------------------------|--------------------|
| Hamish       | Lead Developer and Project Manager    | Developed the core game engine and was responsible for reviewing and integrating all the features developed by other team members. Edited the report and wrote the design and implementation sections. Also took on most of the project management responsibilities        |         1.5          |
| Dom       | Videographer and associate developer| Designed and implemented the shop. Made the game video. Wrote the requirements section of the report  |         TBC          |
| Jianzhao      | Associate developer | Implemented the shot clock feature. Wrote the introduction and conclusion of the report     |            TBC       |
| Jinnan    | Associate developer and analyst     | Developed the start screen and implemented state switching. Wrote the analysis section of the report and contributed to the implementation section   |          TBC         |
| Hanyang       | Associate developer      | Implemented wind in the game. Wrote the process section of the report     |         TBC          |
