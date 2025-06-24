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
    // Constructor
    Deck() {
        // All possible ranks
        std::array<std::string, 13> ranks = {"A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"};
        // All possible suits
        std::array<char, 4> suits = {'C', 'D', 'H', 'S'};

        // Reserve space for 52 cards to avoid reallocations
        cards.reserve(52);
        for (char suit : suits) {
            for (const std::string& rank : ranks) {
                cards.emplace_back(rank, suit);
            }
        }
    }

    // Shuffle the deck
    void shuffle() {
        // Use a random device and engine for shuffling
        std::random_device rd;
        std::mt19937 g(rd());
        std::shuffle(cards.begin(), cards.end(), g);
    }

    // Deal and remove the top card (from the end for efficiency)
    Card* dealCard() {
        if (!cards.empty()) {
            Card* card = new Card(cards.back());
            cards.pop_back();
            return card;
        }
        return nullptr;
    }

    // Return the number of cards in the deck
    int size() const {
        return cards.size();
    }

    // Check if the deck is empty
    bool isEmpty() const {
        return cards.empty();
    }

    // Return string representation of the deck
    std::string toString() const {
        std::stringstream sb;
        int count = 0;
        for (const Card& card : cards) {
            sb << card.toString() << " ";
            count++;
            // Start a new line after every 13 cards
            if (count % 13 == 0) {
                sb << "\n";
            }
        }
        // Trim trailing whitespace
        std::string result = sb.str();
        while (!result.empty() && result.back() == ' ') {
            result.pop_back();
        }
        if (!result.empty() && result.back() == '\n') {
            result.pop_back();
        }
        return result;
    }

    // Friend function to overload operator<< for printing
    friend std::ostream& operator<<(std::ostream& os, const Deck& deck) {
        os << deck.toString();
        return os;
    }
};

#endif // DECK_HPP