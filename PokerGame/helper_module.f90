subroutine print_hand(hand)
    use hand_module
    use card_module
    implicit none
    type(Hand), intent(in) :: hand
    integer :: i
    character(len=3) :: card_str
    character(len=50) :: output

    output = ""
    do i = 1, hand%current_size
        card_str = hand%cards(i)%to_string()
        output = trim(output) // trim(card_str) // " "
    end do
    print *, trim(output)
end subroutine print_hand

subroutine print_deck(deck)
    use deck_module
    use card_module
    implicit none
    type(Deck), intent(in) :: deck
    integer :: i
    character(len=3) :: card_str
    character(len=200) :: line
    integer :: count

    count = 0
    line = ""
    do i = 1, deck%current_size
        card_str = deck%cards(i)%to_string()
        line = trim(line) // trim(card_str) // " "
        count = count + 1
        if (mod(count, 13) == 0) then
            print *, trim(line)
            line = ""
        end if
    end do
    if (len_trim(line) > 0) print *, trim(line)
end subroutine print_deck

subroutine sort_hands_by_rank(ranks, hands)
    use pokerhandrank_module
    use hand_module
    implicit none
    type(PokerHandRank), intent(inout) :: ranks(6)
    type(Hand), intent(inout) :: hands(6)
    integer :: i, j, min_idx
    type(PokerHandRank) :: temp_rank
    type(Hand) :: temp_hand

    do i = 1, 5
        min_idx = i
        do j = i+1, 6
            if (ranks(j)%get_rank_value() < ranks(min_idx)%get_rank_value()) then
                min_idx = j
            end if
        end do
        if (min_idx /= i) then
            temp_rank = ranks(i)
            ranks(i) = ranks(min_idx)
            ranks(min_idx) = temp_rank

            temp_hand = hands(i)
            hands(i) = hands(min_idx)
            hands(min_idx) = temp_hand
        end if
    end do
end subroutine sort_hands_by_rank
