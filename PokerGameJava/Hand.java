import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class Hand {
// Add comments to code here
   private List<Card> cards; // List interface that allows for quick data structure changes for cards if needed 

  public Hand(){
    this.cards = new ArrayList<>(); // chose a array list for the data structure
  } 

  public void addCard(Card card){ // adds card objects(cards) to the hand which is max at 5 cards
     if(cards.size()<5){
        cards.add(card);
      }else{
            throw new IllegalStateException("A hand can only have 5 cards");
        }
     }

  public List<Card> getCards(){ // Gets the list of cards aka the hand's cards
    return this.cards;
  }

  public boolean isFull(){ // returns a true if the cards list equals 5
    return this.cards.size()==5;
  }

  public void sort(){ // sorts the 2 parts of a card.The value  of the card and if needed the suit rank
     Collections.sort(this.cards,Comparator.comparingInt(Card::getValue).thenComparingInt(Card::getSuitRank));

  }

   public String toString(){
     StringBuilder sb = new StringBuilder(); // a way to save memory by using string builder and is better for repeated concatenation
     for(Card card:cards){ // a for each loop for each card in the hand(cards list)
         sb.append(card.getRank()).append(card.getSuitRank()).append(" "); // attaches the card value and rank together and prints a space everyrime a card is printed from the hand
     }

     return sb.toString().trim(); // converts the string builder into a string and trims any leading spaces off.

   }

   public int evaluateHand(){
    
    // place holder for the hand ranking logic
    
    return 0;

   }

}
