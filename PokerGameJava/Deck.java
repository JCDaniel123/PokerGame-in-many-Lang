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

}
