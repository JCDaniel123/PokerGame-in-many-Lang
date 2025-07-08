! hand_module.f90
module hand_module
  use card_module
  implicit none

  type :: Hand
     type(Card), allocatable :: cards(:)
  contains
     procedure :: add_card
     procedure :: to_string
  end type Hand

contains

  subroutine add_card(this, card)
    class(Hand), intent(inout) :: this
    type(Card), intent(in) :: card

    if (.not.allocated(this%cards)) then
       allocate(this%cards(1))
       this%cards(1) = card
    else
       this%cards = [this%cards, card]
    end if
  end subroutine

  function to_string(this) result(str)
    class(Hand), intent(in) :: this
    character(len=100) :: str
    integer :: i

    str = ""
    do i = 1, size(this%cards)
       str = trim(str) // trim(this%cards(i)%to_string()) // " "
    end do
  end function

end module hand_module
