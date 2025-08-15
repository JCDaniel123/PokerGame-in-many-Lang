module file_reader_module
    implicit none
contains

    subroutine read_cards_from_file(filename, card_array)
        character(len=*), intent(in) :: filename
        character(len=3), allocatable, intent(out) :: card_array(:)
        character(len=200) :: line
        character(len=3), allocatable :: cards_in_line(:)
        integer :: i, ios

        ! Initialize empty deck
        allocate(card_array(0))

        open(unit=10, file=trim(filename), status="old", action="read", iostat=ios)
        if (ios /= 0) then
            print *, "*** ERROR - Could not open file: ", trim(filename), " ***"
            stop
        end if

        do
            read(10, '(A)', iostat=ios) line
            if (ios /= 0) exit

            ! Replace commas with spaces for easier splitting
            line = adjustl(line)
            line = replace_commas(line)

            ! Split the line into cards
            call split_cards(trim(line), cards_in_line)

            ! Add each card
            do i = 1, size(cards_in_line)
                if (len_trim(cards_in_line(i)) > 0) then
                    call add_card(card_array, trim(cards_in_line(i)))
                end if
            end do
        end do

        close(10)
    end subroutine read_cards_from_file

    function replace_commas(str) result(out)
        character(len=*), intent(in) :: str
        character(len=len(str)) :: out
        integer :: j
        out = str
        do j = 1, len(str)
            if (out(j:j) == ",") out(j:j) = " "
        end do
    end function replace_commas

    subroutine split_cards(str, parts)
        character(len=*), intent(in) :: str
        character(len=3), allocatable, intent(out) :: parts(:)
        integer :: i, start, len_str
        character(len=3) :: token

        len_str = len_trim(str)
        allocate(parts(0))
        start = 1

        do i = 1, len_str
            if (str(i:i) == " " .or. i == len_str) then
                if (i == len_str) i = i + 1 ! include last char
                token = adjustl(str(start:i-1))
                if (len_trim(token) > 0) then
                    parts = [parts, token]
                end if
                start = i + 1
            end if
        end do
    end subroutine split_cards

    subroutine add_card(card_array, new_card)
        character(len=3), allocatable, intent(inout) :: card_array(:)
        character(len=3), intent(in) :: new_card
        integer :: j
        do j = 1, size(card_array)
            if (trim(new_card) == trim(card_array(j))) then
                print *, "*** ERROR - DUPLICATED CARD FOUND IN DECK ***"
                print *, "*** DUPLICATE: ", trim(new_card), " ***"
                stop
            end if
        end do
        card_array = [card_array, new_card]
    end subroutine add_card

end module file_reader_module
