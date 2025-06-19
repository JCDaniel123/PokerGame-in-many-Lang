from collections import Counter

class PokerHandRank:

    def __init__(self, hand):
        # Sort the cards by value, then by suit
        self.cards = sorted(hand.cards, key=lambda c: (c.get_value(), c.get_suit_rank()))
        # Determine and store the rank of the hand
        self.rank_value = self.evaluate_hand()


    
    def evaluate_hand(self):
        # Check for each of poker hand in order from strongest to weakest
        if self.is_royal_flush(): return 1
        if self.is_straight_flush(): return 2
        if self.is_four_of_a_kind(): return 3
        if self.is_full_house():    return 4
        if self.is_flush():      return 5
        if self.is_straight():  return 6
        if self.is_three_of_a_kind(): return 7
        if self.is_two_pair(): return 8
        if self.is_pair(): return 9
        return 10
    

    def get_rank_name(self):
        # Return the name for the hand's rank
        if self.is_royal_flush(): return "Royal Flush"
        if self.is_straight_flush(): return "Straight Flush"
        if self.is_four_of_a_kind(): return "Four of a Kind"
        if self.is_full_house(): return "Full House"
        if self.is_flush(): return "Flush"
        if self.is_straight(): return "Straight"
        if self.is_three_of_a_kind(): return "Three of a Kind"
        if self.is_two_pair(): return "Two Pair"
        if self.is_pair(): return "One Pair"
        return "High Card"


    def is_flush(self):
         # Check if all cards have the same suit
        suit = self.cards[0].get_suit()
        return all(card.get_suit() == suit for card in self.cards)
    

    def is_straight(self):
        # Check if all cards form a sequence in value
        values = [card.get_value() for card in self.cards]

        if values == [2,3,4,5,14]:
            return true
        return all(values[i+1] == values[i] + 1 for i in range(len(values) -1))
    

    def is_royal_flush(self):
         # Check for a royal flush: a straight flush starting at 10
        return self.is_straight_flush() and self.cards[0].get_value() == 10
    
        
    def is_straight_flush(self):
         # Check if the hand is both a straight and a flush
        return self.is_flush() and self.is_straight()
    


    def get_value_counts(self):
        # Return a dictionary counting how many times each card value appears
        return Counter(card.get_value() for card in self.cards)
    

    def is_four_of_a_kind(self):
         # Check if any card value appears 4 times
        return 4 in self.get_value_counts().values()
    

    def is_full_house(self):
        # Check for 3 of a kind and a pair
        counts = self.get_value_counts()
        return 3 in counts.values() and 2 in counts.values()
    

    def is_three_of_a_kind(self):
        # Check for 3 of a kind but not a full house
        counts = self.get_value_counts()
        return 3 in counts.values() and not self.is_full_house()
    

    def is_two_pair(self):
         # Count how many values appear exactly twice
        counts = list(self.get_value_counts().values())
        return counts.count(2) == 2
    
    def is_pair(self):
        # Check for exactly one pair (but not two pair)
        counts = list(self.get_value_counts().values())
        return counts.count(2) == 1 and not self.is_two_pair()
    
    
    def __str__(self):
         # Return a string representation of the hand's rank and cards
      #  card_strs = ' '.join(str(card) for card in self.cards)
        return "Jonathan"