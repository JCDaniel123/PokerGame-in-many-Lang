from typing import List
from Card import Card # Assuming you have a seperate Card clas

class Hand:
    def __init__(self):
        # Using a Python list to store the hand's cards ( like array list in java)
        self.cards: List[Card]= []

    def add_card(self,card:Card):
        # adds a card to the hand, enforcing a max of 5 cards
        if len(self.cards)<5:
            self.cards.append(card)
        else:
       
            raise ValueError(" A hand can only have 5 vards")
    def get_cards(self)->List[Card]:
        # Returns the list of card objects in the hand
        return self.cards

    def is_full(self) -> bool:
        # returns true if the hand contains 5 cards
        return len(self.cards)==5

    def sort(self): 
        # Sorts the hand first by card value, then by suit rank if needed
        self.cards.sort(key=lambda card: (card.get_value(), card.get_suit_rank()))

    
    def __str__(self) -> str:
        # Builds a string representation of the hand
        return ' '.join(str(card) for card in self.cards)
