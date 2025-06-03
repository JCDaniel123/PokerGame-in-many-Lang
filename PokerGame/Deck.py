import random
from card import Card # imports the card class

class Deck: 
     def __init__(self):
        # initialize an empty list of store card objects
        self.cards = []


        # Define all possible card ranks and suits
        ranks = ["A", "2", "3", "5", "6", "7", "8","9", "10","J", "Q", "K"]
        suits = ['C', 'D', 'H', 'S']

        # Create 52 cards (13 ranks x 4 suits) and add them to the deck
        for suit in suits:
            for rank in ranks:
                self.cards.append(Card(rank,suit))

        
        def shuffle(self):
            # Randomly shuffle the order of the cards in the deck
            random.shuffle(self.cards)

        
        def deal_card(self):
            # Deal (remove and return) the top card from in the deck
            if self.cards:
                return self.cards.pop(0) # removes the first card in the list
            return None # if the deck is empty, return None


        def size(self):
            # Return the number of the remaining cards in the deck
            return len(self.cards)
        

        def is_empty(self):
             # return true if the deck has no cards left
             return len(self.cards)==0


        def __str__(self):
            # return a nicely formatted string of all cards in the deck
            lines = [] # list of lines
            line  =[]  # Current line


            for i, card in enumerate(self.cards, start=1):
                 line.append(str(card)) # Convert card to string and add to current line
                 if i % 13 ==0:
                     lines.append(' '.join(line)) #add completed line to lines list
                     line = [] # Start a new line

                 if line:
                     line.append(' '.join(line)) # Add any left over cards

                 return '\n'.join(lines) # join all lines with newline chars