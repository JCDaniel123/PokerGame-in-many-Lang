namespace PokerGame
{
    public class Card
    {
        // Variables for the Card class
        private string rank;
        private char suit;

        // Constructor for Card object
        public Card(string rank, char suit)
        {
            this.rank = rank;
            this.suit = suit;
        }

        // Get the numerical value of the card's rank
        public int GetValue()
        {
            switch (rank)
            {
                case "A": return 1;
                case "2": return 2;
                case "3": return 3;
                case "4": return 4;
                case "5": return 5;
                case "6": return 6;
                case "7": return 7;
                case "8": return 8;
                case "9": return 9;
                case "10": return 10;
                case "J": return 11;
                case "Q": return 12;
                case "K": return 13;
                default: return 0;
            }
        }

        // Get the suit's numerical rank
        public int GetSuitRank()
        {
            switch (suit)
            {
                case 'C': return 1; // Clubs
                case 'D': return 2; // Diamonds
                case 'H': return 3; // Hearts
                case 'S': return 4; // Spades
                default: return 0;
            }
        }

        // Overrides ToString to print the card nicely
        public override string ToString()
        {
            return $"{rank}{suit}";
        }

        // Getters for rank and suit
        public char GetSuit()
        {
            return suit;
        }

        public string GetRank()
        {
            return rank;
        }
    }
}
