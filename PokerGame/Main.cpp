#include "Deck.hpp"
#include "Hand.hpp"
#include "PokerHandRank.hpp"
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <set>
#include <algorithm>

void formatting() {
    std::cout << "*** P O K E R  H A N D  A N A L Y Z E R ***\n\n";
    std::cout << " *** USING RANDOMIZED DECK OF CARDS ***\n\n";
}

void formattingForFile(const std::string& fileName) {
    std::cout << "*** P O K E R  H A N D  A N A L Y Z E R ***\n\n";
    std::cout << " *** USING TEST DECK ***\n\n";
    std::cout << "*** File Name: " << fileName << "\n";
}

int main(int argc, char* argv[]) {
    if (argc > 1) {
        std::string fileName = argv[1];
        formattingForFile(fileName);

        std::ifstream file(fileName);
        if (!file.is_open()) {
            std::cout << "Error: File not found - " << fileName << "\n";
            return 1;
        }

        std::vector<Hand> hands(6);
        std::set<std::string> seenCards;
        std::string line;
        int handIndex = 0;

        while (std::getline(file, line) && handIndex < 6) {
            std::cout << line << "\n";
            std::istringstream iss(line);
            std::string cardStr;
            while (iss >> cardStr) {
                if (seenCards.count(cardStr)) {
                    std::cout << "Error: Duplicate card detected - " << cardStr << "\n";
                    return 1;
                }
                seenCards.insert(cardStr);
                std::string rank = cardStr.substr(0, cardStr.size() - 1);
                char suit = cardStr.back();
                hands[handIndex].addCard(Card(rank, suit));
            }
            handIndex++;
        }

        std::cout << "\n*** Here are the six hands...\n";
        for (const auto& hand : hands) {
            std::cout << hand << "\n";
        }

        std::cout << "\n--- WINNING HAND ORDER ---\n";
        std::sort(hands.begin(), hands.end(), [](const Hand& a, const Hand& b) {
            return PokerHandRank(a).getRankValue() < PokerHandRank(b).getRankValue();
        });

        for (const auto& hand : hands) {
            PokerHandRank rank(hand);
            std::cout << hand << " - " << rank.getRankName() << "\n";
        }

    } else {
        formatting();
        Deck deck;
        deck.shuffle();

        std::cout << "*** Shuffled 52 Card Deck:\n";
        std::cout << deck << "\n\n";

        std::vector<Hand> hands(6);
        std::cout << "*** Here are the six hands...\n";
        for (int i = 0; i < 6; ++i) {
            for (int j = 0; j < 5; ++j) {
              hands[i].addCard(deck.dealCard());

            }
            std::cout << hands[i] << "\n";
        }

        std::cout << "\n*** Here is what remains in the deck...\n";
        std::cout << deck << "\n\n";

        std::cout << "--- WINNING HAND ORDER ---\n";
        std::sort(hands.begin(), hands.end(), [](const Hand& a, const Hand& b) {
            return PokerHandRank(a).getRankValue() < PokerHandRank(b).getRankValue();
        });

        for (const auto& hand : hands) {
            PokerHandRank rank(hand);
            std::cout << hand << " - " << rank.getRankName() << "\n";
        }
    }

    return 0;
}
