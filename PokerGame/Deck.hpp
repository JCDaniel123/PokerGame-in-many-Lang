#ifndef DECK_HPP
#define DECK_HPP

#include "Card.hpp"
#include <vector>
#include <array>
#include <algorithm>
#include <random>
#include <sstream>
#include <string>

class Deck {
private:
    std::vector<Card> cards;

public:
    Deck() {
        std::array<std::string, 13> ranks = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"};
        std::array<char, 4> suits = {'C', 'D', 'H', 'S'};
        cards.reserve(52);
        for (char suit : suits) {
            for (const std::string& rank : ranks) {
                cards.emplace_back(rank, suit);
            }
        }
    }

    void shuffle() {
        std::random_device rd;
        std::mt19937 g(rd());
        std::shuffle(cards.begin(), cards.end(), g);
    }

    Card dealCard() {
        if (!cards.empty()) {
            Card card = cards.back();
            cards.pop_back();
            return card;
        }
        throw std::out_of_range("No cards left in the deck");
    }

    int size() const {
        return cards.size();
    }

    bool isEmpty() const {
        return cards.empty();
    }

    std::string toString() const {
        std::stringstream sb;
        int count = 0;
        for (const Card& card : cards) {
            sb << card.toString() << " ";
            count++;
            if (count % 13 == 0) {
                sb << "\n";
            }
        }
        std::string result = sb.str();
        while (!result.empty() && result.back() == ' ') {
            result.pop_back();
        }
        if (!result.empty() && result.back() == '\n') {
            result.pop_back();
        }
        return result;
    }

    friend std::ostream& operator<<(std::ostream& os, const Deck& deck) {
        os << deck.toString();
        return os;
    }
};

#endif // DECK_HPP