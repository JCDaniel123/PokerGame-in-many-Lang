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
    // Constructor evaluates and stores the hand rank
    PokerHandRank(const Hand& hand) {
        sortedCards = hand.getCards();
        Hand tempHand = hand;
        tempHand.sort(); // Sort copy
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
        return isStraightFlush() && sortedCards[0].getValue() == 10;
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
            if (sortedCards[i + 1].getValue() != sortedCards[i].getValue() + 1)
                return false;
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
        bool isFull = isFullHouse();
        for (const auto& pair : counts) {
            if (pair.second == 3 && !isFull) return true;
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
        bool twoPair = isTwoPair();
        for (const auto& pair : counts) {
            if (pair.second == 2 && !twoPair) return true;
        }
        return false;
    }
};

#endif // POKER_HAND_RANK_HPP
