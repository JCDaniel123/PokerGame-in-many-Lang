import sys
from Card import Card
from Deck import Deck
from Hand import Hand
from PokerHandRank import PokerHandRank


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
                    line = line.strip()
                    if not line:
                        continue
                    print(line)
                    hand = Hand()
                    card_strs = line.split()
                    for card_str in card_strs:
                        if card_str in seen_cards:
                           print(f"Error: Duplicate card detected - {card_str}")
                           return
                        seen_cards.add(card_str)
                        rank, suit = card_str[:-1], card_str[-1]
                        hand.add_card(Card(rank, suit))
                    hands.append(hand)
                    if len(hands) == 6:
                        break


                    print("\n*** Here are the six hands...")
                    for hand in hands:
                        print(hand)

                    print("\n--- WINNING HAND ORDER ---")
                    hands.sort(key = lambda h: PokerHandRank(h).rank_value)
                    for hand in hands:
                        rank = PokerHandRank(hand)
                        print(f"{hand} - {rank.get_rank_name()}")
                    
        except FileNotFoundError:
                print(f"Error: File not found - {filename}")


        else:
            formatting()
            deck = Deck()
            deck.shuffle()

            hands = [Hand() for _ in range(6)]
            print("*** Shuffle 52 Card Deck: \n")
            print(deck)

            print("\n*** Here are the six hands...")
            for hand in hands:
                for _ in range(5):
                    hand.add_card(deck.deal_card())
                print(hand)

                print("\n*** Here is what remains in the deck...")
                print(deck)

                print("\n--- WINNING HAND ORDER ---")
                hands.sort(key=lambda h: PokerHandRank(h).rank_value)
                for hand in hands:
                    rank = PokerHandRank(hand)
                    print(f"{hand} - {rank.get_rank_name()}")

                if __name__ == "__main__":
                    main()

                        

