import java.util.Scanner;

public class main {

    public static void main(String[]args){
    
       Scanner scanner = new Scanner(System.in);

       Deck deck = new Deck();
       deck.shuffle();
       Hand hand = new Hand();


       for(int i = 0; i < 5; i++){
           hand.addCard(deck.dealCard());
       }

       System.out.println("Your hand: " + hand);

       hand.sort();
       System.out.println("Sorted Hand: " + hand);

       
       PokerHandRank rank  = new PokerHandRank(hand);
       System.out.println("Hand Rank: " + rank.getRankName());
    }
    
}
