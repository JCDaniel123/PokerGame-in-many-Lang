! deck_module.f90
module deck_module
  use card_module
  implicit none

  type :: Deck
     type(Card), allocatable :: cards(:)
  contains
     procedure :: initialize
     procedure :: shuffle
     procedure :: deal_card
     procedure :: to_string
  end type Deck

contains

  subroutine initialize(this)
    class(Deck), intent(inout) :: this
    character(len=2), dimension(13) :: ranks = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    character(len=1), dimension(4) :: suits = ['C','D','H','S']
    integer :: i, j, index

    allocate(this%cards(52))
    index = 1
    do j = 1, 4
       do i = 1, 13
          this%cards(index)%rank = ranks(i)
          this%cards(index)%suit = suits(j)
          index = index + 1
       end do
    end do
  end subroutine

  subroutine shuffle(this)
    class(Deck), intent(inout) :: this
    integer :: i, j
    type(Card) :: temp
    real :: r

    call random_seed()
    do i = size(this%cards), 2, -1
       call random_number(r)
       j = 1 + int(r * i)
       temp = this%cards(i)
       this%cards(i) = this%cards(j)
       this%cards(j) = temp
    end do
  end subroutine

  function deal_card(this) result(card)
    class(Deck), intent(inout) :: this
    type(Card) :: card
    card = this%cards(1)
    this%cards = this%cards(2:)
  end function

  function to_string(this) result(str)
    class(Deck), intent(in) :: this
    character(len=300) :: str
    integer :: i
    str = ""
    do i = 1, size(this%cards)
       str = trim(str) // trim(this%cards(i)%to_string()) // " "
    end do
  end function

end module deck_module
