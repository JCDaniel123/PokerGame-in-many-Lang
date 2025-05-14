import java.util.ArrayList;
import java.util.Collections;

public class Deck {
      
      private ArrayList<Card> cards;

      public Deck(){
        cards = new ArrayList<>();
        
        // All possible ranks
        String[]ranks = {"A", "2", "3", "4", "5", "6" , "7", "8" , "9" ,"10" ,"J" , "Q" , "K"};

        //All possible suits
        char[] suits = {'C','D','H','S'};

        for(char suit : suits){
            for(String rank : ranks){
                cards.add(new Card(rank,suit));
            }
        }

      }
     
      public void shuffle(){
        Collections.shuffle(cards);
      }

      public Card dealCard(){
        if(!cards.isEmpty()){
            return cards.remove(0);
        } else{
            return null;
        }
      }

      public int size(){
        return cards.size();
      }

      public boolean isEmpty(){
        return cards.isEmpty();
      }

      public String toString(){
        StringBuilder sb = new StringBuilder(); // a way to save memory by using string builder and is better for repeated concatenation
        int count = 0;
        for(Card card:cards){ // a for each loop for each card in the hand(cards list)
          sb.append(card.getRank()).append(card.getSuit()).append(" "); // attaches the card value and rank together and prints a space everyrime a card is printed from the hand
          count++;

          //Start a new line after every 13 cards
          if( count % 13 == 0){
             sb.append("\n");
          }

        }
   
        return sb.toString().trim(); // converts the string builder into a string and trims any leading spaces off.
   
      }

}
