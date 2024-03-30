module sieve
  implicit none

contains

  function primes(limit) result(array)
    integer, intent(in) :: limit
    integer, allocatable :: array(:)

    logical, dimension(limit - 1) :: candidates

    integer :: i,j

    allocate(array(0))

    do i = 2, limit
      candidates(i) = .true.
    end do

    do i = 2, limit
      if (candidates(i)) then
        array = [array, i]

        j = 2 * i
        do while (j <= limit)
          candidates(j) = .false.
          j = j + i
        end do
      end if
    end do
  end function primes

end module sieve
