module hand_module
    use card_module
    implicit none
    
    ! Define the hand type
    type :: Hand
        type(Card) :: cards(5)
        integer :: current_size = 0
    contains
        procedure :: add_card => hand_add_card
        procedure :: get_cards => hand_get_cards
        procedure :: is_full => hand_is_full
        procedure :: sort => hand_sort
        procedure :: to_string => hand_to_string
    end type Hand
    
    interface Hand
        procedure hand_constructor
    end interface Hand

contains

    ! Constructor function
    function hand_constructor() result(new_hand)
        type(Hand) :: new_hand
        new_hand%current_size = 0
    end function hand_constructor

    ! Add a card to the hand
    subroutine hand_add_card(this, new_card)
        class(Hand), intent(inout) :: this
        type(Card), intent(in) :: new_card
        
        if (this%current_size < 5) then
            this%current_size = this%current_size + 1
            this%cards(this%current_size) = new_card
        else
            write(*, '(A)') 'Error: A hand can only have 5 cards'
            stop 1
        end if
    end subroutine hand_add_card

    ! Get the cards in the hand
    function hand_get_cards(this) result(cards_array)
        class(Hand), intent(in) :: this
        type(Card) :: cards_array(5)
        integer :: i
        
        do i = 1, this%current_size
            cards_array(i) = this%cards(i)
        end do
        ! Fill remaining slots with invalid cards
        do i = this%current_size + 1, 5
            cards_array(i) = Card(" ", ' ')
        end do
    end function hand_get_cards

    ! Check if hand is full
    logical function hand_is_full(this)
        class(Hand), intent(in) :: this
        hand_is_full = (this%current_size == 5)
    end function hand_is_full

    ! Sort the cards by value and then suit rank
    subroutine hand_sort(this)
        class(Hand), intent(inout) :: this
        integer :: i, j, min_idx
        type(Card) :: temp
        
        do i = 1, this%current_size - 1
            min_idx = i
            do j = i + 1, this%current_size
                if (this%cards(j)%get_value() < this%cards(min_idx)%get_value() .or. &
                    (this%cards(j)%get_value() == this%cards(min_idx)%get_value() .and. &
                     this%cards(j)%get_suit_rank() < this%cards(min_idx)%get_suit_rank())) then
                    min_idx = j
                end if
            end do
            if (min_idx /= i) then
                temp = this%cards(i)
                this%cards(i) = this%cards(min_idx)
                this%cards(min_idx) = temp
            end if
        end do
    end subroutine hand_sort

    ! Convert hand to string
    function hand_to_string(this) result(str)
        class(Hand), intent(in) :: this
        character(len=50) :: str
        character(len=3) :: card_str
        integer :: i
        
        str = ""
        do i = 1, this%current_size
            card_str = this%cards(i)%to_string()
            str = trim(str) // trim(card_str) // " "
        end do
        str = trim(str)
    end function hand_to_string

end module hand_module