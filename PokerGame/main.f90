! main.f90
program PokerAnalyzer
  use card_module
  use deck_module
  use hand_module
  implicit none

  type(Deck) :: deck
  type(Hand) :: hands(6)
  integer :: i, j

  call deck%initialize()
  call deck%shuffle()

  print *, "*** Shuffled Deck: ***"
  print *, deck%to_string()

  do i = 1, 6
     do j = 1, 5
        call hands(i)%add_card(deck%deal_card())
     end do
  end do

  print *, "*** Hands Dealt: ***"
  do i = 1, 6
     print *, trim(hands(i)%to_string())
  end do

  print *, "*** Remaining Deck: ***"
  print *, deck%to_string()
end program PokerAnalyzer
