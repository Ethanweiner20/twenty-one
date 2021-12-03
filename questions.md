# Notes

- Didn't focus much on extra features here: Just wanted to focus on good design


# Questions

- How much do we care about unnecessary repetitve evaluation of methods?
  - From an efficiency perspective, it doesn't matter here -- total is a very simple, non-intensive calculation
    - But are there any other design elements to consider?
  - e.g. My `result` method: If it traverses all branches, it will compute each total 3 times, instead of once. But this actually shortens the code overall.
- I am aware that when parameter passing, we generally only want to pass what we need (it doesn't make sense to pass extraneous data to methods that don't need this). In a few of my methods, however, I decided to violate this principle by passing the whole `cards` hash to methods that might only need 2 of these hashes (such as `display_state`). I decided to do this because it made intuitive sense that a method named `display_state` would be provided with the entire "state" of the game (as represented by `cards`), as opposed to individual card subsets. Do you think this is an appropriate tradeoff?

- Usage of global variables:
  - Suppose I wanted to allow the user to be able to choose the game number (21, 31, etc.)
  - In this instance, passing the game number around to all the methods in the program that need it would be pretty cumbersome. Is this an appropriate instance of using a global variable? Or would the game be better off utilize in a class where the game number is an instance or class variable?

- This question might be rather trivial, but for default arguments, are keyword arguments (e.g. arg: value) or default position arguments (e.g. arg = value) preferred?
  - I used a combination of the two in my program, but I generally like keyword arguments more because they are more explicit
  - It feels weird if sometimes we pass a positional argument, but sometimes don't... it feels like positional arguments should always be included
- I prefer displaying main methods at the top, and progressively more specific methods as we move down (as a general rule, not a hardcoded thing)
  - In my opinion, it doesn't make sense to view specific methods without reference to their larger context
  - Instead, we can view their larger context first, and then see how they are specifically implemented
  - The higher level of abstraction is prioritized, while the lower levels can be viewed as necessary
  - Do you prefer one way or the other?

Particular Points of Interest:
- `deal_card` method
  - Goal = Assign methods with a very particular task, as indicated by name
  - The first line of this method clearly conforms to this name
  - The second line is more of an effect *of* dealing a card -- but an effect that should consistently take place whenever a card is dealt
  - So my question is: For tasks that are tightly linked to, but not directly representative of a method's purpose, is including them in the method a reasonable call? Or should even this be abstracted?
- Caching the `totals`
  - Can clearly see why this is helpful for performance reasons
  - But is performance the only reason here?
  - I certainly like the idea of having the totals stored in one place ("cached") for easy access
  - But at the same time, it leads to a requirement of parameter passing, and continual updates -- is this really a good call?