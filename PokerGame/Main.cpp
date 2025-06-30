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
    std::cout << "*** File Name: " << fileName << "\n\n";
}

int main(int argc, char* argv[]) {
    try {
        if (argc > 1) {
            std::string fileName = argv[1];
            formattingForFile(fileName);

            std::ifstream file(fileName);
            if (!file.is_open()) {
                std::cout << "Error: File not found - " << fileName << "\n";
                return 1;
            }

            std::vector<Hand> hands;
            std::set<std::string> seenCards;
            std::string line;
            while (std::getline(file, line) && hands.size() < 6) {
                if (line.empty()) continue;
                std::cout << line << "\n";
                std::istringstream iss(line);
                std::string cardStr;
                Hand hand;
                int cardCount = 0;
                while (iss >> cardStr) {
                    if (seenCards.count(cardStr)) {
                        std::cout << "Error: Duplicate card detected - " << cardStr << "\n";
                        return 1;
                    }
                    seenCards.insert(cardStr);
                    std::string rank = cardStr.substr(0, cardStr.size() - 1);
                    char suit = cardStr.back();
                    hand.addCard(Card(rank, suit));
                    cardCount++;
                }
                if (cardCount != 5) {
                    std::cout << "Error: Hand must have exactly 5 cards - " << line << "\n";
                    return 1;
                }
                hands.push_back(hand);
            }
            if (hands.size() != 6) {
                std::cout << "Error: File must contain exactly 6 hands\n";
                return 1;
            }

            std::cout << "\n*** Here are the six hands...\n";
            for (const auto& hand : hands) {
                std::cout << hand.toString() << "\n";
            }

            std::cout << "\n--- WINNING HAND ORDER ---\n";
            std::sort(hands.begin(), hands.end(), [](const Hand& a, const Hand& b) {
                return PokerHandRank(a).getRankValue() > PokerHandRank(b).getRankValue();
            });

            for (const auto& hand : hands) {
                PokerHandRank rank(hand);
                std::cout << hand.toString() << " - " << rank.getRankName() << "\n";
            }
        } else {
            formatting();
            Deck deck;
            deck.shuffle();

            std::cout << "*** Shuffled 52 Card Deck:\n";
            std::cout << deck.toString() << "\n\n";

            std::vector<Hand> hands(6);
            for (auto& hand : hands) {
                for (int j = 0; j < 5; ++j) {
                    hand.addCard(deck.dealCard());
                }
            }

            std::cout << "*** Here are the six hands...\n";
            for (const auto& hand : hands) {
                std::cout << hand.toString() << "\n";
            }

            std::cout << "\n*** Here is what remains in the deck...\n";
            std::cout << deck.toString() << "\n\n";

            std::cout << "--- WINNING HAND ORDER ---\n";
            std::sort(hands.begin(), hands.end(), [](const Hand& a, const Hand& b) {
                return PokerHandRank(a).getRankValue() > PokerHandRank(b).getRankValue();
            });

            for (const auto& hand : hands) {
                PokerHandRank rank(hand);
                std::cout << hand.toString() << " - " << rank.getRankName() << "\n";
            }
        }
    } catch (const std::exception& e) {
        std::cout << "Error: " << e.what() << "\n";
        return 1;
    }

    return 0;
}