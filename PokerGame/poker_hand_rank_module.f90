module pokerhandrank_module
    use hand_module
    implicit none
    
    ! Define the poker hand rank type
    type :: PokerHandRank  ! Changed from Poker_Hand_Rank
        integer :: rank_value
        type(Card) :: sorted_cards(5)
    contains
        procedure :: get_rank_value => pokerhand_get_rank_value
        procedure :: evaluate_hand => pokerhand_evaluate_hand
        procedure :: get_rank_name => pokerhand_get_rank_name
        procedure :: to_string => pokerhand_to_string
        procedure, private :: is_royal_flush => pokerhand_is_royal_flush
        procedure, private :: is_straight_flush => pokerhand_is_straight_flush
        procedure, private :: is_flush => pokerhand_is_flush
        procedure, private :: is_straight => pokerhand_is_straight
        procedure, private :: get_value_counts => pokerhand_get_value_counts
        procedure, private :: is_four_of_a_kind => pokerhand_is_four_of_a_kind
        procedure, private :: is_full_house => pokerhand_is_full_house
        procedure, private :: is_three_of_a_kind => pokerhand_is_three_of_a_kind
        procedure, private :: is_two_pair => pokerhand_is_two_pair
        procedure, private :: is_pair => pokerhand_is_pair
    end type PokerHandRank
    
    interface PokerHandRank
        procedure pokerhand_constructor
    end interface PokerHandRank

contains

    function pokerhand_constructor(new_hand) result(new_rank)
        type(Hand), intent(in) :: new_hand  ! Keep intent(in) to preserve immutability
        type(PokerHandRank) :: new_rank     ! Changed from Poker_Hand_Rank
        integer :: i, j, min_idx
        type(Card) :: temp
        
        ! Assign the cards from hand to the new rank object
        new_rank%sorted_cards = new_hand%get_cards()
        ! Sort new_rank%sorted_cards directly (manual sort for simplicity)
        do i = 1, 4  ! Sort only 4 iterations since it's a 5-element array
            min_idx = i
            do j = i + 1, 5
                if (new_rank%sorted_cards(j)%get_value() < new_rank%sorted_cards(min_idx)%get_value() .or. &
                    (new_rank%sorted_cards(j)%get_value() == new_rank%sorted_cards(min_idx)%get_value() .and. &
                     new_rank%sorted_cards(j)%get_suit_rank() < new_rank%sorted_cards(min_idx)%get_suit_rank())) then
                    min_idx = j
                end if
            end do
            if (min_idx /= i) then
                temp = new_rank%sorted_cards(i)
                new_rank%sorted_cards(i) = new_rank%sorted_cards(min_idx)
                new_rank%sorted_cards(min_idx) = temp
            end if
        end do
        ! Evaluate the hand rank
        new_rank%rank_value = new_rank%evaluate_hand(new_hand)
    end function pokerhand_constructor

    ! Get rank value
    integer function pokerhand_get_rank_value(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        pokerhand_get_rank_value = this%rank_value
    end function pokerhand_get_rank_value

    ! Evaluate hand rank
    integer function pokerhand_evaluate_hand(this, new_hand)
        class(PokerHandRank), intent(inout) :: this  ! Changed from Poker_Hand_Rank
        type(Hand), intent(in) :: new_hand
        if (this%is_royal_flush()) then
            pokerhand_evaluate_hand = 1
        else if (this%is_straight_flush()) then
            pokerhand_evaluate_hand = 2
        else if (this%is_four_of_a_kind()) then
            pokerhand_evaluate_hand = 3
        else if (this%is_full_house()) then
            pokerhand_evaluate_hand = 4
        else if (this%is_flush()) then
            pokerhand_evaluate_hand = 5
        else if (this%is_straight()) then
            pokerhand_evaluate_hand = 6
        else if (this%is_three_of_a_kind()) then
            pokerhand_evaluate_hand = 7
        else if (this%is_two_pair()) then
            pokerhand_evaluate_hand = 8
        else if (this%is_pair()) then
            pokerhand_evaluate_hand = 9
        else
            pokerhand_evaluate_hand = 10
        end if
    end function pokerhand_evaluate_hand

    ! Get rank name
    function pokerhand_get_rank_name(this) result(rank_name)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        character(len=20) :: rank_name
        
        select case (this%rank_value)
            case (1)
                rank_name = "Royal Flush"
            case (2)
                rank_name = "Straight Flush"
            case (3)
                rank_name = "Four of a Kind"
            case (4)
                rank_name = "Full House"
            case (5)
                rank_name = "Flush"
            case (6)
                rank_name = "Straight"
            case (7)
                rank_name = "Three of a Kind"
            case (8)
                rank_name = "Two Pair"
            case (9)
                rank_name = "One Pair"
            case (10)
                rank_name = "High Card"
            case default
                rank_name = "Unknown Rank"
        end select
    end function pokerhand_get_rank_name

    ! Check for royal flush
    logical function pokerhand_is_royal_flush(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        pokerhand_is_royal_flush = this%is_straight_flush() .and. this%sorted_cards(1)%get_value() == 10
    end function pokerhand_is_royal_flush

    ! Check for straight flush
    logical function pokerhand_is_straight_flush(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        pokerhand_is_straight_flush = this%is_flush() .and. this%is_straight()
    end function pokerhand_is_straight_flush

    ! Check for flush
    logical function pokerhand_is_flush(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        integer :: i
        character :: suit
        
        suit = this%sorted_cards(1)%get_suit()
        pokerhand_is_flush = .true.
        do i = 2, 5
            if (this%sorted_cards(i)%get_suit() /= suit) then
                pokerhand_is_flush = .false.
                exit
            end if
        end do
    end function pokerhand_is_flush

    ! Check for straight
    logical function pokerhand_is_straight(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        integer :: i
        
        pokerhand_is_straight = .true.
        do i = 1, 4
            if (this%sorted_cards(i+1)%get_value() /= this%sorted_cards(i)%get_value() + 1) then
                pokerhand_is_straight = .false.
                exit
            end if
        end do
    end function pokerhand_is_straight

    ! Get value counts
    function pokerhand_get_value_counts(this) result(counts)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        integer :: counts(13) ! Assuming values 1-13 (A=1, K=13)
        integer :: i

        ! Explicitly initialize counts to zero
        counts = 0
        do i = 1, 5
            counts(this%sorted_cards(i)%get_value()) = counts(this%sorted_cards(i)%get_value()) + 1
        end do
    end function pokerhand_get_value_counts

    ! Check for four of a kind
    logical function pokerhand_is_four_of_a_kind(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        integer :: counts(13)
        
        counts = this%get_value_counts()
        pokerhand_is_four_of_a_kind = any(counts == 4)
    end function pokerhand_is_four_of_a_kind

    ! Check for full house
    logical function pokerhand_is_full_house(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        integer :: counts(13)
        
        counts = this%get_value_counts()
        pokerhand_is_full_house = any(counts == 3) .and. any(counts == 2)
    end function pokerhand_is_full_house

    ! Check for three of a kind
    logical function pokerhand_is_three_of_a_kind(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        integer :: counts(13)
        
        counts = this%get_value_counts()
        pokerhand_is_three_of_a_kind = any(counts == 3) .and. .not. this%is_full_house()
    end function pokerhand_is_three_of_a_kind

    ! Check for two pair
    logical function pokerhand_is_two_pair(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        integer :: counts(13)
        integer :: pair_count
        
        counts = this%get_value_counts()
        pair_count = count(counts == 2)
        pokerhand_is_two_pair = pair_count == 2
    end function pokerhand_is_two_pair

    ! Check for pair
    logical function pokerhand_is_pair(this)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        integer :: counts(13)
        
        counts = this%get_value_counts()
        pokerhand_is_pair = any(counts == 2) .and. .not. this%is_two_pair()
    end function pokerhand_is_pair

    ! Convert to string
    function pokerhand_to_string(this) result(str)
        class(PokerHandRank), intent(in) :: this  ! Changed from Poker_Hand_Rank
        character(len=100) :: str
        character(len=3) :: card_str
        integer :: i
        
        write(str, '(A,I0,A)') "Rank: ", this%rank_value, ", Cards: "
        do i = 1, 5
            card_str = this%sorted_cards(i)%to_string()
            str = trim(str) // trim(card_str) // " "
        end do
        str = trim(str)
    end function pokerhand_to_string

end module pokerhandrank_module