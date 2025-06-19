class Card:
   
 def __init__(self, rank: str, suit: str): #This makes the card object
    self.rank = rank
    self.suit = suit

 def get_value(self) -> int: #this creates a method to return the int value of the card 
        rank_values = {
           "2":2, "3":3, "4":4, "5":5,
            "6":6, "7":7, "8":8, "9":9, "10":10,
            "J":11, "Q":12, "K":13, "A":14
        }
        return rank_values.get(self.rank,0)
   
 def get_suit_rank(self) -> int: # creates a method for getting the int value of the suits
        suit_rank = {
             'C':1,
             'D':2,
             'H':3,
             'S':4

        }
        return suit_rank.get(self.suit, 0)

 def get_rank(self) ->str: # gets the rankinf of the card as a string
     return self.rank

 def get_suit(self) ->str: # gets the suit fo the card as a string
     return self.suit

 def __str__(self):  # pretty much the toString like in java to replace the default print whne printed "raw"
    return f"{self.rank}{self.suit}"
