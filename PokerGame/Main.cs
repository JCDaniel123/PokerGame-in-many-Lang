using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace PokerGame
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length > 0)
            {
                string fileName = args[0];
                FormattingForFile(fileName);

                if (!File.Exists(fileName))
                {
                    Console.WriteLine($"Error: File not found - {fileName}");
                    return;
                }

                List<Hand> hands = new List<Hand>();
                HashSet<string> seenCards = new HashSet<string>();
                int handIndex = 0;

                foreach (string line in File.ReadLines(fileName))
                {
                    if (handIndex >= 6) break;

                    string trimmed = line.Trim();
                    Console.WriteLine(trimmed);
                    Hand hand = new Hand();
                    string[] cardStrings = trimmed.Split(' ');

                    foreach (string cardStr in cardStrings)
                    {
                        if (seenCards.Contains(cardStr))
                        {
                            Console.WriteLine($"Error: Duplicate card detected - {cardStr}");
                            return;
                        }

                        seenCards.Add(cardStr);
                        string rank = cardStr.Substring(0, cardStr.Length - 1);
                        char suit = cardStr[^1];
                        hand.AddCard(new Card(rank, suit));
                    }

                    hands.Add(hand);
                    handIndex++;
                }

                Console.WriteLine("\n*** Here are the six hands...");
                foreach (var hand in hands)
                {
                    Console.WriteLine(hand);
                }

                Console.WriteLine("\n--- WINNING HAND ORDER ---");
                hands.Sort((h1, h2) => new PokerHandRank(h1).GetRankValue().CompareTo(new PokerHandRank(h2).GetRankValue()));

                foreach (var hand in hands)
                {
                    PokerHandRank rank = new PokerHandRank(hand);
                    Console.WriteLine($"{hand} - {rank.GetRankName()}");
                }
            }
            else
            {
                Formatting();
                Deck deck = new Deck();
                deck.Shuffle();

                Console.WriteLine("*** Shuffled 52 Card Deck:");
                Console.WriteLine(deck);
                Console.WriteLine();

                List<Hand> hands = new List<Hand>();
                Console.WriteLine("*** Here are the six hands...");

                for (int i = 0; i < 6; i++)
                {
                    Hand hand = new Hand();
                    for (int j = 0; j < 5; j++)
                    {
                        hand.AddCard(deck.DealCard());
                    }
                    hands.Add(hand);
                    Console.WriteLine(hand);
                }

                Console.WriteLine("\n*** Here is what remains in the deck...");
                Console.WriteLine(deck);
                Console.WriteLine();

                Console.WriteLine("--- WINNING HAND ORDER ---");
                hands.Sort((h1, h2) => new PokerHandRank(h1).GetRankValue().CompareTo(new PokerHandRank(h2).GetRankValue()));

                foreach (var hand in hands)
                {
                    PokerHandRank rank = new PokerHandRank(hand);
                    Console.WriteLine($"{hand} - {rank.GetRankName()}");
                }
            }
        }

        static void Formatting()
        {
            Console.WriteLine("*** P O K E R  H A N D  A N A L Y Z E R ***");
            Console.WriteLine();
            Console.WriteLine(" *** USING RANDOMIZED DECK OF CARDS *** ");
            Console.WriteLine();
        }

        static void FormattingForFile(string fileName)
        {
            Console.WriteLine("*** P O K E R  H A N D  A N A L Y Z E R ***");
            Console.WriteLine();
            Console.WriteLine(" *** USING TEST DECK *** ");
            Console.WriteLine();
            Console.WriteLine($"*** File Name: {fileName}");
        }
    }
}
