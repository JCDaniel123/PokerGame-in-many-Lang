public class Card {

    //Variables for Class
    private String rank; 
    private char suit;

    public Card( String r, char s){ // Made constructer for Card object
          this.rank = r;
          this.suit = s;
    }

    public int getValue(){
         
        switch (rank){ // Switch statement for all cases of card values
            case "A": return 1;
            case "2": return 2;
            case "3": return 3;
            case "4": return 4;
            case "5": return 5;
            case "6": return 6;
            case "7": return 7;
            case "8": return 8;
            case "9": return 9;
            case "10":return 10;
            case "J": return 11;
            case "Q": return 12;
            case "K": return 13;
            default: return 0;
        }
    }

    public int getSuitRank(){
         switch (suit){
                case 'C' : return 1; //Clubs
                case 'D' : return 2; //Diamonds
                case 'H' : return 3;// Hearts
                case 'S' : return 4;// Spades
                default: return 0;
         }
    }

   public String toString(){ // prints out cards better
          
          return rank + suit;

   }

   // allows for direct getting of the variables
   public char getSuit(){ 
    return suit;
   }

   public String getRank(){
     return rank; 
   }

}
