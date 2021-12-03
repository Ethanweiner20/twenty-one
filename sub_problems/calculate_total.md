# Calculating a Total (21)

# PROBLEM

*Explicit Requirements*:
- **Input**: An array of `cards`
- **Output**: The total value of the `cards` (a positive integer)
- 1-10 = Face value
- JQK = 10
- Ace = 1 or 11, depending on context
  - Should act such that the result is closest to 21

*Questions*:


*Implicit Requirements*:
- Assumption: Don't mutate the input `cards` (would mess up the game)

*Edge Cases*:



*Mental Models*:


# EXAMPLES/TESTS

puts total([['S', 'J'], ['H', 'Q']] == 20
puts total([['S', 'A']]) == 11
puts total([['S', 'A'], ['S', '5']]) == 16
puts total([['S', 'A'], ['S', '5']]) == 16
puts total([['S', 'A'], ['S', '10']]) == 21
puts total([['S', 'A'], ['S', '10'], ['S', '5']]) == 16
puts total([['S', 'A'], ['S', 'A']) == 12
puts total([['S', 'A'], ['S', 'A'], ['S', '10']) == 12
puts total([['S', 'A'], ['S', 'A'], ['S', '9']) == 21

# DATA STRUCTURES



# ALGORITHM

Idea:
- Partition into 2 arrays: aces and non-aces
- Add up the rest of the cards first
- Fit the aces into the remaining `total` (if possible)
  - Initially assign all to 1
  - Try assigning each to 11. If it still fits into the remaining `total`, go through with the assignment. Otherwise, stop.

# Solution 1

Given an array of `cards`:
- Sum the values of all the cards, and store in `total`
  - Assume that aces have a value of 1
- Count the total number of `aces` in `cards`
- For each ace in `aces`:
  - Add 10 to the `total` if the `total` plus 10 is at most 21
  - Otherwise, skip over that ace
- Return the `total`
  

*Sub-Problems*:




# CODE

*Implementation Details*: