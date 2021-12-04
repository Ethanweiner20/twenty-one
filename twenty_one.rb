# Twenty One
# ============================================================================

# CONSTANTS
# ============================================================================

GAME_NUMBER = 21 # Change the game number as you wish
DEALER_HIT_LIMIT = ((17.0 / 21) * GAME_NUMBER).round

SUITS = %w(S H D C)
NUMBERED_RANKS = (2..10).map(&:to_s)
ROYAL_RANKS = %w(J Q K)
ACE = 'A'
RANKS = NUMBERED_RANKS + ROYAL_RANKS + [ACE]
SUIT_SYMBOLS = {
  'S' => "\u2660",
  'H' => "\u2665",
  'D' => "\u2666",
  'C' => "\u2663",
  '*' => "*"
}

BREAK_DURATION = 1.75

MESSAGES = {
  welcome: "Welcome to #{GAME_NUMBER}!",
  title: "YOU ARE PLAYING #{GAME_NUMBER}",
  continue: "Enter any key to continue.",
  player_action: "Hit or stay? (h/hit or s/stay)",
  invalid_input: "Your input was invalid. Please re-enter.",
  play_again: "Would you like to play again? (y/yes or n/no)",
  goodbye: "Thanks for playing #{GAME_NUMBER}! Goodbye.",
  player_turn: "It's your turn!",
  dealer_turn: "It's the dealer's turn!",
  dealer_hit: "The dealer hit!",
  dealer_stay: "The dealer stayed!",
  player_bust: "You busted, so you lost the match!",
  dealer_bust: "The dealer busted, so you won the match!",
  player_won: "You won the match!",
  dealer_won: "You lost the match!",
  tie: "You tied the match!",
  separator: "============================================"
}

# GAME
# ============================================================================

def play_twenty_one
  display_welcome
  loop do
    play_match
    break unless play_again?
  end
  display_goodbye
end

def play_match
  cards = initialize_cards
  totals = initialize_totals
  deal_cards(cards, totals)
  display_state(cards, totals, hide_dealer_card: true)
  player_turn(cards, totals)
  dealer_turn(cards, totals) unless bust?(totals[:player])
  display_game_end(totals)
end

# HELPER METHODS
# ============================================================================

# Initialization

def initialize_cards
  {
    deck: initialize_deck,
    player: [],
    dealer: []
  }
end

def initialize_totals
  {
    player: 0,
    dealer: 0
  }
end

def initialize_deck
  SUITS.product(RANKS).shuffle
end

# Player Turn

def player_turn(cards, totals)
  prompt MESSAGES[:player_turn]
  action = nil
  loop do
    action = retrieve_player_action
    deal_card!(:player, cards, totals) if action == :hit
    display_state(cards, totals, hide_dealer_card: true)
    break if action == :stay || bust?(totals[:player])
  end
end

def retrieve_player_action
  answer = ''
  loop do
    prompt MESSAGES[:player_action]
    answer = gets.chomp.downcase
    break if %w(h hit s stay).include?(answer)
    prompt MESSAGES[:invalid_input]
  end

  answer.start_with?('h') ? :hit : :stay
end

# Dealer Turn

def dealer_turn(cards, totals)
  prompt MESSAGES[:dealer_turn]
  loop do
    display_state(cards, totals)
    sleep(BREAK_DURATION)

    if bust?(totals[:dealer])
      break
    elsif dealer_stay?(totals[:dealer])
      prompt MESSAGES[:dealer_stay]
      break
    end

    deal_card!(:dealer, cards, totals)
  end
end

# Dealing Cards

def deal_cards(cards, totals)
  2.times do
    deal_card!(:player, cards, totals)
    deal_card!(:dealer, cards, totals)
  end
end

def deal_card!(player, cards, totals)
  cards[player] << cards[:deck].pop
  totals[player] = total(cards[player])
end

# Card Value Calculation

def total(cards)
  sum = cards.reduce(0) { |acc, card| acc + value(card[1]) }
  # Adjust upward for aces as able
  cards.count { |_, rank| rank == 'A' }
       .times { sum += 10 if sum + 10 <= GAME_NUMBER }
  sum
end

def value(rank)
  if NUMBERED_RANKS.include?(rank)
    rank.to_i
  elsif ROYAL_RANKS.include?(rank)
    10
  elsif rank == ACE
    1
  end
end

# Display

def display_welcome
  system('clear')
  prompt "#{MESSAGES[:welcome]} #{MESSAGES[:continue]}"
  gets
end

def display_goodbye
  prompt MESSAGES[:goodbye]
end

def display_state(cards, totals, hide_dealer_card: false)
  system('clear')

  prompt(MESSAGES[:title], new_line: true)
  prompt "Your Cards:"
  display_cards(cards[:player], totals[:player])

  prompt "Dealer's Cards:"
  if hide_dealer_card
    display_cards([cards[:dealer][0], ['*', '*']]) # Hides one card
  else
    display_cards(cards[:dealer], totals[:dealer])
  end
end

def display_cards(cards, total = nil)
  puts
  puts cards_top(cards)
  puts cards_middle(cards)
  puts cards_bottom(cards)
  puts
  prompt("Card Total: #{total}", new_line: true) if total
end

def cards_top(cards)
  cards.reduce('') { |str, card| str + "|#{SUIT_SYMBOLS[card[0]]}  | " }
end

def cards_bottom(cards)
  cards.reduce('') { |str, card| str + "|  #{SUIT_SYMBOLS[card[0]]}| " }
end

def cards_middle(cards)
  cards.reduce('') do |str, card|
    str + (card[1] == '10' ? "|#{card[1]} | " : "| #{card[1]} | ")
  end
end

def display_game_end(totals)
  result = evaluate_result(totals)
  display_totals(totals) if [:player_won, :dealer_won, :tie].include?(result)
  display_result(result)
end

def display_totals(totals)
  sleep(BREAK_DURATION)
  puts MESSAGES[:separator]
  prompt "The dealer's hand's final total is #{totals[:dealer]}."
  prompt "Your hand's final total is #{totals[:player]}."
  puts MESSAGES[:separator]
end

# Results

def evaluate_result(totals)
  player_total = totals[:player]
  dealer_total = totals[:dealer]
  if bust?(player_total)
    :player_bust
  elsif bust?(dealer_total)
    :dealer_bust
  elsif player_total > dealer_total
    :player_won
  elsif player_total < dealer_total
    :dealer_won
  else
    :tie
  end
end

def display_result(result)
  prompt MESSAGES[result]
end

# Auxiliary Methods

def prompt(message, new_line: false)
  puts "==> #{message}"
  puts if new_line
end

def bust?(total)
  total > GAME_NUMBER
end

def dealer_stay?(total)
  total >= DEALER_HIT_LIMIT
end

def play_again?
  sleep(BREAK_DURATION)
  answer = ''
  loop do
    prompt MESSAGES[:play_again]
    answer = gets.chomp.downcase
    break if %w(y yes n no).include?(answer)
    prompt MESSAGES[:invalid_input]
  end

  answer.start_with?('y')
end

# PLAY THE GAME
# ============================================================================

play_twenty_one
