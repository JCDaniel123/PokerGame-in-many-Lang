module card_module
    implicit none
    
    ! Define the card type
    type :: Card
        character(len=2) :: rank
        character :: suit
    contains
        procedure :: get_value => card_get_value
        procedure :: get_suit_rank => card_get_suit_rank
        procedure :: to_string => card_to_string
        procedure :: get_suit => card_get_suit
        procedure :: get_rank => card_get_rank
    end type Card
    
    interface Card
        procedure card_constructor
    end interface Card

contains

    ! Constructor function
    function card_constructor(r, s) result(new_card)
        character(len=*), intent(in) :: r
        character, intent(in) :: s
        type(Card) :: new_card
        
        new_card%rank = r
        new_card%suit = s
    end function card_constructor

    ! Get card value
    integer function card_get_value(this)
        class(Card), intent(in) :: this
        
        select case (trim(this%rank))
            case ("A")
                card_get_value = 1
            case ("2")
                card_get_value = 2
            case ("3")
                card_get_value = 3
            case ("4")
                card_get_value = 4
            case ("5")
                card_get_value = 5
            case ("6")
                card_get_value = 6
            case ("7")
                card_get_value = 7
            case ("8")
                card_get_value = 8
            case ("9")
                card_get_value = 9
            case ("10")
                card_get_value = 10
            case ("J")
                card_get_value = 11
            case ("Q")
                card_get_value = 12
            case ("K")
                card_get_value = 13
            case default
                card_get_value = 0
        end select
    end function card_get_value

    ! Get suit rank
    integer function card_get_suit_rank(this)
        class(Card), intent(in) :: this
        
        select case (this%suit)
            case ('C')
                card_get_suit_rank = 1  ! Clubs
            case ('D')
                card_get_suit_rank = 2  ! Diamonds
            case ('H')
                card_get_suit_rank = 3  ! Hearts
            case ('S')
                card_get_suit_rank = 4  ! Spades
            case default
                card_get_suit_rank = 0
        end select
    end function card_get_suit_rank

    ! To string method
    function card_to_string(this) result(str)
        class(Card), intent(in) :: this
        character(len=3) :: str
        
        str = trim(this%rank) // this%suit
    end function card_to_string

    ! Get suit
    character function card_get_suit(this)
        class(Card), intent(in) :: this
        card_get_suit = this%suit
    end function card_get_suit

    ! Get rank
    function card_get_rank(this) result(rank)
        class(Card), intent(in) :: this
        character(len=2) :: rank
        rank = this%rank
    end function card_get_rank

    function card_from_string(str) result(c)
    implicit none
    character(len=*), intent(in) :: str
    type(Card) :: c
    character(len=2) :: rank
    character(len=1) :: suit

    ! Handle 10 specially since it's two characters
    if (len_trim(str) == 3) then
        rank = str(1:2)
        suit = str(3:3)
    else
        rank = str(1:1)
        suit = str(2:2)
    end if

    ! Assuming you already have a Card constructor:
    c = card_constructor(rank, suit)
end function card_from_string



end module card_module