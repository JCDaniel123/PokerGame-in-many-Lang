#ifndef POKER_HAND_RANK_HPP
#define POKER_HAND_RANK_HPP

#include "Hand.hpp"
#include <map>
#include <sstream>
#include <string>

class PokerHandRank {
private:
    int rankValue;
    std::vector<Card> sortedCards;

public:
    PokerHandRank(const Hand& hand) {
        sortedCards = hand.getCards();
        std::sort(sortedCards.begin(), sortedCards.end(), [](const Card& a, const Card& b) {
            if (a.getValue() == b.getValue()) {
                return a.getSuitRank() < b.getSuitRank();
            }
            return a.getValue() < b.getValue();
        });
        rankValue = evaluateHand();
    }

    int getRankValue() const {
        return rankValue;
    }

    std::string getRankName() const {
        if (isRoyalFlush())    return "Royal Flush";
        if (isStraightFlush()) return "Straight Flush";
        if (isFourOfAKind())   return "Four of a Kind";
        if (isFullHouse())     return "Full House";
        if (isFlush())         return "Flush";
        if (isStraight())      return "Straight";
        if (isThreeOfAKind())  return "Three of a Kind";
        if (isTwoPair())       return "Two Pair";
        if (isPair())          return "One Pair";
        return "High Card";
    }

    std::string toString() const {
        std::ostringstream oss;
        oss << "Rank: " << rankValue << ", Cards: ";
        for (const Card& card : sortedCards) {
            oss << card.toString() << " ";
        }
        return oss.str();
    }

private:
    int evaluateHand() {
        if (isRoyalFlush())    return 1;
        if (isStraightFlush()) return 2;
        if (isFourOfAKind())   return 3;
        if (isFullHouse())     return 4;
        if (isFlush())         return 5;
        if (isStraight())      return 6;
        if (isThreeOfAKind())  return 7;
        if (isTwoPair())       return 8;
        if (isPair())          return 9;
        return 10;
    }

    bool isRoyalFlush() const {
        return isStraightFlush() && sortedCards.back().getValue() == 14; // Ace is highest
    }

    bool isStraightFlush() const {
        return isFlush() && isStraight();
    }

    bool isFlush() const {
        char suit = sortedCards[0].getSuit();
        for (const auto& card : sortedCards) {
            if (card.getSuit() != suit) return false;
        }
        return true;
    }

    bool isStraight() const {
        for (size_t i = 0; i < sortedCards.size() - 1; ++i) {
            if (sortedCards[i + 1].getValue() != sortedCards[i].getValue() + 1) {
                if (sortedCards[0].getValue() == 2 && sortedCards[1].getValue() == 3 &&
                    sortedCards[2].getValue() == 4 && sortedCards[3].getValue() == 5 &&
                    sortedCards[4].getValue() == 14) {
                    return true;
                }
                return false;
            }
        }
        return true;
    }

    std::map<int, int> getValueCounts() const {
        std::map<int, int> counts;
        for (const auto& card : sortedCards) {
            counts[card.getValue()]++;
        }
        return counts;
    }

    bool isFourOfAKind() const {
        auto counts = getValueCounts();
        for (const auto& pair : counts) {
            if (pair.second == 4) return true;
        }
        return false;
    }

    bool isFullHouse() const {
        auto counts = getValueCounts();
        bool hasThree = false, hasTwo = false;
        for (const auto& pair : counts) {
            if (pair.second == 3) hasThree = true;
            if (pair.second == 2) hasTwo = true;
        }
        return hasThree && hasTwo;
    }

    bool isThreeOfAKind() const {
        auto counts = getValueCounts();
        for (const auto& pair : counts) {
            if (pair.second == 3) return true;
        }
        return false;
    }

    bool isTwoPair() const {
        auto counts = getValueCounts();
        int pairCount = 0;
        for (const auto& pair : counts) {
            if (pair.second == 2) pairCount++;
        }
        return pairCount == 2;
    }

    bool isPair() const {
        auto counts = getValueCounts();
        for (const auto& pair : counts) {
            if (pair.second == 2) return true;
        }
        return false;
    }
};

#endif // POKER_HAND_RANK_HPP