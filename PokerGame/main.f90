program poker_hand_analyzer
    use card_module
    use deck_module
    use hand_module
    use pokerhandrank_module  ! Changed from poker_hand_rank_module
    implicit none
    
    integer, parameter :: MAX_HANDS = 6
    type(Hand) :: hands(MAX_HANDS)
    type(Deck) :: deck
    type(Card) :: dealt_card
    type(PokerHandRank) :: rank  ! Changed from Poker_Hand_Rank
    character(len=100) :: filename, line
    integer :: i, j, hand_index, ios
    character(len=3) :: card_str
    logical :: seen_cards(52) = .false. ! Assuming 52 unique cards
    
    ! Check command-line argument
    if (command_argument_count() > 0) then
        call get_command_argument(1, filename)
        call formatting_for_file()
        write(*, '(A, A)') "*** File Name: ", trim(filename)
        
        ! Open and read file
        open(unit=10, file=filename, status='old', action='read', iostat=ios)
        if (ios /= 0) then
            write(*, '(A, A)') "Error: File not found - ", trim(filename)
            stop
        end if
        
        hand_index = 1
        do while (hand_index <= MAX_HANDS .and. ios == 0)
            read(10, '(A)', iostat=ios) line
            if (ios /= 0) exit
            line = adjustl(line)
            write(*, '(A)') trim(line) ! Print raw hand line
            
            ! Split line into cards
            call parse_hand(line, hands(hand_index), seen_cards)
            hand_index = hand_index + 1
        end do
        
        close(10)
        write(*, *)
        write(*, '(A)') "*** Here are the six hands..."
        do i = 1, MAX_HANDS
            if (hands(i)%current_size > 0) then
                rank = PokerHandRank(hands(i))  ! Changed from Poker_Hand_Rank
                write(*, '(A)') trim(hands(i)%to_string())
            end if
        end do
        write(*, *)
        write(*, '(A)') "--- WINNING HAND ORDER ---"
        call sort_hands(hands)
        do i = 1, MAX_HANDS
            if (hands(i)%current_size > 0) then
                rank = PokerHandRank(hands(i))  ! Changed from Poker_Hand_Rank
                write(*, '(A, A)') trim(hands(i)%to_string()), " - ", trim(rank%get_rank_name())
            end if
        end do
    else
        call formatting()
        deck = Deck()  ! Check if constructor needs arguments
        call deck%shuffle()
        write(*, '(A)') "*** Shuffled 52 Card Deck:"
        write(*, '(A)') trim(deck%to_string())
        write(*, *)
        
        write(*, '(A)') "*** Here are the six hands..."
        do i = 1, MAX_HANDS
            hands(i) = Hand()  ! Check if constructor needs arguments
            do j = 1, 5
                dealt_card = deck%deal_card()
                call hands(i)%add_card(dealt_card)
            end do
            write(*, '(A)') trim(hands(i)%to_string())
        end do
        write(*, *)
        write(*, '(A)') "*** Here is what remains in the deck..."
        write(*, '(A)') trim(deck%to_string())
        write(*, *)
        
        write(*, '(A)') "--- WINNING HAND ORDER ---"
        call sort_hands(hands)
        do i = 1, MAX_HANDS
            rank = PokerHandRank(hands(i))  ! Changed from Poker_Hand_Rank
            write(*, '(A, A)') trim(hands(i)%to_string()), " - ", trim(rank%get_rank_name())
        end do
    end if
    
contains

    subroutine parse_hand(line, hand, seen_cards)
        character(len=*), intent(in) :: line
        type(Hand), intent(inout) :: hand
        logical, intent(inout) :: seen_cards(:)
        character(len=3) :: card_str
        character(len=2) :: rank
        character :: suit
        integer :: i, pos
        
        pos = 1
        do i = 1, 5
            if (pos > len_trim(line)) exit
            card_str = line(pos:pos+2)
            if (seen_cards(card_index(card_str))) then
                write(*, '(A, A)') "Error: Duplicate card detected - ", trim(card_str)
                stop
            end if
            seen_cards(card_index(card_str)) = .true.
            rank = card_str(1:2)
            suit = card_str(3:3)
            call hand%add_card(Card(rank, suit))
            pos = pos + 4 ! Move to next card (assuming space-separated)
        end do
    end subroutine parse_hand

    integer function card_index(card_str)
        character(len=*), intent(in) :: card_str
        ! Simple mapping of card string to index (1-52), assumes unique encoding
        ! This is a placeholder; adjust based on your Card module's logic
        card_index = iachar(card_str(1:1)) + iachar(card_str(2:2)) + iachar(card_str(3:3))
    end function card_index

    subroutine sort_hands(hands)
        type(Hand), intent(inout) :: hands(MAX_HANDS)
        type(PokerHandRank) :: rank
        integer :: i, j
        type(Hand) :: temp
        
        do i = 1, MAX_HANDS - 1
            do j = i + 1, MAX_HANDS
                if (hands(i)%current_size > 0 .and. hands(j)%current_size > 0) then
                    rank = PokerHandRank(hands(i))
                    if (rank%evaluate_hand(hands(i)) > rank%evaluate_hand(hands(j))) then
                        temp = hands(i)
                        hands(i) = hands(j)
                        hands(j) = temp
                    end if
                end if
            end do
        end do
    end subroutine sort_hands

    subroutine formatting()
        write(*, '(A)') "*** P O K E R  H A N D  A N A L Y Z E R ***"
        write(*, *)
        write(*, '(A)') " *** USING RANDOMIZED DECK OF CARDS ***"
        write(*, *)
        write(*, *)
    end subroutine formatting

    subroutine formatting_for_file()
        write(*, '(A)') "*** P O K E R  H A N D  A N A L Y Z E R ***"
        write(*, *)
        write(*, '(A)') " *** USING TEST DECK ***"
        write(*, *)
        write(*, *)
    end subroutine formatting_for_file

end program poker_hand_analyzer