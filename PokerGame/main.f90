program main
    use deck_module
    use hand_module
    use pokerhandrank_module
    use helper_module
    implicit none

    type(Deck) :: myDeck
    type(Hand) :: myHand(6)
    type(Card) :: drawnCard
    type(PokerHandRank) :: handRank(6)
    integer :: i,j

    call random_seed() !Seed the random number generator

    !initialize and shuffle the deck
    myDeck = deck_constructor()
    call myDeck%shuffle()

    ! Print header
     print *, "*** P O K E R   H A N D   A N A L Y Z E R ***"
    print *, ""
    print *, "*** USING RANDOMIZED DECK OF CARDS ***"
    print *, ""
    print *, "*** Shuffled 52 card deck:"
    call print_deck(myDeck)
    print *, ""

    ! Deal 6 hands of 5 cards each

    do i = 1, 6
        myHand(i) = hand_constructor()
        do j = 1, 5
            drawnCard = myDeck%deal_card()
            call myHand(i)%add_card(drawnCard)
        end do
        call myHand(i)%sort()
        handrank(i) = pokerhand_constructor(myHand(i))
    end do



    ! Initialize hand
!   myHand = hand_constructor()


    ! Print the hands
    print *, "*** Here are the six hands..."
    do i = 1, 6
        call print_hand(myHand(i))
    end do
    print *, ""

    ! Print remaining cards
    print *, "*** Here is what remains in the deck..."
    call print_deck(myDeck)
    print *, ""

    ! Sort ranks from best to worst (lowest value is best)
    call sort_hands_by_rank(handRank,myHand)

    ! Display the sorted results
    print *, "--- WINNING HAND ORDER ---"
    do i = 1, 6
        print *, trim(handRank(i)%to_string())
    end do
end program main


