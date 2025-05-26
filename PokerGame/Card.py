class Card:
   
 def __init__(self, rank: str, suit: str):
    self.rank = rank
    self.suit = suit

def get_value(self) -> int:
        rank_values = {
           "A":1, "2":2, "3":3, "4":4, "5":5,
            "6":6, "7":7, "8":8, "9":9, "10":10,
            "J":11, "Q":12, "K":13
        }
        return rank_values.get(self.rank,0)
   
def get_suit_rank(self) -> int:
        suit_rank = {
             'C':1,
             'D':2,
             'H':3,
             'S':4

        }
        return suit_ranks.get(self.suit, 0)

def get_rank(self) ->str:
     return self.rank

def get_suit(self) ->str:
     return self.suit

def __str__(self) -> str:
     return f"{self.rank}{self.suit}"
