import java.util.Arrays;
import java.util.Comparator;
import java.util.Scanner;

public class Main {

    public static void main(String[]args){
    
       Scanner scanner = new Scanner(System.in); // why need this?
       Hand[] hands = new Hand[6];

       formatting();
       Deck deck = new Deck();
       deck.shuffle();
       System.out.println("*** Shuffled 52 Card Deck:");
       System.out.println(deck);
       System.out.println(" ");
        
       System.out.println("*** Here are the six hands...");
    for(int i = 0;i < 6; i++){
         hands[i] = new Hand();
       for(int j = 0; j < 5; j++){ // did we need the nested loop? dont use j anywhere in the loop
           hands[i].addCard(deck.dealCard());
       }
       System.out.println(hands[i]);
    }
    System.out.println(" ");
    System.out.println("*** Here is what remains in the deck...");
    System.out.println(deck);
    System.out.println(" ");

    System.out.println("--- WINNING HAND ORDER ---");
    Arrays.sort(hands, Comparator.comparingInt(hand -> new PokerHandRank(hand).evaluateHand(hand))); // detailed explanation of how this works
    for(int k = 0; k< hands.length; k++){
        PokerHandRank rank = new PokerHandRank(hands[k]);
        System.out.println(hands[k] + " - " + rank.getRankName());
    }
 }

    public static void formatting(){

        System.out.println("*** P O K E R  H A N D  A N A L Y Z E R *** ");
        System.out.println(" ");
        System.out.println(" *** USING RANDOMIZED DECK OF CARDS *** ");
        System.out.println(" ");
        System.out.println(" ");


    }

    
}
