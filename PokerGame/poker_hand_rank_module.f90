module pokerhandrank_module
    use hand_module
    use card_module
    implicit none
    type :: PokerHandRank
        integer :: rank_value
        type(Hand) :: hand
    contains
        procedure :: evaluate_hand
        procedure :: get_rank_name
    end type PokerHandRank

contains

    integer function evaluate_hand(this)
        class(PokerHandRank), intent(inout) :: this
        call this%hand%sort_hand()
        if (is_royal_flush(this%hand)) then
            this%rank_value = 1
        else if (is_flush(this%hand)) then
            this%rank_value = 5
        else
            this%rank_value = 10
        end if
        evaluate_hand = this%rank_value
    end function evaluate_hand

    character(len=20) function get_rank_name(this)
        class(PokerHandRank), intent(in) :: this
        select case (this%rank_value)
        case (1)
            get_rank_name = "Royal Flush"
        case (5)
            get_rank_name = "Flush"
        case default
            get_rank_name = "High Card"
        end select
    end function get_rank_name

    logical function is_flush(hand)
        type(Hand), intent(in) :: hand
        integer :: i
        character :: suit
        suit = hand%cards(1)%suit
        do i = 2, size(hand%cards)
            if (hand%cards(i)%suit /= suit) then
                is_flush = .false.
                return
            end if
        end do
        is_flush = .true.
    end function is_flush

    logical function is_royal_flush(hand)
        type(Hand), intent(in) :: hand
        is_royal_flush = is_flush(hand) .and. hand%cards(1)%get_value() == 10
    end function is_royal_flush

end module pokerhandrank_module
