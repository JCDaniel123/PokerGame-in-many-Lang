program main
    use deck_module
    use hand_module
    use pokerhandrank_module
    implicit none

    type(Deck) :: myDeck
    type(Hand) :: myHand
    type(Card) :: drawnCard
    type(PokerHandRank) :: handRank
    integer :: i

    ! Initialize deck using constructor
    myDeck = deck_constructor()
    call myDeck%shuffle()

    ! Initialize hand
    myHand = hand_constructor()

    ! Deal 5 cards to the hand
    do i = 1, 5
        drawnCard = myDeck%deal_card()
        call myHand%add_card(drawnCard)
    end do

    ! Sort the hand
    call myHand%sort()

    ! Display the hand
    print *, "Your Hand:"
    print *, myHand%to_string()

    ! Evaluate the hand rank
    handRank = pokerhand_constructor(myHand)
    print *, "Hand Evaluation:"
    print *, handRank%to_string()
end program main
