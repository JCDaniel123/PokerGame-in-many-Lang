program main
    use deck_module
    use hand_module
    use pokerhandrank_module
    use helper_module
    use card_module
    use file_reader_module
    implicit none

    type(Deck) :: myDeck
    type(Hand) :: myHand(6)
    type(Card) :: drawnCard
    type(PokerHandRank) :: handRank(6)
    integer :: i, j, ierr
    integer :: arg_count
    character(len=200) :: filename
    character(len=3), allocatable :: all_cards(:)
    character(len=3) :: temp_card
    integer :: file_unit, ios, total_cards

    call random_seed() ! Seed RNG

    arg_count = command_argument_count()

    if (arg_count > 0) then
        ! -------- FILE INPUT MODE --------
        call get_command_argument(1, filename)
        print *, "*** P O K E R   H A N D   A N A L Y Z E R ***"
        print *, "*** USING TEST DECK ***"
        print *, "*** File: ", trim(filename)

        open(newunit=file_unit, file=trim(filename), status='old', action='read', iostat=ios)
        if (ios /= 0) then
            print *, "*** ERROR - Unable to open file ***"
            stop
        end if

        allocate(all_cards(0))
        total_cards = 0

       call read_cards_from_file(filename, all_cards)
       total_cards = size(all_cards)

       close(file_unit)


do i = 1, 5
    read(10, *, iostat=ierr) drawnCard
    if (ierr /= 0) exit
    total_cards = total_cards + 1
end do

        close(file_unit)

        if (total_cards /= 30) then
            print *, "*** ERROR - Expected 30 cards (6 hands), found ", total_cards, " ***"
            stop
        end if

        ! Fill hands from file
        do i = 1, 6
            myHand(i) = hand_constructor()
            do j = 1, 5
                call myHand(i)%add_card(card_from_string(all_cards((i-1)*5 + j)))
            end do
            call myHand(i)%sort()
            handRank(i) = pokerhand_constructor(myHand(i))
        end do

    else
        ! -------- RANDOMIZED DECK MODE --------
        myDeck = deck_constructor()
        call myDeck%shuffle()

        print *, "*** P O K E R   H A N D   A N A L Y Z E R ***"
        print *, ""
        print *, "*** USING RANDOMIZED DECK OF CARDS ***"
        print *, ""
        print *, "*** Shuffled 52 card deck:"
        call print_deck(myDeck)
        print *, ""

        do i = 1, 6
            myHand(i) = hand_constructor()
            do j = 1, 5
                drawnCard = myDeck%deal_card()
                call myHand(i)%add_card(drawnCard)
            end do
            call myHand(i)%sort()
            handRank(i) = pokerhand_constructor(myHand(i))
        end do

        print *, "*** Here is what remains in the deck..."
        call print_deck(myDeck)
        print *, ""
    end if

    ! Print the hands
    print *, "*** Here are the six hands..."
    do i = 1, 6
        call print_hand(myHand(i))
    end do
    print *, ""

    ! Sort by rank (lowest rank_value = best hand)
    call sort_hands_by_rank(handRank, myHand)

    ! Show winning order
     print *, "--- WINNING HAND ORDER ---"
do i = 1, 6
    call print_hand(myHand(i), .false.)       ! Print hand WITHOUT newline
    print *, "- ", trim(handRank(i)%to_string())  ! Print rank on the same line
end do
contains

end program main
