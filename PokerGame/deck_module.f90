module deck_module
    use card_module
    implicit none
    
    ! Define the deck type
    type :: Deck
        type(Card) :: cards(52)
        integer :: current_size
    contains
        procedure :: shuffle => deck_shuffle
        procedure :: deal_card => deck_deal_card
        procedure :: size => deck_size
        procedure :: is_empty => deck_is_empty
        procedure :: to_string => deck_to_string
    end type Deck
    
    interface Deck
        procedure deck_constructor
    end interface Deck

contains

    ! Constructor function
    function deck_constructor() result(new_deck)
        type(Deck) :: new_deck
        character(len=2) :: ranks(13) = ["A ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "10", "J ", "Q ", "K "]
        character :: suits(4) = ['C', 'D', 'H', 'S']
        integer :: i, j, pos
        
        new_deck%current_size = 52
        pos = 1
        do i = 1, 4
            do j = 1, 13
                new_deck%cards(pos) = Card(ranks(j), suits(i))
                pos = pos + 1
            end do
        end do
    end function deck_constructor

    ! Shuffle the deck using Fisher-Yates algorithm
    subroutine deck_shuffle(this)
        class(Deck), intent(inout) :: this
        integer :: i, j
        type(Card) :: temp
        real :: r
        
        do i = this%current_size, 2, -1
            call random_number(r)
            j = int(r * i) + 1
            temp = this%cards(j)
            this%cards(j) = this%cards(i)
            this%cards(i) = temp
        end do
    end subroutine deck_shuffle

    ! Deal a card
    function deck_deal_card(this) result(dealt_card)
        class(Deck), intent(inout) :: this
        type(Card) :: dealt_card
        
        if (this%current_size > 0) then
            dealt_card = this%cards(this%current_size)
            this%current_size = this%current_size - 1
        else
            ! In Fortran, we can't return null, so we'll return an invalid card
            dealt_card = Card(" ", ' ')
        end if
    end function deck_deal_card

    ! Get deck size
    integer function deck_size(this)
        class(Deck), intent(in) :: this
        deck_size = this%current_size
    end function deck_size

    ! Check if deck is empty
    logical function deck_is_empty(this)
        class(Deck), intent(in) :: this
        deck_is_empty = (this%current_size == 0)
    end function deck_is_empty

    ! Convert deck to string
    function deck_to_string(this) result(str)
        class(Deck), intent(in) :: this
        character(len=200) :: str
        character(len=3) :: card_str
        integer :: i, count
        
        str = ""
        count = 0
        do i = 1, this%current_size
            card_str = this%cards(i)%to_string()
            str = trim(str) // trim(card_str) // " "
            count = count + 1
            if (mod(count, 13) == 0) then
                str = trim(str) // char(10)
            end if
        end do
        str = trim(str)
    end function deck_to_string

end module deck_module