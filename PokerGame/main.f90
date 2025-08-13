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
    integer :: i,j, ios
    character(len=3) :: cardStr
    logical :: duplicateFound
    type(Card), allocatable :: allCards(:)
    integer :: numHands, cardsPerHand, numCards

    logical :: readFromFile
    character(len=100) :: fileName

     ! Parameters
    numHands = 6
    cardsPerHand = 5
    numCards = numHands * cardsPerHand
    allocate(allCards(numCards))

    ! Ask user or set to read from file
    print *, "Read hands from file? (T/F):"
    read(*,*) readFromFile

    if (readFromFile) then
        print *, "Enter file name:"
        read(*,'(A)') fileName
        open(unit=10, file=fileName, status='old', action='read', iostat=ios)
        if (ios /= 0) then
            print *, "Error opening file."
            stop
        end if

        do i = 1, numHands
            myHand(i) = hand_constructor()
            do j = 1, cardsPerHand
                read(10,'(A3)', iostat=ios) cardStr
                if (ios /= 0) then
                    print *, "Error reading card from file."
                    stop
                end if
                allCards((i-1)*cardsPerHand + j) = card_from_string(cardStr)
                call myHand(i)%add_card(allCards((i-1)*cardsPerHand + j))
            end do
            call myHand(i)%sort()
        end do
        close(10)

        ! Check for duplicates
        duplicateFound = .false.
        do i = 1, numCards - 1
            do j = i + 1, numCards
                if (allCards(i)%rank == allCards(j)%rank .and. allCards(i)%suit == allCards(j)%suit) then
                    print *, "*** ERROR - DUPLICATED CARD FOUND IN DECK ***"
                    print *, "*** DUPLICATE: ", trim(card_to_string(allCards(i))) , "***"
                    duplicateFound = .true.
                    exit
                end if
            end do
            if (duplicateFound) exit
        end do

        if (duplicateFound) stop

        ! Rank hands
        do i = 1, numHands
            handRank(i) = pokerhand_constructor(myHand(i))
        end do

        ! Print hands from file with ranks
        print *, "*** Hands read from file ***"
        do i = 1, numHands
            call print_hand(myHand(i), .false.)
            print *, "- ", trim(handRank(i)%to_string())
        end do

    else
        ! Your existing code dealing from deck here:

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
    call print_hand(myHand(i), .false.)       ! Print hand WITHOUT newline
    print *, "- ", trim(handRank(i)%to_string())  ! Print rank on the same line
end do


end if
end program main




