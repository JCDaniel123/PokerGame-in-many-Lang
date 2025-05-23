import java.util.Arrays;
import java.util.Comparator;
import java.util.Scanner;
import java.util.HashSet;
import java.util.Set;
import java.io.File;
import java.io.FileNotFoundException;


public class Main {

    public static void main(String[]args){
       
       // Check if filename was passed
       if(args.length > 0){      
           String fileName = args[0];
            
           try{
              // open the file and prepare to scan
              File file = new File(fileName);
              Scanner fileScanner = new Scanner(file);
              formattingForFile();
               System.out.println("*** File Name: "+ fileName);

               // Set up data structures
              Hand[] hands = new Hand[6]; // array to store 6 hands;
              Set<String> seenCards = new HashSet<>(); // to track duplicate cards
              int handIndex = 0; // counts the number of hands
              
               

              // loop through lines (hands)
              while (fileScanner.hasNextLine() && handIndex < 6) {
                    String line = fileScanner.nextLine().trim();
                    System.out.println(line); // print raw hand line
                    hands[handIndex] = new Hand();
                    String[] cardStrings = line.split(" "); // plits the line (like "7C AD 9H 10S KD") into individual card strings: ["7C", "AD", "9H", "10S", "KD"]
                    

                    // loop through each card in the line
                    for (String cardStr : cardStrings){
                        if(seenCards.contains(cardStr)){
                             System.out.println( "Error: Duplicate card detected - " + cardStr);
                             fileScanner.close();
                             return;
                        }

                        seenCards.add(cardStr);
                        String rank = cardStr.substring(0, cardStr.length() - 1);
                        char suit = cardStr.charAt(cardStr.length()-1);
                        hands[handIndex].addCard(new Card(rank,suit));
                    }

                    handIndex++;
              }

              fileScanner.close();
              System.out.println("  ");
              System.out.println("*** Here are the  six hands...");
              for(int k = 0; k< hands.length; k++){
        PokerHandRank rank = new PokerHandRank(hands[k]);
        System.out.println(hands[k]);
      }
        System.out.println(" ");
      System.out.println("--- WINNING HAND ORDER ---");
    Arrays.sort(hands, Comparator.comparingInt(hand -> new PokerHandRank(hand).evaluateHand(hand))); // detailed explanation of how this works
        for(int k = 0; k< hands.length; k++){
        PokerHandRank rank = new PokerHandRank(hands[k]);
        System.out.println(hands[k] + " - " + rank.getRankName());
      }
    } catch (FileNotFoundException e){
             System.out.println("Error: File not found -" + fileName);
    }

  }else {
    
     

       formatting();
       Deck deck = new Deck();
       deck.shuffle();
       Hand[] hands = new Hand[6];
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
 }

    public static void formatting(){

        System.out.println("*** P O K E R  H A N D  A N A L Y Z E R *** ");
        System.out.println(" ");
        System.out.println(" *** USING RANDOMIZED DECK OF CARDS *** ");
        System.out.println(" ");
        System.out.println(" ");


    }

     public static void formattingForFile(){

        System.out.println("*** P O K E R  H A N D  A N A L Y Z E R *** ");
        System.out.println(" ");
        System.out.println(" *** USING TEST DECK *** ");
        System.out.println(" ");
        System.out.println(" ");


    }

    
}
