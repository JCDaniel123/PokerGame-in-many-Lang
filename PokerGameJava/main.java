import java.util.Scanner;

public class Main {

    public static void main(String[]args){
    
       Scanner scanner = new Scanner(System.in);
       
       formatting();
       Deck deck = new Deck();
       deck.shuffle();
       System.out.println("*** Shuffled 52 Card Deck:");
       System.out.println(deck);
       System.out.println(" ");
        
       System.out.println("*** Here are the six hands...");
    for(int i = 0;i < 6; i++){
        Hand hand = new Hand();
       for(int j = 0; j < 5; j++){
           hand.addCard(deck.dealCard());
       }
       System.out.println(hand);
    }
    System.out.println(" ");
    System.out.println("*** Here is what remains in the deck...");
    System.out.println(deck);

    System.out.println("--- WINNING HAND ORDER ---");
    
     
    }

    public static void formatting(){

        System.out.println("*** P O K E R  H A N D  A N A L Y Z E R *** ");
        System.out.println(" ");
        System.out.println(" *** USING RANDOMIZED DECK OF CARDS *** ");
        System.out.println(" ");
        System.out.println(" ");


    }

    
}
