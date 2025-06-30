using System;
using System.Collections.Generic;

namespace PokerGame
{
    public class Deck
    {
        private List<Card> cards;

        // Constructor
        public Deck()
        {
            cards = new List<Card>();

            // All possible ranks
            string[] ranks = { "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K" };

            // All possible suits
            char[] suits = { 'C', 'D', 'H', 'S' };

            foreach (char suit in suits)
            {
                foreach (string rank in ranks)
                {
                    cards.Add(new Card(rank, suit));
                }
            }
        }

        // Shuffle the deck
        public void Shuffle()
        {
            Random rng = new Random();
            int n = cards.Count;
            while (n > 1)
            {
                n--;
                int k = rng.Next(n + 1);
                Card temp = cards[k];
                cards[k] = cards[n];
                cards[n] = temp;
            }
        }

        // Deal the top card
        public Card DealCard()
        {
            if (cards.Count > 0)
            {
                Card topCard = cards[0];
                cards.RemoveAt(0);
                return topCard;
            }
            else
            {
                return null;
            }
        }

        // Size of the deck
        public int Size()
        {
            return cards.Count;
        }

        // Check if empty
        public bool IsEmpty()
        {
            return cards.Count == 0;
        }

        // Override ToString for displaying the deck
        public override string ToString()
        {
            var sb = new System.Text.StringBuilder();
            int count = 0;

            foreach (Card card in cards)
            {
                sb.Append(card.GetRank()).Append(card.GetSuit()).Append(" ");
                count++;
                if (count % 13 == 0)
                {
                    sb.AppendLine();
                }
            }

            return sb.ToString().Trim();
        }
    }
}
