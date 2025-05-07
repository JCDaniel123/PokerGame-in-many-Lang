import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class Hand {
// Add comments to code here
   private List<Card> cards;

  public Hand(){
    this.cards = new ArrayList<>();
  } 

  public void addCard(Card card){
     if(cards.size()<5){
        cards.add(card);
      }else{
            throw new IllegalStateException("A hand can only have 5 cards");
        }
     }

  public List<Card> getCards(){
    return this.cards;
  }

  public boolean isFull(){
    return this.cards.size()==5;
  }

  public void sort(){
     Collections.sort(this.cards,Comparator.comparingInt(Card::getValue).thenComparingInt(Card::getSuitRank));

  }
// whats happening here?
   public String toString(){
     StringBuilder sb = new StringBuilder();
     for(Card card:cards){
         sb.append(card.getRank()).append(card.getSuitRank()).append(" ");
     }

     return sb.toString().trim();

   }

}
