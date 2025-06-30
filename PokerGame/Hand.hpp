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
    Hand() {}

    void addCard(const Card& card) {
        if (cards.size() < 5) {
            cards.push_back(card);
        } else {
            throw std::runtime_error("A hand can only have 5 cards");
        }
    }

    const std::vector<Card>& getCards() const {
        return cards;
    }

    bool isFull() const {
        return cards.size() == 5;
    }

    void sort() {
        std::sort(cards.begin(), cards.end(), [](const Card& a, const Card& b) {
            if (a.getValue() == b.getValue()) {
                return a.getSuitRank() < b.getSuitRank();
            }
            return a.getValue() < b.getValue();
        });
    }

    std::string toString() const {
        std::ostringstream sb;
        for (const auto& card : cards) {
            sb << card.toString() << " ";
        }
        std::string result = sb.str();
        if (!result.empty() && result.back() == ' ') {
            result.pop_back();
        }
        return result;
    }

    friend std::ostream& operator<<(std::ostream& os, const Hand& hand) {
        os << hand.toString();
        return os;
    }
};

#endif // HAND_HPP