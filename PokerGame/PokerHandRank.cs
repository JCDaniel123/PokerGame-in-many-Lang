using System;
using System.Collections.Generic;
using System.Text;

namespace PokerGame
{
    public class PokerHandRank
    {
        private int rankValue;
        private List<Card> sortedCards;

        public PokerHandRank(Hand hand)
        {
            // Make a copy of the hand's cards and sort them
            sortedCards = new List<Card>(hand.GetCards());
            hand.Sort();
            rankValue = EvaluateHand();
        }

        public int GetRankValue()
        {
            return rankValue;
        }

        public string GetRankName()
        {
            if (IsRoyalFlush()) return "Royal Flush";
            if (IsStraightFlush()) return "Straight Flush";
            if (IsFourOfAKind()) return "Four of a Kind";
            if (IsFullHouse()) return "Full House";
            if (IsFlush()) return "Flush";
            if (IsStraight()) return "Straight";
            if (IsThreeOfAKind()) return "Three of a Kind";
            if (IsTwoPair()) return "Two Pair";
            if (IsPair()) return "One Pair";
            return "High Card";
        }

        private int EvaluateHand()
        {
            if (IsRoyalFlush()) return 1;
            if (IsStraightFlush()) return 2;
            if (IsFourOfAKind()) return 3;
            if (IsFullHouse()) return 4;
            if (IsFlush()) return 5;
            if (IsStraight()) return 6;
            if (IsThreeOfAKind()) return 7;
            if (IsTwoPair()) return 8;
            if (IsPair()) return 9;
            return 10;
        }

        private bool IsRoyalFlush()
        {
            return IsStraightFlush() && sortedCards[0].GetValue() == 10;
        }

        private bool IsStraightFlush()
        {
            return IsFlush() && IsStraight();
        }

        private bool IsFlush()
        {
            char suit = sortedCards[0].GetSuit();
            foreach (Card card in sortedCards)
            {
                if (card.GetSuit() != suit) return false;
            }
            return true;
        }

        private bool IsStraight()
        {
            for (int i = 0; i < sortedCards.Count - 1; i++)
            {
                if (sortedCards[i + 1].GetValue() != sortedCards[i].GetValue() + 1)
                {
                    return false;
                }
            }
            return true;
        }

        private Dictionary<int, int> GetValueCounts()
        {
            Dictionary<int, int> counts = new Dictionary<int, int>();
            foreach (Card card in sortedCards)
            {
                if (counts.ContainsKey(card.GetValue()))
                {
                    counts[card.GetValue()]++;
                }
                else
                {
                    counts[card.GetValue()] = 1;
                }
            }
            return counts;
        }

        private bool IsFourOfAKind()
        {
            var counts = GetValueCounts();
            return counts.ContainsValue(4);
        }

        private bool IsFullHouse()
        {
            var counts = GetValueCounts();
            return counts.ContainsValue(3) && counts.ContainsValue(2);
        }

        private bool IsThreeOfAKind()
        {
            var counts = GetValueCounts();
            return counts.ContainsValue(3) && !IsFullHouse();
        }

        private bool IsTwoPair()
        {
            var counts = GetValueCounts();
            int pairCount = 0;
            foreach (var count in counts.Values)
            {
                if (count == 2)
                {
                    pairCount++;
                }
            }
            return pairCount == 2;
        }

        private bool IsPair()
        {
            var counts = GetValueCounts();
            return counts.ContainsValue(2) && !IsTwoPair();
        }

        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Rank: ").Append(rankValue).Append(", Cards: ");
            foreach (Card card in sortedCards)
            {
                sb.Append(card.ToString()).Append(" ");
            }
            return sb.ToString().Trim();
        }
    }
}
