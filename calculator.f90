PROGRAM calculator
! by Bucky Badger
! This program calculates meteorological variables.
IMPLICIT NONE

! These are our original variables
REAL :: spd, dir, rh

! These are our computed variables
REAL :: uwind, vwind

! This is our constant
REAL, PARAMETER :: pi=3.14159

! This is our loop variable
INTEGER :: i

PRINT *, "Program is now starting."

OPEN(UNIT=10, FILE='data/obs.txt', ACTION='read', STATUS='old')
READ(10, *)  ! Skip the first line--column headers

DO i = 1, 1453
  READ(10, '(24X,F8.2,F8.0,F8.0)') rh, dir, spd
!  spd = spd * 1.151        ! this is mph
  CALL ktstomph(spd, spd)       ! this is mph

  dir = dir - 180.0        ! direction wind is going in degrees
  CALL deg2rad(dir, dir)
!  dir = dir * (pi / 180.0) ! direction wind is going in radians

  CALL decompose(spd, dir, uwind, vwind)
!  uwind = spd * SIN(dir)
!  vwind = spd * COS(dir)

  PRINT *, i, uwind, vwind, rh
END DO

CLOSE(UNIT=10)

PRINT '(T20,A)', "Program has finished."
PRINT *, "Go Bucky!"

END PROGRAM calculator

SUBROUTINE ktstomph(inspeed, outspeed)
! by Bucky Badger
! This subroutine converts a speed in knots to miles per hour.
IMPLICIT NONE

! This is our input and our output variable.
REAL :: inspeed, outspeed

outspeed = inspeed * 1.151

END SUBROUTINE ktstomph

SUBROUTINE deg2rad(degrees, radians)
! by Bucky Badger
! This subroutine converts a degree into radians.
IMPLICIT NONE

! This is our input and our output variable.
REAL :: degrees, radians
REAL, PARAMETER :: pi=3.14159

radians = degrees * (pi / 180.0)

END SUBROUTINE

SUBROUTINE decompose(speed, direction, uwind, vwind)
! by Bucky Badger
! This subroutine splits up a wind speed and direction (going towards)
!  into the zonal and meridional components. This is a simple vector
!  projection onto the x and y axes.
IMPLICIT NONE

! These are the input variables
REAL :: speed, direction

! These are the output variables
REAL :: uwind, vwind

uwind = speed * SIN(direction)
vwind = speed * COS(direction)

END SUBROUTINE decompose
