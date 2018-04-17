CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C                                                                                C
C                  Extract data from VULCAN   to MTEX software                   C
C                                                                                C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C                      Linear interpolation of the data                          C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
	program xqg            ! start of program
      implicit none         ! mean we need to declare all the variables
	character(len=160) str    ! size of the "str" variable
	integer i, j, k, ilow, iup
	real*8 a111(12,19), a200(12,19), a220(12,19), a311(12,19),   ! 8bytes size arrays (12 by 19)
     # a222(12,19),
     #t1,t2,t3,t4,t5,t6, t7, qq, qno, tmp1, tmp2,
     # y1, y2, y3, y4, y5, y6, y7, y8
C
	open(unit=46, file='VULCAN.rpf',status='unknown',action='write')
	open(unit=45, file='ducu.txt',status='old',action='read')
C   read the data
      read(45,*)
	do i=1, 99999, 1
      read(45, *, end=333) t2, t1, t3, t4, t5, t7, t6 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  t2 t1 interchanged
C    t6 and t7 interchanged, so to output 311 pole figure
C
C   t2: from 0 to 90  |||  t1: from 0 to 360
c
      if(t1.eq.0.0.and. t2.eq.0.0) then     
	do j=1, 12, 1
	a111(j,1)=t3
        a200(j,1)=t4
	a220(j,1)=t5
	a311(j,1)=t6
	a222(j,1)=t7
	enddo
      goto 666
	endif
cccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.5.0) then     
	a111(1,2)=t3
        a200(1,2)=t4
	a220(1,2)=t5
	a311(1,2)=t6
	a222(1,2)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.5.0) then     
	a111(2,2)=t3
        a200(2,2)=t4
	a220(2,2)=t5
	a311(2,2)=t6
	a222(2,2)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.5.0) then     
	a111(3,2)=t3
      a200(3,2)=t4
	a220(3,2)=t5
	a311(3,2)=t6
	a222(3,2)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.5.0) then     
	a111(4,2)=t3
      a200(4,2)=t4
	a220(4,2)=t5
	a311(4,2)=t6
	a222(4,2)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.5.0) then     
	a111(5,2)=t3
      a200(5,2)=t4
	a220(5,2)=t5
	a311(5,2)=t6
	a222(5,2)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.5.0) then     
	a111(6,2)=t3
      a200(6,2)=t4
	a220(6,2)=t5
	a311(6,2)=t6
	a222(6,2)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.5.0) then     
	a111(7,2)=t3
      a200(7,2)=t4
	a220(7,2)=t5
	a311(7,2)=t6
	a222(7,2)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.5.0) then     
	a111(8,2)=t3
      a200(8,2)=t4
	a220(8,2)=t5
	a311(8,2)=t6
	a222(8,2)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.5.0) then     
	a111(9,2)=t3
      a200(9,2)=t4
	a220(9,2)=t5
	a311(9,2)=t6
	a222(9,2)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.5.0) then     
	a111(10,2)=t3
      a200(10,2)=t4
	a220(10,2)=t5
	a311(10,2)=t6
	a222(10,2)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.5.0) then     
	a111(11,2)=t3
      a200(11,2)=t4
	a220(11,2)=t5
	a311(11,2)=t6
	a222(11,2)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.5.0) then     
	a111(12,2)=t3
      a200(12,2)=t4
	a220(12,2)=t5
	a311(12,2)=t6
	a222(12,2)=t7
	goto 666
	endif
cccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.10.0) then     
	a111(1,3)=t3
      a200(1,3)=t4
	a220(1,3)=t5
	a311(1,3)=t6
	a222(1,3)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.10.0) then     
	a111(2,3)=t3
      a200(2,3)=t4
	a220(2,3)=t5
	a311(2,3)=t6
	a222(2,3)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.10.0) then     
	a111(3,3)=t3
      a200(3,3)=t4
	a220(3,3)=t5
	a311(3,3)=t6
	a222(3,3)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.10.0) then     
	a111(4,3)=t3
      a200(4,3)=t4
	a220(4,3)=t5
	a311(4,3)=t6
	a222(4,3)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.10.0) then     
	a111(5,3)=t3
      a200(5,3)=t4
	a220(5,3)=t5
	a311(5,3)=t6
	a222(5,3)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.10.0) then     
	a111(6,3)=t3
      a200(6,3)=t4
	a220(6,3)=t5
	a311(6,3)=t6
	a222(6,3)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.10.0) then     
	a111(7,3)=t3
      a200(7,3)=t4
	a220(7,3)=t5
	a311(7,3)=t6
	a222(7,3)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.10.0) then     
	a111(8,3)=t3
      a200(8,3)=t4
	a220(8,3)=t5
	a311(8,3)=t6
	a222(8,3)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.10.0) then     
	a111(9,3)=t3
      a200(9,3)=t4
	a220(9,3)=t5
	a311(9,3)=t6
	a222(9,3)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.10.0) then     
	a111(10,3)=t3
      a200(10,3)=t4
	a220(10,3)=t5
	a311(10,3)=t6
	a222(10,3)=t3
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.10.0) then     
	a111(11,3)=t3
      a200(11,3)=t4
	a220(11,3)=t5
	a311(11,3)=t6
	a222(11,3)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.10.0) then     
	a111(12,3)=t3
      a200(12,3)=t4
	a220(12,3)=t5
	a311(12,3)=t6
	a222(12,3)=t7
	goto 666
	endif
cccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.15.0) then     
	a111(1,4)=t3
      a200(1,4)=t4
	a220(1,4)=t5
	a311(1,4)=t6
	a222(1,4)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.15.0) then     
	a111(2,4)=t3
      a200(2,4)=t4
	a220(2,4)=t5
	a311(2,4)=t6
	a222(2,4)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.15.0) then     
	a111(3,4)=t3
      a200(3,4)=t4
	a220(3,4)=t5
	a311(3,4)=t6
	a222(3,4)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.15.0) then     
	a111(4,4)=t3
      a200(4,4)=t4
	a220(4,4)=t5
	a311(4,4)=t6
	a222(4,4)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.15.0) then     
	a111(5,4)=t3
      a200(5,4)=t4
	a220(5,4)=t5
	a311(5,4)=t6
	a222(5,4)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.15.0) then     
	a111(6,4)=t3
      a200(6,4)=t4
	a220(6,4)=t5
	a311(6,4)=t6
	a222(6,4)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.15.0) then     
	a111(7,4)=t3
      a200(7,4)=t4
	a220(7,4)=t5
	a311(7,4)=t6
	a222(7,4)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.15.0) then     
	a111(8,4)=t3
      a200(8,4)=t4
	a220(8,4)=t5
	a311(8,4)=t6
	a222(8,4)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.15.0) then     
	a111(9,4)=t3
      a200(9,4)=t4
	a220(9,4)=t5
	a311(9,4)=t6
	a222(9,4)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.15.0) then     
	a111(10,4)=t3
      a200(10,4)=t4
	a220(10,4)=t5
	a311(10,4)=t6
	a222(10,4)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.15.0) then     
	a111(11,4)=t3
      a200(11,4)=t4
	a220(11,4)=t5
	a311(11,4)=t6
	a222(11,4)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.15.0) then     
	a111(12,4)=t3
      a200(12,4)=t4
	a220(12,4)=t5
	a311(12,4)=t6
	a222(12,4)=t7
	goto 666
	endif
ccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.20.0) then     
	a111(1,5)=t3
      a200(1,5)=t4
	a220(1,5)=t5
	a311(1,5)=t6
	a222(1,5)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.20.0) then     
	a111(2,5)=t3
      a200(2,5)=t4
	a220(2,5)=t5
	a311(2,5)=t6
	a222(2,5)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.20.0) then     
	a111(3,5)=t3
      a200(3,5)=t4
	a220(3,5)=t5
	a311(3,5)=t6
	a222(3,5)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.20.0) then     
	a111(4,5)=t3
      a200(4,5)=t4
	a220(4,5)=t5
	a311(4,5)=t6
	a222(4,5)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.20.0) then     
	a111(5,5)=t3
      a200(5,5)=t4
	a220(5,5)=t5
	a311(5,5)=t6
	a222(5,5)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.20.0) then     
	a111(6,5)=t3
      a200(6,5)=t4
	a220(6,5)=t5
	a311(6,5)=t6
	a222(6,5)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.20.0) then     
	a111(7,5)=t3
      a200(7,5)=t4
	a220(7,5)=t5
	a311(7,5)=t6
	a222(7,5)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.20.0) then     
	a111(8,5)=t3
      a200(8,5)=t4
	a220(8,5)=t5
	a311(8,5)=t6
	a222(8,5)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.20.0) then     
	a111(9,5)=t3
      a200(9,5)=t4
	a220(9,5)=t5
	a311(9,5)=t6
	a222(9,5)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.20.0) then     
	a111(10,5)=t3
      a200(10,5)=t4
	a220(10,5)=t5
	a311(10,5)=t6
	a222(10,5)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.20.0) then     
	a111(11,5)=t3
      a200(11,5)=t4
	a220(11,5)=t5
	a311(11,5)=t6
	a222(11,5)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.20.0) then     
	a111(12,5)=t3
      a200(12,5)=t4
	a220(12,5)=t5
	a311(12,5)=t6
	a222(12,5)=t7
	goto 666
	endif
cccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.25.0) then     
	a111(1,6)=t3
      a200(1,6)=t4
	a220(1,6)=t5
	a311(1,6)=t6
	a222(1,6)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.25.0) then     
	a111(2,6)=t3
      a200(2,6)=t4
	a220(2,6)=t5
	a311(2,6)=t6
	a222(2,6)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.25.0) then     
	a111(3,6)=t3
      a200(3,6)=t4
	a220(3,6)=t5
	a311(3,6)=t6
	a222(3,6)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.25.0) then     
	a111(4,6)=t3
      a200(4,6)=t4
	a220(4,6)=t5
	a311(4,6)=t6
	a222(4,6)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.25.0) then     
	a111(5,6)=t3
      a200(5,6)=t4
	a220(5,6)=t5
	a311(5,6)=t6
	a222(5,6)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.25.0) then     
	a111(6,6)=t3
      a200(6,6)=t4
	a220(6,6)=t5
	a311(6,6)=t6
	a222(6,6)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.25.0) then     
	a111(7,6)=t3
      a200(7,6)=t4
	a220(7,6)=t5
	a311(7,6)=t6
	a222(7,6)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.25.0) then     
	a111(8,6)=t3
      a200(8,6)=t4
	a220(8,6)=t5
	a311(8,6)=t6
	a222(8,6)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.25.0) then     
	a111(9,6)=t3
      a200(9,6)=t4
	a220(9,6)=t5
	a311(9,6)=t6
	a222(9,6)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.25.0) then     
	a111(10,6)=t3
      a200(10,6)=t4
	a220(10,6)=t5
	a311(10,6)=t6
	a222(10,6)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.25.0) then     
	a111(11,6)=t3
      a200(11,6)=t4
	a220(11,6)=t5
	a311(11,6)=t6
	a222(11,6)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.25.0) then     
	a111(12,6)=t3
      a200(12,6)=t4
	a220(12,6)=t5
	a311(12,6)=t6
	a222(12,6)=t7
	goto 666
	endif
cccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.30.0) then     
	a111(1,7)=t3
      a200(1,7)=t4
	a220(1,7)=t5
	a311(1,7)=t6
	a222(1,7)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.30.0) then     
	a111(2,7)=t3
      a200(2,7)=t4
	a220(2,7)=t5
	a311(2,7)=t6
	a222(2,7)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.30.0) then     
	a111(3,7)=t3
      a200(3,7)=t4
	a220(3,7)=t5
	a311(3,7)=t6
	a222(3,7)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.30.0) then     
	a111(4,7)=t3
      a200(4,7)=t4
	a220(4,7)=t5
	a311(4,7)=t6
	a222(4,7)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.30.0) then     
	a111(5,7)=t3
      a200(5,7)=t4
	a220(5,7)=t5
	a311(5,7)=t6
	a222(5,7)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.30.0) then     
	a111(6,7)=t3
      a200(6,7)=t4
	a220(6,7)=t5
	a311(6,7)=t6
	a222(6,7)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.30.0) then     
	a111(7,7)=t3
      a200(7,7)=t4
	a220(7,7)=t5
	a311(7,7)=t6
	a222(7,7)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.30.0) then     
	a111(8,7)=t3
      a200(8,7)=t4
	a220(8,7)=t5
	a311(8,7)=t6
	a222(8,7)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.30.0) then     
	a111(9,7)=t3
      a200(9,7)=t4
	a220(9,7)=t5
	a311(9,7)=t6
	a222(9,7)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.30.0) then     
	a111(10,7)=t3
      a200(10,7)=t4
	a220(10,7)=t5
	a311(10,7)=t6
	a222(10,7)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.30.0) then     
	a111(11,7)=t3
      a200(11,7)=t4
	a220(11,7)=t5
	a311(11,7)=t6
	a222(11,7)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.30.0) then     
	a111(12,7)=t3
      a200(12,7)=t4
	a220(12,7)=t5
	a311(12,7)=t6
	a222(12,7)=t7
	goto 666
	endif
ccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.35.0) then     
	a111(1,8)=t3
      a200(1,8)=t4
	a220(1,8)=t5
	a311(1,8)=t6
	a222(1,8)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.35.0) then     
	a111(2,8)=t3
      a200(2,8)=t4
	a220(2,8)=t5
	a311(2,8)=t6
	a222(2,8)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.35.0) then     
	a111(3,8)=t3
      a200(3,8)=t4
	a220(3,8)=t5
	a311(3,8)=t6
	a222(3,8)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.35.0) then     
	a111(4,8)=t3
      a200(4,8)=t4
	a220(4,8)=t5
	a311(4,8)=t6
	a222(4,8)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.35.0) then     
	a111(5,8)=t3
      a200(5,8)=t4
	a220(5,8)=t5
	a311(5,8)=t6
	a222(5,8)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.35.0) then     
	a111(6,8)=t3
      a200(6,8)=t4
	a220(6,8)=t5
	a311(6,8)=t6
	a222(6,8)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.35.0) then     
	a111(7,8)=t3
      a200(7,8)=t4
	a220(7,8)=t5
	a311(7,8)=t6
	a222(7,8)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.35.0) then     
	a111(8,8)=t3
      a200(8,8)=t4
	a220(8,8)=t5
	a311(8,8)=t6
	a222(8,8)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.35.0) then     
	a111(9,8)=t3
      a200(9,8)=t4
	a220(9,8)=t5
	a311(9,8)=t6
	a222(9,8)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.35.0) then     
	a111(10,8)=t3
      a200(10,8)=t4
	a220(10,8)=t5
	a311(10,8)=t6
	a222(10,8)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.35.0) then     
	a111(11,8)=t3
      a200(11,8)=t4
	a220(11,8)=t5
	a311(11,8)=t6
	a222(11,8)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.35.0) then     
	a111(12,8)=t3
      a200(12,8)=t4
	a220(12,8)=t5
	a311(12,8)=t6
	a222(12,8)=t7
	goto 666
	endif
cccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.40.0) then     
	a111(1,9)=t3
      a200(1,9)=t4
	a220(1,9)=t5
	a311(1,9)=t6
	a222(1,9)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.40.0) then     
	a111(2,9)=t3
      a200(2,9)=t4
	a220(2,9)=t5
	a311(2,9)=t6
	a222(2,9)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.40.0) then     
	a111(3,9)=t3
      a200(3,9)=t4
	a220(3,9)=t5
	a311(3,9)=t6
	a222(3,9)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.40.0) then     
	a111(4,9)=t3
      a200(4,9)=t4
	a220(4,9)=t5
	a311(4,9)=t6
	a222(4,9)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.40.0) then     
	a111(5,9)=t3
      a200(5,9)=t4
	a220(5,9)=t5
	a311(5,9)=t6
	a222(5,9)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.40.0) then     
	a111(6,9)=t3
      a200(6,9)=t4
	a220(6,9)=t5
	a311(6,9)=t6
	a222(6,9)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.40.0) then     
	a111(7,9)=t3
      a200(7,9)=t4
	a220(7,9)=t5
	a311(7,9)=t6
	a222(7,9)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.40.0) then     
	a111(8,9)=t3
      a200(8,9)=t4
	a220(8,9)=t5
	a311(8,9)=t6
	a222(8,9)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.40.0) then     
	a111(9,9)=t3
      a200(9,9)=t4
	a220(9,9)=t5
	a311(9,9)=t6
	a222(9,9)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.40.0) then     
	a111(10,9)=t3
      a200(10,9)=t4
	a220(10,9)=t5
	a311(10,9)=t6
	a222(10,9)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.40.0) then     
	a111(11,9)=t3
      a200(11,9)=t4
	a220(11,9)=t5
	a311(11,9)=t6
	a222(11,9)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.40.0) then     
	a111(12,9)=t3
      a200(12,9)=t4
	a220(12,9)=t5
	a311(12,9)=t6
	a222(12,9)=t7
	goto 666
	endif
ccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.45.0) then     
	a111(1,10)=t3
      a200(1,10)=t4
	a220(1,10)=t5
	a311(1,10)=t6
	a222(1,10)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.45.0) then     
	a111(2,10)=t3
      a200(2,10)=t4
	a220(2,10)=t5
	a311(2,10)=t6
	a222(2,10)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.45.0) then     
	a111(3,10)=t3
      a200(3,10)=t4
	a220(3,10)=t5
	a311(3,10)=t6
	a222(3,10)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.45.0) then     
	a111(4,10)=t3
      a200(4,10)=t4
	a220(4,10)=t5
	a311(4,10)=t6
	a222(4,10)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.45.0) then     
	a111(5,10)=t3
      a200(5,10)=t4
	a220(5,10)=t5
	a311(5,10)=t6
	a222(5,10)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.45.0) then     
	a111(6,10)=t3
      a200(6,10)=t4
	a220(6,10)=t5
	a311(6,10)=t6
	a222(6,10)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.45.0) then     
	a111(7,10)=t3
      a200(7,10)=t4
	a220(7,10)=t5
	a311(7,10)=t6
	a222(7,10)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.45.0) then     
	a111(8,10)=t3
      a200(8,10)=t4
	a220(8,10)=t5
	a311(8,10)=t6
	a222(8,10)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.45.0) then     
	a111(9,10)=t3
      a200(9,10)=t4
	a220(9,10)=t5
	a311(9,10)=t6
	a222(9,10)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.45.0) then     
	a111(10,10)=t3
      a200(10,10)=t4
	a220(10,10)=t5
	a311(10,10)=t6
	a222(10,10)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.45.0) then     
	a111(11,10)=t3
      a200(11,10)=t4
	a220(11,10)=t5
	a311(11,10)=t6
	a222(11,10)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.45.0) then     
	a111(12,10)=t3
      a200(12,10)=t4
	a220(12,10)=t5
	a311(12,10)=t6
	a222(12,10)=t7
	goto 666
	endif
ccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.50.0) then     
	a111(1,11)=t3
      a200(1,11)=t4
	a220(1,11)=t5
	a311(1,11)=t6
	a222(1,11)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.50.0) then     
	a111(2,11)=t3
      a200(2,11)=t4
	a220(2,11)=t5
	a311(2,11)=t6
	a222(2,11)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.50.0) then     
	a111(3,11)=t3
      a200(3,11)=t4
	a220(3,11)=t5
	a311(3,11)=t6
	a222(3,11)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.50.0) then     
	a111(4,11)=t3
      a200(4,11)=t4
	a220(4,11)=t5
	a311(4,11)=t6
	a222(4,11)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.50.0) then     
	a111(5,11)=t3
      a200(5,11)=t4
	a220(5,11)=t5
	a311(5,11)=t6
	a222(5,11)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.50.0) then     
	a111(6,11)=t3
      a200(6,11)=t4
	a220(6,11)=t5
	a311(6,11)=t6
	a222(6,11)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.50.0) then     
	a111(7,11)=t3
      a200(7,11)=t4
	a220(7,11)=t5
	a311(7,11)=t6
	a222(7,11)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.50.0) then     
	a111(8,11)=t3
      a200(8,11)=t4
	a220(8,11)=t5
	a311(8,11)=t6
	a222(8,11)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.50.0) then     
	a111(9,11)=t3
      a200(9,11)=t4
	a220(9,11)=t5
	a311(9,11)=t6
	a222(9,11)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.50.0) then     
	a111(10,11)=t3
      a200(10,11)=t4
	a220(10,11)=t5
	a311(10,11)=t6
	a222(10,11)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.50.0) then     
	a111(11,11)=t3
      a200(11,11)=t4
	a220(11,11)=t5
	a311(11,11)=t6
	a222(11,11)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.50.0) then     
	a111(12,11)=t3
      a200(12,11)=t4
	a220(12,11)=t5
	a311(12,11)=t6
	a222(12,11)=t7
	goto 666
	endif
ccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.55.0) then     
	a111(1,12)=t3
      a200(1,12)=t4
	a220(1,12)=t5
	a311(1,12)=t6
	a222(1,12)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.55.0) then     
	a111(2,12)=t3
      a200(2,12)=t4
	a220(2,12)=t5
	a311(2,12)=t6
	a222(2,12)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.55.0) then     
	a111(3,12)=t3
      a200(3,12)=t4
	a220(3,12)=t5
	a311(3,12)=t6
	a222(3,12)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.55.0) then     
	a111(4,12)=t3
      a200(4,12)=t4
	a220(4,12)=t5
	a311(4,12)=t6
	a222(4,12)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.55.0) then     
	a111(5,12)=t3
      a200(5,12)=t4
	a220(5,12)=t5
	a311(5,12)=t6
	a222(5,12)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.55.0) then     
	a111(6,12)=t3
      a200(6,12)=t4
	a220(6,12)=t5
	a311(6,12)=t6
	a222(6,12)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.55.0) then     
	a111(7,12)=t3
      a200(7,12)=t4
	a220(7,12)=t5
	a311(7,12)=t6
	a222(7,12)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.55.0) then     
	a111(8,12)=t3
      a200(8,12)=t4
	a220(8,12)=t5
	a311(8,12)=t6
	a222(8,12)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.55.0) then     
	a111(9,12)=t3
      a200(9,12)=t4
	a220(9,12)=t5
	a311(9,12)=t6
	a222(9,12)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.55.0) then     
	a111(10,12)=t3
      a200(10,12)=t4
	a220(10,12)=t5
	a311(10,12)=t6
	a222(10,12)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.55.0) then     
	a111(11,12)=t3
      a200(11,12)=t4
	a220(11,12)=t5
	a311(11,12)=t6
	a222(11,12)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.55.0) then     
	a111(12,12)=t3
      a200(12,12)=t4
	a220(12,12)=t5
	a311(12,12)=t6
	a222(12,12)=t7
	goto 666
	endif
ccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.60.0) then     
	a111(1,13)=t3
      a200(1,13)=t4
	a220(1,13)=t5
	a311(1,13)=t6
	a222(1,13)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.60.0) then     
	a111(2,13)=t3
      a200(2,13)=t4
	a220(2,13)=t5
	a311(2,13)=t6
	a222(2,13)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.60.0) then     
	a111(3,13)=t3
      a200(3,13)=t4
	a220(3,13)=t5
	a311(3,13)=t6
	a222(3,13)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.60.0) then     
	a111(4,13)=t3
      a200(4,13)=t4
	a220(4,13)=t5
	a311(4,13)=t6
	a222(4,13)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.60.0) then     
	a111(5,13)=t3
      a200(5,13)=t4
	a220(5,13)=t5
	a311(5,13)=t6
	a222(5,13)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.60.0) then     
	a111(6,13)=t3
      a200(6,13)=t4
	a220(6,13)=t5
	a311(6,13)=t6
	a222(7,13)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.60.0) then     
	a111(7,13)=t3
      a200(7,13)=t4
	a220(7,13)=t5
	a311(7,13)=t6
	a222(7,13)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.60.0) then     
	a111(8,13)=t3
      a200(8,13)=t4
	a220(8,13)=t5
	a311(8,13)=t6
	a222(8,13)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.60.0) then     
	a111(9,13)=t3
      a200(9,13)=t4
	a220(9,13)=t5
	a311(9,13)=t6
	a222(9,13)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.60.0) then     
	a111(10,13)=t3
      a200(10,13)=t4
	a220(10,13)=t5
	a311(10,13)=t6
	a222(10,13)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.60.0) then     
	a111(11,13)=t3
      a200(11,13)=t4
	a220(11,13)=t5
	a311(11,13)=t6
	a222(11,13)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.60.0) then     
	a111(12,13)=t3
      a200(12,13)=t4
	a220(12,13)=t5
	a311(12,13)=t6
	a222(12,13)=t7
	goto 666
	endif
ccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.65.0) then     
	a111(1,14)=t3
      a200(1,14)=t4
	a220(1,14)=t5
	a311(1,14)=t6
	a222(1,14)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.65.0) then     
	a111(2,14)=t3
      a200(2,14)=t4
	a220(2,14)=t5
	a311(2,14)=t6
	a222(2,14)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.65.0) then     
	a111(3,14)=t3
      a200(3,14)=t4
	a220(3,14)=t5
	a311(3,14)=t6
	a222(3,14)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.65.0) then     
	a111(4,14)=t3
      a200(4,14)=t4
	a220(4,14)=t5
	a311(4,14)=t6
	a222(4,14)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.65.0) then     
	a111(5,14)=t3
      a200(5,14)=t4
	a220(5,14)=t5
	a311(5,14)=t6
	a222(5,14)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.65.0) then     
	a111(6,14)=t3
      a200(6,14)=t4
	a220(6,14)=t5
	a311(6,14)=t6
	a222(6,14)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.65.0) then     
	a111(7,14)=t3
      a200(7,14)=t4
	a220(7,14)=t5
	a311(7,14)=t6
	a222(7,14)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.65.0) then     
	a111(8,14)=t3
      a200(8,14)=t4
	a220(8,14)=t5
	a311(8,14)=t6
	a222(8,14)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.65.0) then     
	a111(9,14)=t3
      a200(9,14)=t4
	a220(9,14)=t5
	a311(9,14)=t6
	a222(9,14)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.65.0) then     
	a111(10,14)=t3
      a200(10,14)=t4
	a220(10,14)=t5
	a311(10,14)=t6
	a222(10,14)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.65.0) then     
	a111(11,14)=t3
      a200(11,14)=t4
	a220(11,14)=t5
	a311(11,14)=t6
	a222(11,14)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.65.0) then     
	a111(12,14)=t3
      a200(12,14)=t4
	a220(12,14)=t5
	a311(12,14)=t6
	a222(12,14)=t7
	goto 666
	endif
cccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.70.0) then     
	a111(1,15)=t3
      a200(1,15)=t4
	a220(1,15)=t5
	a311(1,15)=t6
	a222(1,15)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.70.0) then     
	a111(2,15)=t3
      a200(2,15)=t4
	a220(2,15)=t5
	a311(2,15)=t6
	a222(2,15)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.70.0) then     
	a111(3,15)=t3
      a200(3,15)=t4
	a220(3,15)=t5
	a311(3,15)=t6
	a222(3,15)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.70.0) then     
	a111(4,15)=t3
      a200(4,15)=t4
	a220(4,15)=t5
	a311(4,15)=t6
	a222(4,15)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.70.0) then     
	a111(5,15)=t3
      a200(5,15)=t4
	a220(5,15)=t5
	a311(5,15)=t6
	a222(5,15)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.70.0) then     
	a111(6,15)=t3
      a200(6,15)=t4
	a220(6,15)=t5
	a311(6,15)=t6
	a222(6,15)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.70.0) then     
	a111(7,15)=t3
      a200(7,15)=t4
	a220(7,15)=t5
	a311(7,15)=t6
	a222(7,15)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.70.0) then     
	a111(8,15)=t3
      a200(8,15)=t4
	a220(8,15)=t5
	a311(8,15)=t6
	a222(8,15)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.70.0) then     
	a111(9,15)=t3
      a200(9,15)=t4
	a220(9,15)=t5
	a311(9,15)=t6
	a222(9,15)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.70.0) then     
	a111(10,15)=t3
      a200(10,15)=t4
	a220(10,15)=t5
	a311(10,15)=t6
	a222(10,15)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.70.0) then     
	a111(11,15)=t3
      a200(11,15)=t4
	a220(11,15)=t5
	a311(11,15)=t6
	a222(11,15)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.70.0) then     
	a111(12,15)=t3
      a200(12,15)=t4
	a220(12,15)=t5
	a311(12,15)=t6
	a222(12,15)=t7
	goto 666
	endif
cccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.75.0) then     
	a111(1,16)=t3
      a200(1,16)=t4
	a220(1,16)=t5
	a311(1,16)=t6
	a222(1,16)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.75.0) then     
	a111(2,16)=t3
      a200(2,16)=t4
	a220(2,16)=t5
	a311(2,16)=t6
	a222(2,16)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.75.0) then     
	a111(3,16)=t3
      a200(3,16)=t4
	a220(3,16)=t5
	a311(3,16)=t6
	a222(3,16)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.75.0) then     
	a111(4,16)=t3
      a200(4,16)=t4
	a220(4,16)=t5
	a311(4,16)=t6
	a222(4,16)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.75.0) then     
	a111(5,16)=t3
      a200(5,16)=t4
	a220(5,16)=t5
	a311(5,16)=t6
	a222(5,16)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.75.0) then     
	a111(6,16)=t3
      a200(6,16)=t4
	a220(6,16)=t5
	a311(6,16)=t6
	a222(6,16)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.75.0) then     
	a111(7,16)=t3
      a200(7,16)=t4
	a220(7,16)=t5
	a311(7,16)=t6
	a222(7,16)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.75.0) then     
	a111(8,16)=t3
      a200(8,16)=t4
	a220(8,16)=t5
	a311(8,16)=t6
	a222(8,16)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.75.0) then     
	a111(9,16)=t3
      a200(9,16)=t4
	a220(9,16)=t5
	a311(9,16)=t6
	a222(9,16)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.75.0) then     
	a111(10,16)=t3
      a200(10,16)=t4
	a220(10,16)=t5
	a311(10,16)=t6
	a222(10,16)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.75.0) then     
	a111(11,16)=t3
      a200(11,16)=t4
	a220(11,16)=t5
	a311(11,16)=t6
	a222(11,16)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.75.0) then     
	a111(12,16)=t3
      a200(12,16)=t4
	a220(12,16)=t5
	a311(12,16)=t6
	a222(12,16)=t7
	goto 666
	endif
ccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.80.0) then     
	a111(1,17)=t3
      a200(1,17)=t4
	a220(1,17)=t5
	a311(1,17)=t6
	a222(1,17)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.80.0) then     
	a111(2,17)=t3
      a200(2,17)=t4
	a220(2,17)=t5
	a311(2,17)=t6
	a222(2,17)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.80.0) then     
	a111(3,17)=t3
      a200(3,17)=t4
	a220(3,17)=t5
	a311(3,17)=t6
	a222(3,17)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.80.0) then     
	a111(4,17)=t3
      a200(4,17)=t4
	a220(4,17)=t5
	a311(4,17)=t6
	a222(4,17)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.80.0) then     
	a111(5,17)=t3
      a200(5,17)=t4
	a220(5,17)=t5
	a311(5,17)=t6
	a222(5,17)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.80.0) then     
	a111(6,17)=t3
      a200(6,17)=t4
	a220(6,17)=t5
	a311(6,17)=t6
	a222(6,17)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.80.0) then     
	a111(7,17)=t3
      a200(7,17)=t4
	a220(7,17)=t5
	a311(7,17)=t6
	a222(7,17)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.80.0) then     
	a111(8,17)=t3
      a200(8,17)=t4
	a220(8,17)=t5
	a311(8,17)=t6
	a222(8,17)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.80.0) then     
	a111(9,17)=t3
      a200(9,17)=t4
	a220(9,17)=t5
	a311(9,17)=t6
	a222(9,17)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.80.0) then     
	a111(10,17)=t3
      a200(10,17)=t4
	a220(10,17)=t5
	a311(10,17)=t6
	a222(10,17)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.80.0) then     
	a111(11,17)=t3
      a200(11,17)=t4
	a220(11,17)=t5
	a311(11,17)=t6
	a222(11,17)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.80.0) then     
	a111(12,17)=t3
      a200(12,17)=t4
	a220(12,17)=t5
	a311(12,17)=t6
	a222(12,17)=t7
	goto 666
	endif
cccccccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.85.0) then     
	a111(1,18)=t3
      a200(1,18)=t4
	a220(1,18)=t5
	a311(1,18)=t6
	a222(1,18)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.85.0) then     
	a111(2,18)=t3
      a200(2,18)=t4
	a220(2,18)=t5
	a311(2,18)=t6
	a222(2,18)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.85.0) then     
	a111(3,18)=t3
      a200(3,18)=t4
	a220(3,18)=t5
	a311(3,18)=t6
	a222(3,18)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.85.0) then     
	a111(4,18)=t3
      a200(4,18)=t4
	a220(4,18)=t5
	a311(4,18)=t6
	a222(4,18)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.85.0) then     
	a111(5,18)=t3
      a200(5,18)=t4
	a220(5,18)=t5
	a311(5,18)=t6
	a222(5,18)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.85.0) then     
	a111(6,18)=t3
      a200(6,18)=t4
	a220(6,18)=t5
	a311(6,18)=t6
	a222(6,18)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.85.0) then     
	a111(7,18)=t3
      a200(7,18)=t4
	a220(7,18)=t5
	a311(7,18)=t6
	a222(7,18)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.85.0) then     
	a111(8,18)=t3
      a200(8,18)=t4
	a220(8,18)=t5
	a311(8,18)=t6
	a222(8,18)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.85.0) then     
	a111(9,18)=t3
      a200(9,18)=t4
	a220(9,18)=t5
	a311(9,18)=t6
	a222(9,18)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.85.0) then     
	a111(10,18)=t3
      a200(10,18)=t4
	a220(10,18)=t5
	a311(10,18)=t6
	a222(10,18)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.85.0) then     
	a111(11,18)=t3
      a200(11,18)=t4
	a220(11,18)=t5
	a311(11,18)=t6
	a222(11,18)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.85.0) then     
	a111(12,18)=t3
      a200(12,18)=t4
	a220(12,18)=t5
	a311(12,18)=t6
	a222(12,18)=t7
	goto 666
	endif
cccccccccccccccccccccccccccccccccccccccccccccccccc
      if(t1.eq.0.0.and. t2.eq.90.0) then     
	a111(1,19)=t3
      a200(1,19)=t4
	a220(1,19)=t5
	a311(1,19)=t6
	a222(1,19)=t7
	goto 666
	endif
c
      if(t1.eq.30.0.and. t2.eq.90.0) then     
	a111(2,19)=t3
      a200(2,19)=t4
	a220(2,19)=t5
	a311(2,19)=t6
	a222(2,19)=t7
	goto 666
	endif
c
      if(t1.eq.60.0.and. t2.eq.90.0) then     
	a111(3,19)=t3
      a200(3,19)=t4
	a220(3,19)=t5
	a311(3,19)=t6
	a222(3,19)=t7
	goto 666
	endif
c
      if(t1.eq.90.0.and. t2.eq.90.0) then     
	a111(4,19)=t3
      a200(4,19)=t4
	a220(4,19)=t5
	a311(4,19)=t6
	a222(4,19)=t7
	goto 666
	endif
c
      if(t1.eq.120.0.and. t2.eq.90.0) then     
	a111(5,19)=t3
      a200(5,19)=t4
	a220(5,19)=t5
	a311(5,19)=t6
	a222(5,19)=t7
	goto 666
	endif
c
      if(t1.eq.150.0.and. t2.eq.90.0) then     
	a111(6,19)=t3
      a200(6,19)=t4
	a220(6,19)=t5
	a311(6,19)=t6
	a222(6,19)=t7
	goto 666
	endif
c
      if(t1.eq.180.0.and. t2.eq.90.0) then     
	a111(7,19)=t3
      a200(7,19)=t4
	a220(7,19)=t5
	a311(7,19)=t6
	a222(7,19)=t7
	goto 666
	endif
c
      if(t1.eq.210.0.and. t2.eq.90.0) then     
	a111(8,19)=t3
      a200(8,19)=t4
	a220(8,19)=t5
	a311(8,19)=t6
	a222(8,19)=t7
	goto 666
	endif
c
      if(t1.eq.240.0.and. t2.eq.90.0) then     
	a111(9,19)=t3
      a200(9,19)=t4
	a220(9,19)=t5
	a311(9,19)=t6
	a222(9,19)=t7
	goto 666
	endif
c
      if(t1.eq.270.0.and. t2.eq.90.0) then     
	a111(10,19)=t3
      a200(10,19)=t4
	a220(10,19)=t5
	a311(10,19)=t6
	a222(10,19)=t7
	goto 666
	endif
c
      if(t1.eq.300.0.and. t2.eq.90.0) then     
	a111(11,19)=t3
      a200(11,19)=t4
	a220(11,19)=t5
	a311(11,19)=t6
	a222(11,19)=t7
	goto 666
	endif
c
      if(t1.eq.330.0.and. t2.eq.90.0) then     
	a111(12,19)=t3
      a200(12,19)=t4
	a220(12,19)=t5
	a311(12,19)=t6
	a222(12,19)=t7
	goto 666
	endif
C
      write(*,*) 'error! ', t1, t2
cccccccccccccccccccccccccccccccccccccccccccccccccccc
  666 enddo
  333 continue
C----------------------------------------------------------------------------------------------------------------------------------------	
C  write the head

	str='*Dump of file:XQG'	
	write(46, fmt='(a)') str
	
	str='*Sample: VULCAN'
      write(46, fmt='(a)') str
     
	str='*Corrected, rescaled data * Phi range    0.00 -  360.00 Step
     #    5.00'
	write(46, fmt='(a)') str

	str='*Pole figure: 111'   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! name of the pole figure
	write(46, fmt='(a)') str
c	
	qq=0.0
	do j=1, 19, 1               ! 19 blocks
c
	str='*Khi ='
	write(46,fmt='(a6, f7.2)') str, qq
c
c linear interpolation method is used here
c
      do k=1, 9, 1
c	
	if(mod((k-1)*40,30).eq.0) then
	 y1=a111(((k-1)*40/30)+1,j)
	else
	 ilow=((k-1)*40/30)+1
	  iup=((k-1)*40/30)+2
	if(iup.gt.12) iup=1
	tmp1=a111(ilow,j)
	tmp2=a111(iup,j)

	y1=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40,30)))/30.0
	endif
c
	if(mod((k-1)*40+5,30).eq.0) then
	 y2=a111((((k-1)*40+5)/30)+1,j)
	else
	 ilow=(((k-1)*40+5)/30)+1
	  iup=(((k-1)*40+5)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a111(ilow,j)
	tmp2=a111(iup,j)

	y2=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+5,30)))/30.0
	endif
c
	if(mod((k-1)*40+10,30).eq.0) then
	 y3=a111((((k-1)*40+10)/30)+1,j)
	else
	 ilow=(((k-1)*40+10)/30)+1
	  iup=(((k-1)*40+10)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a111(ilow,j)
	tmp2=a111(iup,j)

	y3=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+10,30)))/30.0
	endif
c
	if(mod((k-1)*40+15,30).eq.0) then
	 y4=a111((((k-1)*40+15)/30)+1,j)
	else
	 ilow=(((k-1)*40+15)/30)+1
	  iup=(((k-1)*40+15)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a111(ilow,j)
	tmp2=a111(iup,j)

	y4=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+15,30)))/30.0
	endif
c
	if(mod((k-1)*40+20,30).eq.0) then
	 y5=a111((((k-1)*40+20)/30)+1,j)
	else
	 ilow=(((k-1)*40+20)/30)+1
	  iup=(((k-1)*40+20)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a111(ilow,j)
	tmp2=a111(iup,j)

	y5=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+20,30)))/30.0
	endif
c
	if(mod((k-1)*40+25,30).eq.0) then
	 y6=a111((((k-1)*40+25)/30)+1,j)
	else
	 ilow=(((k-1)*40+25)/30)+1
	  iup=(((k-1)*40+25)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a111(ilow,j)
	tmp2=a111(iup,j)

	y6=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+25,30)))/30.0
	endif
c
	if(mod((k-1)*40+30,30).eq.0) then
	 y7=a111((((k-1)*40+30)/30)+1,j)
	else
	 ilow=(((k-1)*40+20)/30)+1
	  iup=(((k-1)*40+30)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a111(ilow,j)
	tmp2=a111(iup,j)

	y7=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+30,30)))/30.0
	endif
c
	if(mod((k-1)*40+35,30).eq.0) then
	 y8=a111((((k-1)*40+35)/30)+1,j)
	else
	 ilow=(((k-1)*40+35)/30)+1
	  iup=(((k-1)*40+35)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a111(ilow,j)
	tmp2=a111(iup,j)

	y8=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+35,30)))/30.0
	endif
c
	write(46, fmt='(8f8.4)') y1, y2, y3, y4, y5, y6, y7, y8
c
      enddo
c	
	qq=qq+5.0                   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  increment
	enddo
	write(46,*) ' '
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C----------------------------------------------------------------------------------------------------------------------------------------	
C  write the head

	str='*Dump of file:XQG'	
	write(46, fmt='(a)') str
	
	str='*Sample: TC11'
      write(46, fmt='(a)') str
     
	str='*Corrected, rescaled data * Phi range    0.00 -  360.00 Step
     #    5.00'
	write(46, fmt='(a)') str

	str='*Pole figure:   200'   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! name of the pole figure
	write(46, fmt='(a)') str
c           
	qq=0.0
	do j=1, 19, 1               ! 19 blocks
	str='*Khi ='
	write(46,fmt='(a6, f7.2)') str, qq
c
c
c linear interpolation method is used here
c
      do k=1, 9, 1
c	
	if(mod((k-1)*40,30).eq.0) then
	 y1=a200(((k-1)*40/30)+1,j)
	else
	 ilow=((k-1)*40/30)+1
	  iup=((k-1)*40/30)+2
	if(iup.gt.12) iup=1
	tmp1=a200(ilow,j)
	tmp2=a200(iup,j)

	y1=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40,30)))/30.0
	endif
c
	if(mod((k-1)*40+5,30).eq.0) then
	 y2=a200((((k-1)*40+5)/30)+1,j)
	else
	 ilow=(((k-1)*40+5)/30)+1
	  iup=(((k-1)*40+5)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a200(ilow,j)
	tmp2=a200(iup,j)

	y2=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+5,30)))/30.0
	endif
c
	if(mod((k-1)*40+10,30).eq.0) then
	 y3=a200((((k-1)*40+10)/30)+1,j)
	else
	 ilow=(((k-1)*40+10)/30)+1
	  iup=(((k-1)*40+10)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a200(ilow,j)
	tmp2=a200(iup,j)

	y3=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+10,30)))/30.0
	endif
c
	if(mod((k-1)*40+15,30).eq.0) then
	 y4=a200((((k-1)*40+15)/30)+1,j)
	else
	 ilow=(((k-1)*40+15)/30)+1
	  iup=(((k-1)*40+15)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a200(ilow,j)
	tmp2=a200(iup,j)

	y4=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+15,30)))/30.0
	endif
c
	if(mod((k-1)*40+20,30).eq.0) then
	 y5=a200((((k-1)*40+20)/30)+1,j)
	else
	 ilow=(((k-1)*40+20)/30)+1
	  iup=(((k-1)*40+20)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a200(ilow,j)
	tmp2=a200(iup,j)

	y5=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+20,30)))/30.0
	endif
c
	if(mod((k-1)*40+25,30).eq.0) then
	 y6=a200((((k-1)*40+25)/30)+1,j)
	else
	 ilow=(((k-1)*40+25)/30)+1
	  iup=(((k-1)*40+25)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a200(ilow,j)
	tmp2=a200(iup,j)

	y6=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+25,30)))/30.0
	endif
c
	if(mod((k-1)*40+30,30).eq.0) then
	 y7=a200((((k-1)*40+30)/30)+1,j)
	else
	 ilow=(((k-1)*40+20)/30)+1
	  iup=(((k-1)*40+30)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a200(ilow,j)
	tmp2=a200(iup,j)

	y7=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+30,30)))/30.0
	endif
c
	if(mod((k-1)*40+35,30).eq.0) then
	 y8=a200((((k-1)*40+35)/30)+1,j)
	else
	 ilow=(((k-1)*40+35)/30)+1
	  iup=(((k-1)*40+35)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a200(ilow,j)
	tmp2=a200(iup,j)

	y8=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+35,30)))/30.0
	endif
c
	write(46, fmt='(8f8.4)') y1, y2, y3, y4, y5, y6, y7, y8
c
      enddo
c
	qq=qq+5.0                   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  increment
	enddo
	write(46,*) ' '
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C----------------------------------------------------------------------------------------------------------------------------------------	
C  write the head

	str='*Dump of file:XQG'	
	write(46, fmt='(a)') str
	
	str='*Sample: TC11'
      write(46, fmt='(a)') str
     
	str='*Corrected, rescaled data * Phi range    0.00 -  360.00 Step
     #    5.00'
	write(46, fmt='(a)') str

	str='*Pole figure:   220'   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! name of the pole figure
	write(46, fmt='(a)') str
c           
	qq=0.0
	do j=1, 19, 1               ! 19 blocks
	str='*Khi ='
	write(46,fmt='(a6, f7.2)') str, qq
c
c
c linear interpolation method is used here
c
      do k=1, 9, 1
c	
	if(mod((k-1)*40,30).eq.0) then
	 y1=a220(((k-1)*40/30)+1,j)
	else
	 ilow=((k-1)*40/30)+1
	  iup=((k-1)*40/30)+2
	if(iup.gt.12) iup=1
	tmp1=a220(ilow,j)
	tmp2=a220(iup,j)

	y1=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40,30)))/30.0
	endif
c
	if(mod((k-1)*40+5,30).eq.0) then
	 y2=a220((((k-1)*40+5)/30)+1,j)
	else
	 ilow=(((k-1)*40+5)/30)+1
	  iup=(((k-1)*40+5)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a220(ilow,j)
	tmp2=a220(iup,j)

	y2=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+5,30)))/30.0
	endif
c
	if(mod((k-1)*40+10,30).eq.0) then
	 y3=a220((((k-1)*40+10)/30)+1,j)
	else
	 ilow=(((k-1)*40+10)/30)+1
	  iup=(((k-1)*40+10)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a220(ilow,j)
	tmp2=a220(iup,j)

	y3=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+10,30)))/30.0
	endif
c
	if(mod((k-1)*40+15,30).eq.0) then
	 y4=a220((((k-1)*40+15)/30)+1,j)
	else
	 ilow=(((k-1)*40+15)/30)+1
	  iup=(((k-1)*40+15)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a220(ilow,j)
	tmp2=a220(iup,j)

	y4=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+15,30)))/30.0
	endif
c
	if(mod((k-1)*40+20,30).eq.0) then
	 y5=a220((((k-1)*40+20)/30)+1,j)
	else
	 ilow=(((k-1)*40+20)/30)+1
	  iup=(((k-1)*40+20)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a220(ilow,j)
	tmp2=a220(iup,j)

	y5=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+20,30)))/30.0
	endif
c
	if(mod((k-1)*40+25,30).eq.0) then
	 y6=a220((((k-1)*40+25)/30)+1,j)
	else
	 ilow=(((k-1)*40+25)/30)+1
	  iup=(((k-1)*40+25)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a220(ilow,j)
	tmp2=a220(iup,j)

	y6=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+25,30)))/30.0
	endif
c
	if(mod((k-1)*40+30,30).eq.0) then
	 y7=a220((((k-1)*40+30)/30)+1,j)
	else
	 ilow=(((k-1)*40+20)/30)+1
	  iup=(((k-1)*40+30)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a220(ilow,j)
	tmp2=a220(iup,j)

	y7=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+30,30)))/30.0
	endif
c
	if(mod((k-1)*40+35,30).eq.0) then
	 y8=a220((((k-1)*40+35)/30)+1,j)
	else
	 ilow=(((k-1)*40+35)/30)+1
	  iup=(((k-1)*40+35)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a220(ilow,j)
	tmp2=a220(iup,j)

	y8=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+35,30)))/30.0
	endif
c
	write(46, fmt='(8f8.4)') y1, y2, y3, y4, y5, y6, y7, y8
c
      enddo	
c
	qq=qq+5.0                   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  increment
	enddo
	write(46,*) ' '
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C----------------------------------------------------------------------------------------------------------------------------------------	
C  write the head
	str='*Dump of file:XQG'	
	write(46, fmt='(a)') str
	
	str='*Sample: VULCAN'
      write(46, fmt='(a)') str
     
	str='*Corrected, rescaled data * Phi range    0.00 -  360.00 Step
     #    5.00'
	write(46, fmt='(a)') str

	str='*Pole figure: 222'   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! name of the pole figure
	write(46, fmt='(a)') str
c	
	qq=0.0
	do j=1, 19, 1               ! 19 blocks
c
	str='*Khi ='
	write(46,fmt='(a6, f7.2)') str, qq
c
c linear interpolation method is used here
c
      do k=1, 9, 1
c	
	if(mod((k-1)*40,30).eq.0) then
	 y1=a222(((k-1)*40/30)+1,j)
	else
	 ilow=((k-1)*40/30)+1
	  iup=((k-1)*40/30)+2
	if(iup.gt.12) iup=1
	tmp1=a222(ilow,j)
	tmp2=a222(iup,j)

	y1=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40,30)))/30.0
	endif
c
	if(mod((k-1)*40+5,30).eq.0) then
	 y2=a222((((k-1)*40+5)/30)+1,j)
	else
	 ilow=(((k-1)*40+5)/30)+1
	  iup=(((k-1)*40+5)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a222(ilow,j)
	tmp2=a222(iup,j)

	y2=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+5,30)))/30.0
	endif
c
	if(mod((k-1)*40+10,30).eq.0) then
	 y3=a222((((k-1)*40+10)/30)+1,j)
	else
	 ilow=(((k-1)*40+10)/30)+1
	  iup=(((k-1)*40+10)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a222(ilow,j)
	tmp2=a222(iup,j)

	y3=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+10,30)))/30.0
	endif
c
	if(mod((k-1)*40+15,30).eq.0) then
	 y4=a222((((k-1)*40+15)/30)+1,j)
	else
	 ilow=(((k-1)*40+15)/30)+1
	  iup=(((k-1)*40+15)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a222(ilow,j)
	tmp2=a222(iup,j)

	y4=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+15,30)))/30.0
	endif
c
	if(mod((k-1)*40+20,30).eq.0) then
	 y5=a222((((k-1)*40+20)/30)+1,j)
	else
	 ilow=(((k-1)*40+20)/30)+1
	  iup=(((k-1)*40+20)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a222(ilow,j)
	tmp2=a222(iup,j)

	y5=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+20,30)))/30.0
	endif
c
	if(mod((k-1)*40+25,30).eq.0) then
	 y6=a222((((k-1)*40+25)/30)+1,j)
	else
	 ilow=(((k-1)*40+25)/30)+1
	  iup=(((k-1)*40+25)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a222(ilow,j)
	tmp2=a222(iup,j)

	y6=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+25,30)))/30.0
	endif
c
	if(mod((k-1)*40+30,30).eq.0) then
	 y7=a222((((k-1)*40+30)/30)+1,j)
	else
	 ilow=(((k-1)*40+20)/30)+1
	  iup=(((k-1)*40+30)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a222(ilow,j)
	tmp2=a222(iup,j)

	y7=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+30,30)))/30.0
	endif
c
	if(mod((k-1)*40+35,30).eq.0) then
	 y8=a222((((k-1)*40+35)/30)+1,j)
	else
	 ilow=(((k-1)*40+35)/30)+1
	  iup=(((k-1)*40+35)/30)+2
	if(iup.gt.12) iup=1
	tmp1=a222(ilow,j)
	tmp2=a222(iup,j)

	y8=tmp1+(tmp2-tmp1)*(real(mod((k-1)*40+35,30)))/30.0
	endif
c
	write(46, fmt='(8f8.4)') y1, y2, y3, y4, y5, y6, y7, y8
c
      enddo
c	
	qq=qq+5.0                   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  increment
	enddo
	write(46,*) ' '

c
	close(46)
	close(45)
	end program xqg
