
# Create Deck
# Give 2 cards to player
# Give 2 cards to dealer
# Ask player for hit or stay
#  - If hit add 1 card
#  - If stay move to dealer turn
# Dealer opens cards
# If cards less than 17 dealer hits until over 17 or bust
# Compare sums to find out winner

# 4 decks of 52 cards
# Natural balckjack Ace + 10
# Natural blackjack beats any other hand of 3+ cards
# Soft hand - ace is counted 1 or 11 without busting
# Hard hand - ace is counter as a 1 only
# Player cards are dealt face up
# Dealer hand dealt one up one down
# Options: Hit, Stand, Double Down, Split
# Dealer must stand on 17, draw until then
# If it's a draw, player gets bet back

# ----------------- METHODS -----------------------

def welcome_message(player_name)
  system 'clear'
  puts """
  Welcome to the Blackjack game!

  Player 1: #{player_name} vs Player 2: dealer
  """
end

def deck_of_cards
  suits = ['H', 'D', 'S', 'C']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
  deck = suits.product(cards)
end

def deal_card(deck)
  deck.pop
end

def calculate_total(cards)
  arr = cards.map { |e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end

  arr.select { |e| e == "A" }.count.times do
    total -= 10 if total > 21
  end
end

def check_winner(total, name)
  if total == 21
    puts "Congrats! #{name}, you hit blackjack!" 
  else total > 21
    puts "Sorry #{name}, you busted."
  end
end

def announce_winner(dealer_total, player_total)
  if dealer_total < player_total
    puts "Congrats! You have won this round."
  elsif dealer_total > player_total
    puts "Sorry, dealer have won this round."
  else
    puts "It's a draw" 
  end
end

# --------------- START PROGRAM -------------------

puts "Write down your name: "
player_name = gets.chomp

welcome_message(player_name)

begin
  deck = []

  4.times { deck += deck_of_cards }

  deck.shuffle!

  player_hand = []
  dealer_hand = []

  2.times do
    player_hand << deal_card(deck)
    dealer_hand << deal_card(deck)
  end

# -------- Player turn --------

  puts "Your have: #{player_hand[0]} and #{player_hand[1]}"
  player_total = calculate_total(player_hand)
  check_winner(player_total, player_name)

  while player_total < 21
    puts "Would you like to? (1) hit or (2) stay"
    hit_or_stay = gets.chomp

    if !['1', '2'].include?(hit_or_stay)
      puts "Invalid input: You must enter 1 or 2"
      next
    end

    break if hit_or_stay == '2'

    puts "Your new card is: #{deal_card(deck)}"
    player_hand << deal_card(deck)
  
    player_total = calculate_total(player_hand)
    puts "Your new total is: #{player_total}"
    check_winner(player_total, player_name)
  end

# -------- Dealer turn ---------

  dealer_total = calculate_total(dealer_hand)
  check_winner(dealer_total, "dealer")

  if dealer_total < 17
    dealer_hand << deal_card(deck)
    dealer_total = calculate_total(player_hand)

    check_winner(dealer_total, "dealer")
  end

  puts "Your cards: "
  player_hand.each { |card| puts "#{card}"}
  puts ""
  puts "Dealer's cards: "
  dealer_hand.each { |card| puts "#{card}"}

  announce_winner(player_total, dealer_total)

  puts "Play again? (y/n)"
  response = gets.chomp.downcase
  
end until response == 'n'
