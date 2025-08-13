module helper_module
    use hand_module
    use deck_module
    use pokerhandrank_module
    implicit none
contains


subroutine print_hand(h, newline)
    use hand_module
    type(Hand), intent(in) :: h
    logical, intent(in), optional :: newline
    integer :: i
    character(len=3) :: card_str
    logical :: nl

    nl = .true.
    if (present(newline)) nl = newline

    if (h%current_size == 0) then
        write(*,'(A)') "(empty hand)"
        return
    end if

    do i = 1, h%current_size
        card_str = trim(h%cards(i)%to_string())
        write(*,'(A)', advance='no') card_str // ' '
    end do
    if (nl) write(*,*)
end subroutine print_hand



subroutine print_deck(d)
    type(Deck), intent(in) :: d
    integer :: i, count
    character(len=:), allocatable :: card_str

    count = 0
    do i = 1, d%current_size
        card_str = trim(d%cards(i)%to_string())
        write(*,'(A)', advance='no') trim(card_str) // ' '
        count = count + 1
        if (mod(count, 13) == 0) then
            print *  ! move to next line after 13 cards
        end if
    end do
    if (mod(count, 13) /= 0) then
        print *  ! final newline if last row isn't full
    end if
end subroutine print_deck


subroutine sort_hands_by_rank(ranks, hands)

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

end module helper_module

