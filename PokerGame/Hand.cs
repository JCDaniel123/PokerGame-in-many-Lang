using System;
using System.Collections.Generic;
using System.Text;

namespace PokerGame
{
    public class Hand
    {
        private List<Card> cards;

        // Constructor
        public Hand()
        {
            cards = new List<Card>();
        }

        // Add a card to the hand (max 5 cards)
        public void AddCard(Card card)
        {
            if (cards.Count < 5)
            {
                cards.Add(card);
            }
            else
            {
                throw new InvalidOperationException("A hand can only have 5 cards");
            }
        }

        // Get the list of cards
        public List<Card> GetCards()
        {
            return cards;
        }

        // Check if the hand is full
        public bool IsFull()
        {
            return cards.Count == 5;
        }

        // Sort the cards by value, then by suit rank
        public void Sort()
        {
            cards.Sort((a, b) =>
            {
                int valueComparison = a.GetValue().CompareTo(b.GetValue());
                if (valueComparison == 0)
                {
                    return a.GetSuitRank().CompareTo(b.GetSuitRank());
                }
                return valueComparison;
            });
        }

        // Override ToString for pretty output
        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();
            foreach (Card card in cards)
            {
                sb.Append(card.GetRank()).Append(card.GetSuit()).Append(" ");
            }

            return sb.ToString().Trim();
        }
    }
}
