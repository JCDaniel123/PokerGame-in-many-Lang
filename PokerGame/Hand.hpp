#ifndef HAND_HPP
#define HAND_HPP

#include "Card.hpp"
#include <vector>
#include <algorithm>
#include <sstream>
#include <stdexcept>

class Hand {
private:
    std::vector<Card> cards;

public:
    // Constructor
    Hand() = default;

    // Adds a card if hand is not full (max 5)
    void addCard(Card card) {
        if (cards.size() < 5) {
            cards.push_back(card);
        } else {
            throw std::logic_error("A hand can only have 5 cards");
        }
    }

    // Returns reference to card list
    const std::vector<Card>& getCards() const {
        return cards;
    }

    // Check if hand has 5 cards
    bool isFull() const {
        return cards.size() == 5;
    }

    // Sort by value, then suit
    void sort() {
        std::sort(cards.begin(), cards.end(), [](const Card& a, const Card& b) {
            if (a.getValue() == b.getValue()) {
                return a.getSuitRank() < b.getSuitRank();
            }
            return a.getValue() < b.getValue();
        });
    }

    // String representation of the hand
    std::string toString() const {
        std::ostringstream sb;
        for (const auto& card : cards) {
            sb << card.toString() << " ";
        }
        std::string result = sb.str();
        if (!result.empty() && result.back() == ' ') {
            result.pop_back(); // remove trailing space
        }
        return result;
    }

    friend std::ostream& operator<<(std::ostream& os, const Hand& hand) {
    os << hand.toString();  // assumes you have a `toString()` method in Hand
    return os;
}


};

#endif // HAND_HPP
