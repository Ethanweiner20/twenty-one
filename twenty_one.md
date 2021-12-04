# Twenty One

# GAME RULES

- Goal: Get as close to 21 as possible
  - If you go over 21, you lose
- Setup:
  - Both player are dealt 2 cards
  - 2 players: Dealer, player
  - Player can initially see one of dealer's two cards
- Card values:
  - 2-10 = Face value
  - JQK = 10
  - Ace = 1 or 11 such that it's value => Closes to 21
    - The values of the aces should be such that they help the player out the MOST (i.e. get the player closest to 21 w/o exceeding it)
- Turns:
  - Player (goes first): Can either "hit" or "stay"
    - If the player exceeds 21 => automatic loss
    - If the player stays => Go to dealer's turn
  - Dealer's turn (only if the player stays)
    - Hits until the total is at least 17
    - If dealer busts => Player wins
- Final comparison:
  - We know that both player & dealer <= 21
  - Greater of the two values wins
- Determining the value of a deck:
  - Sum the values of all the non-aces
  - If there are any aces, sum them su

# PROBLEM

*Explicit Requirements*:
- **Input**: 
- **Output**:

*Things to consider*:
- More than one ace -- difficult
- You must sample w/o replacement, since we are dealing w/ a normal 52-card deck

*Questions*:
- Do we need to track the suit of cards?

*Implicit Requirements*:


*Edge Cases*:



*Mental Models*:


# EXAMPLES/TESTS



# DATA STRUCTURES

A Game is a Hash containing 3 arrays of Cards:
- The deck
- The player's cards
- The dealer's cards

A Card is a 2-element array of the form [suite, rank]
- e.g. ['S', 'J']

A Suite is one of:
- 'S' (spade)
- 'H' (heart)
- 'D' (diamond)
- 'C' (club)

- Game State
  - Option 1: A hash containing:
    - The deck (array)
    - The player's cards (array)
    - The dealer's cards (array)
    - Advantages
      - keeps the deck separate from the cards of the player and dealer => avoid repeated selection
      - easier to directly retrieve cards from either deck/player, rather than having to continually filter by some property in an array
      - easier to count player & dealer cards
  - Option 2: An array containing the deck that marks player's cards and dealer's cards
    - Advantages
      - easier to move cards directly from deck to player/dealer (just mark)
- Card: A 2-element array
  - Index 0: Suit
  - Index 1: Number

# ALGORITHM

1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
  - note: short-circuit result
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.

*Sub-Problems*:




# CODE

*Implementation Details*:

# Improvements / Bonus Features

1. Using a cache to store player & dealer totals X
2. The last call is different because if the user wants to play again, there is no need to skip over the rest of the loop (using `next`), since we are at the end of the loop. We can simply continue, which will immediately send us back to the beginning of the loop.
3. Consistent end-of-round output

- `play_hand` VS `play_match`: Agree, should be named differently. `play_hand` would be better suited for a method that involved, well, playing just one player's hand of cards. This doesn't really make sense in the context of blackjack (hands are never really "played" -- they are just accumulated).
- Extraced ranks into "sub"-constants that I use in the `value` method
- Agreed. Indexing into a hash sometimes I feels like such a simple operation, I almost treat something like `totals[:player]` like a variable itself. It's easy to forget that it actually does require an indexing process, which could in some scenarios, affect performance. Using local variables also helps with readability.