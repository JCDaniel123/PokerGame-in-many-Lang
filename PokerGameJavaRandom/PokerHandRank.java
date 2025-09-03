import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Collections;


public class PokerHandRank {

    private int rankValue;
    private List<Card> sortedCards;
    

    public PokerHandRank(Hand hand){ // object for the rank of the poker hand
        this.sortedCards = hand.getCards();
        hand.sort();
        this.rankValue = evaluateHand(hand); // evaluates the rank of the hand of cards
    }

    public int getRankValue(){
        return this.rankValue; // a getter method for public access of the rankvalue variable
    }

    public int evaluateHand(Hand hand){ // method for deciding the rank of the hand
        if (isRoyalFlush()) return 1;
        if (isStraightFlush()) return 2;
        if (isFourOfAKind()) return 3;
        if (isFullHouse()) return 4;
        if (isFlush()) return 5;
        if (isStraight()) return 6;
        if (isThreeOfAKind()) return 7;
        if (isTwoPair()) return 8;
        if (isPair()) return 9;
        return 10;
       
    }

    public String getRankName(){

        if (isRoyalFlush())    return "Royal Flush";
        if (isStraightFlush()) return "Straight Flush";
        if (isFourOfAKind())   return   "Four of a Kind";
        if (isFullHouse()) return "Full House";
        if (isFlush()) return "Flush";
        if (isStraight()) return "Straight";
        if (isThreeOfAKind()) return "Three of a Kind";
        if (isTwoPair()) return "Two Pair";
        if (isPair()) return "One Pair";
        return "High Card";

      
    }  

    private boolean isRoyalFlush(){ // the logic for a royal flush 
        return isStraightFlush() && sortedCards.get(0).getValue() == 10;
    }

    private boolean isStraightFlush(){
        return isFlush() && isStraight();
    }

    private boolean isFlush(){
        char suit = sortedCards.get(0).getSuit();
        for (Card card : sortedCards) {
             if (card.getSuit() != suit) return false;
        }
        
        return true;
    }

    private boolean isStraight(){
        for (int i=0; i < sortedCards.size() -1; i++){
            if(sortedCards.get(i + 1).getValue() != sortedCards.get(i).getValue()+ 1){
                return false;
            }
        }
        return true;
    }

    private Map<Integer,Integer> getValueCounts(){
        Map<Integer,Integer> counts = new HashMap<>();
        for(Card card : sortedCards){
            counts.put(card.getValue(),counts.getOrDefault(card.getValue(),0) + 1);
        }
        return counts;
    }

    private boolean isFourOfAKind(){
          Map<Integer, Integer> valueCounts = getValueCounts();
          return valueCounts.containsValue(4);

    }
    private boolean isFullHouse(){
        Map<Integer, Integer> valueCounts = getValueCounts();
        return valueCounts.containsValue(3) && valueCounts.containsValue(2);
    }

    private boolean isThreeOfAKind(){
        Map<Integer,Integer> valueCounts = getValueCounts();
        return valueCounts.containsValue(3) && !isFullHouse();
    }

    private boolean isTwoPair(){
        Map<Integer , Integer> valueCounts = getValueCounts();
        int pairCount = 0;
        for(int count : valueCounts.values()){
            if(count == 2){
                pairCount++;
            } 
        }
        return pairCount == 2;
    }

    private boolean isPair(){
       Map<Integer , Integer> valueCounts = getValueCounts();
       return valueCounts.containsValue(2) && !isTwoPair();
    }

    public String toString(){
        return "Rank: " + rankValue + ", Cards: " + sortedCards;
    }
    
}
