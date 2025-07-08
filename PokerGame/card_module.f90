! card_module.f90
module card_module
  implicit none

  type :: Card
     character(len=2) :: rank
     character(len=1) :: suit
  contains
     procedure :: to_string
     procedure :: get_value
     procedure :: get_suit_rank
  end type Card

contains

  function to_string(this) result(str)
    class(Card), intent(in) :: this
    character(len=3) :: str
    str = trim(this%rank) // this%suit
  end function

  function get_value(this) result(value)
    class(Card), intent(in) :: this
    integer :: value
    select case (trim(this%rank))
    case ("A"); value = 14
    case ("K"); value = 13
    case ("Q"); value = 12
    case ("J"); value = 11
    case default; read(this%rank, *) value
    end select
  end function

  function get_suit_rank(this) result(rank)
    class(Card), intent(in) :: this
    integer :: rank
    select case (this%suit)
    case ('C'); rank = 1
    case ('D'); rank = 2
    case ('H'); rank = 3
    case ('S'); rank = 4
    case default; rank = 0
    end select
  end function

end module card_module
