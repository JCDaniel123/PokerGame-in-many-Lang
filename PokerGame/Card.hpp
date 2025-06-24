#ifndef CARD_HPP
#define CARD_HPP

#include <string>
#include <iostream>

class Card {
private:
    std::string rank;
    char suit;

public:
    // Constructor
    Card(std::string r, char s) : rank(r), suit(s) {}

    // Get the numerical value of the card's rank
    int getValue() const {
        if (rank == "A") return 1;
        if (rank == "2") return 2;
        if (rank == "3") return 3;
        if (rank == "4") return 4;
        if (rank == "5") return 5;
        if (rank == "6") return 6;
        if (rank == "7") return 7;
        if (rank == "8") return 8;
        if (rank == "9") return 9;
        if (rank == "10") return 10;
        if (rank == "J") return 11;
        if (rank == "Q") return 12;
        if (rank == "K") return 13;
        return 0;
    }

    // Get the numerical value of the card's suit
    int getSuitRank() const {
        switch (suit) {
            case 'C': return 1; // Clubs
            case 'D': return 2; // Diamonds
            case 'H': return 3; // Hearts
            case 'S': return 4; // Spades
            default: return 0;
        }
    }

    // Return string representation of the card (e.g., "AS" for Ace of Spades)
    std::string toString() const {
        return rank + suit;
    }

    // Getters
    char getSuit() const {
        return suit;
    }

    std::string getRank() const {
        return rank;
    }

    // Friend function to overload operator<< for printing
    friend std::ostream& operator<<(std::ostream& os, const Card& card) {
        os << card.toString();
        return os;
    }
};

#endif // CARD_HPP