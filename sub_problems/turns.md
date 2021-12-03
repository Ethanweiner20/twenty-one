# Player & Dealer Turns

# PROBLEM

*Explicit Requirements*:
- **Input**: The player/dealer's cards
- **Output**:
  - Update the player/dealer's cards based on the result of their turn

*Questions*:


*Implicit Requirements*:


*Edge Cases*:



*Mental Models*:


# EXAMPLES/TESTS



# DATA STRUCTURES



# ALGORITHM

## Player Cards

Given the `player_cards`:
- Set the initial `action` to an empty string
- Loop
  - Ask the player if they would like to hit or stay and retrieve their answer**
  - If the player stays:
    - Break from the loop
  - Otherwise:
    - Deal a new card to the player and update `player_cards`
    - If the player busts**, break from the loop
- Perform appropriate actions based on the result

## Dealer cards

Given the `dealer_cards`:
- Loop
  - If the total value of `dealer_cards` is at least 17, or the dealer busted, break
  - Otherwise, deal a card and continue looping
- Perform appropriate actions based on the result

*Sub-Problems*:




# CODE

*Implementation Details*: