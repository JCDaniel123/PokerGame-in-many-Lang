import sys
from poker_deck import Deck, Hand, PokerHandRank # Assume classes are defined in poker_deck.py


def formatting():
    print("*** P O K E R  H A N D  A N A L Y Z E R ***\n")
    print(" *** USING RANDOMIZED DECK OF CARDS ***\n")


def formatting_for_file():
    print("*** P O K E R  H A N D  A N A L Y Z E R ***\n")
    print(" *** USING TEST DECK ***\n")


def main():
    if len(sys.argv) > 1:
        filename = sys.argv[1]
        try:
            with open(filename, 'r') as file:
                formatting_for_file()
                print(f"*** File Name: {filename}\n")

                hands = []
                seen_cards = set()
                for line in file: