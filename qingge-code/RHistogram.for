	program xqg
      implicit none
	character(len=160) str
	integer i,k,count,n, ino1,iRD,iHD,iblock, imin, imax
        integer ddata(37,144,13)
        real*8  vLameda, dLameda(37,13),R(37,13),Rfactor(13),
     # dnorm(37,144,13)                    
        real*8 F(13),v0, d(13), tmp, tLameda, cross, dk,db
C
       F(1)=1638.575*8/100.0
       F(2)=1619.411*6/100.0
       F(3)=1544.968*12/100.0
       F(4)=1491.391*24/100.0
       F(5)=1473.948*8/100.0
       F(6)=1406.193*6/100.0
       F(7)=1357.428*24/100.0
       F(8)=1341.552*24/100.0
       F(9)=1279.882*24/100.0
       F(10)=1235.498*24/100.0
       F(11)=1235.498*8/100.0
       F(12)=1164.918*12/100.0
       F(13)=1124.52*48/100.0
       v0= 46.462     ! unit=A^3
       d(1)=2.07793
       d(2)=1.800787
       d(3)=1.272775
       d(4)=1.085376
       d(5)=1.038812
       d(6)=0.90032
       d(7)=0.825621
       d(8)=0.804956
       d(9)=0.734553  
       d(10)=0.692623
       d(11)=0.692623
       d(12)=0.6356
       d(13)=0.6082
C
       open(unit=46, file='result.txt',status='unknown',action='write')
       
        count=0
	open(unit=45, file='List.txt',status='old',action='read')
	do while(1)
c                   n icounter(n), iRD, iHD, iblock, Lameda
	read(45, *, end=100) n, ino1, iRD,iHD,iblock,vLameda
        ddata(iRD,iHD,n)=ino1
        dLameda(iRD,n)=vLameda
	count=count+1
	enddo
  100 close(45)
      write(*,*) count, '=',  ' lines'
c
      do n=1,13,1
      tmp=0.0
      do i=1, 37, 1
      do k=1,144,1
      tmp=tmp+real(ddata(i,k,n))
      enddo
      enddo
      tmp=tmp/144.0/37.0
c 
      do i=1, 37, 1
      do k=1,144,1
      dnorm(i,k,n)=real(ddata(i,k,n))/tmp
c      write(*,fmt='(1(f16.8,1x))') 
c     # dnorm(i,k,n)
      enddo
      enddo
C
      enddo
C  calculate the R factor for the limited number of Lameda
      R=0.0
      do n=1, 13, 1
      do i=1, 37, 1
c
      do k=1, 144, 1
      R(i,n)=R(i,n)+dnorm(i,k,n)
      enddo
c
      R(i,n)=R(i,n)/144.0
c      write(*,*) R(1,n)
      enddo
      enddo 
c      write(*,*) dLameda(2,1),dLameda(2,13)
c
      Do tLameda=0.0, 5.0, 0.025
      cross=0.0
C  
      Do n=1,13,1
C 
      do i=1, 37, 1 
      if(tLameda.eq.dLameda(i,n)) then  
      Rfactor(n)=R(i,n)
      write(*,*) tLameda, Rfactor(n)
      goto 333
      endif
      enddo

C  
      imin=0
      imax=0
      
      do i=1,36 ,1   
      if(tlameda.gt.dLameda(i,n).and.tLameda.lt.dLameda(i+1,n)) then
      imin=i
      imax=i+1
      endif
      enddo
c
      if(imin.eq.imax) then
      Rfactor(n)=0.0
      else
c
      dk=(R(imax,n)-R(imin,n))/(dLameda(imax,n)-dLameda(imin,n))
      db=R(imax,n)-dk*dLameda(imax,n)
      Rfactor(n)=dk*tLameda+db
      endif
c
  333 continue
      cross=cross+Rfactor(n)/4.0
     #/v0*d(n)*F(n)*tLameda**2.0 
      enddo ! end n=1,13
      write(46,fmt='(15(f12.4,2x))') tLameda,
     # (Rfactor(k),k=1,13),cross
      enddo
c
      close(46)
      end program xqg
