        program xqg
        implicit none
        Character(len=160) cmdtxt,str
        integer i, j, count, nn(3,13), iTOTAL
        real*8, allocatable:: EulerORNL(:,:), euler(:,:,:)
        real*8 T(3,3),PI                         !!!! for 10000 grains only
C        
       iTOTAL=5000  ! how many elements are there in the model?
       PI=4.d0*datan(1.d0)
C	    
        cmdtxt='rm List.txt'
        call system(cmdtxt)
C
      open(unit=11,file='List.txt', status='unknown',action='write')
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
c
        allocate (EulerORNL(3, iTOTAL))
        allocate  (euler(3, 3, iTOTAL))
c  
        open(unit=45, file='xqg.tex',status='old',action='read')  !!!!!!!!!!!!!!!!!!!!!!!!                              
        read(45,*)
        read(45,*)
        read(45,*)
        read(45,*)
c
        do i=1, iTOTAL, 1
        read(45, *) EulerORNL(1,i),EulerORNL(2,i),EulerORNL(3,i)  ! degree
c
      call Tmatrix(T,  EulerORNL(1,i)*PI/180.0,
     #                 EulerORNL(2,i)*PI/180.0,
     #                 EulerORNL(3,i)*PI/180.0)
	euler(1,1,i)=T(1,1)
	euler(1,2,i)=T(1,2)
	euler(1,3,i)=T(1,3)
	euler(2,1,i)=T(2,1)
	euler(2,2,i)=T(2,2)
	euler(2,3,i)=T(2,3)
	euler(3,1,i)=T(3,1)
	euler(3,2,i)=T(3,2)
	euler(3,3,i)=T(3,3)
c	
        enddo ! end iTOTAL
C@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	nn(1,1)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,1)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,1)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,2)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,2)=0      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,2)=0      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,3)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,3)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,3)=0      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,4)=3      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,4)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,4)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,5)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,5)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,5)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,6)=4      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,6)=0      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,6)=0      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,7)=3      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,7)=3      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,7)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,8)=4      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,8)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,8)=0      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,9)=4      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,9)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,9)=2      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,10)=5      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,10)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,10)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,11)=3      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,11)=3      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,11)=3      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,12)=4      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,12)=4      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,12)=0      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
	nn(1,13)=5      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(2,13)=3      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
	nn(3,13)=1      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! define the studied plane
c
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC	
	call Rprofile(nn, euler)
	write(*,*) 'Finish calculations '

c
	 close(46)
      close(11)
      close(31)
      close(32)
      close(33)
      close(34)
      close(61)
      close(62)
      close(63)
      close(64)
	deallocate (EulerORNL)
	deallocate (euler)
	end program xqg

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      SUBROUTINE Rprofile(n4, r)
        Implicit double precision (a-h,o-z)           
        DIMENSION vs(3), n4(3,13),                
     #          pc(3,48),                 
     #          icounter(13),      
     #              ps(3),                        
     #          r(3,3,10000),              
     #          TTT(3,3), pss(3),
     #          ipole(3),pc2(3,48),tmp(3), tmp2(3) 
C  	
        nelements=5000                   !!!!!!!!!!!!!!!!!!!!!!!!
        pi=4.d0*datan(1.d0) 

        do n= 1, 13, 1                           !!!
C
        if(n.eq.1) then
        dspacing=2.07793
        elseif(n.eq.2) then
        dspacing=1.800787
        elseif(n.eq.3) then
        dspacing=1.272775
        elseif(n.eq.4) then
        dspacing=1.085376
        elseif(n.eq.5) then
        dspacing=1.038812
        elseif(n.eq.6) then
        dspacing=0.90032
        elseif(n.eq.7) then
        dspacing=0.825621
        elseif(n.eq.8) then
        dspacing=0.804956
        elseif(n.eq.9) then
        dspacing=0.734553
        elseif(n.eq.10) then
        dspacing=0.692623
        elseif(n.eq.11) then
        dspacing=0.692623
        elseif(n.eq.12) then
        dspacing=0.6356
        elseif(n.eq.13) then
        dspacing=0.6082
        else
        write(*,*) 'Error in n'
        stop
        endif
C
        do iRD=1, 37, 1                      
        dlameda=2.0*dspacing*sin(real(iRD-1)*2.5*pi/180.0)                                                   
c        
        alfa=acos(dlameda/2.0/dspacing)
c
        tolerance=1.25    !!!!!!!!!! 0.625  degree
c 
        do iHD=1, 144, 1                         
c
            vs(1)=sin(alfa)*cos(real((iHD-1)*2.5*pi/180.0))                            
            vs(2)=sin(alfa)*sin(real((iHD-1)*2.5*pi/180.0))                          
            vs(3)=cos(alfa)                                        
c  
        qqtmp=sqrt(vs(1)*vs(1)+vs(2)*vs(2)+vs(3)*vs(3))
        vs(1)=vs(1)/qqtmp  
        vs(2)=vs(2)/qqtmp 
        vs(3)=vs(3)/qqtmp 
c
       icounter(n)=0  
       call equiv_planes(n4(1,n), pc, nfamily)
c
          do ng=1, nelements, 1
              inner=0
                do ipl=1, nfamily, 1
c 
              do i=1, 3, 1
                ps(i)=0.d0
                do j=1,3
c
                  ps(i)=ps(i)+r(j,i,ng)*pc(j,ipl)  ! vectors in sample frame
                enddo
              enddo
c
C
              prodesc=0.d0
              do i=1,3,1
                prodesc=prodesc+ps(i)*vs(i)      ! both vectors are unit ones
              enddo
C            	       
        if ( dabs(prodesc).ge.dcos(tolerance*pi/180.0)) then  !!!!!!!!!!!!!!!           
        if (inner.ge.2) then
        write(*,*) iRD, iHD, n, ng, ipl 
        stop
        endif
c
                              icounter(n)=icounter(n)+1                                ! count 
                              inner=inner+1
c
	if(icounter(n).ge.10000) then                                
	write(*,*) 'Larger than 10000, increase the size of the matrix'    
	stop
      endif
c
      endif
c
            enddo     ! loop over all families
            enddo     ! loop over all elements

        write(11,fmt='(5(i6,2x), f12.6)') 
     #  n,icounter(n),iRD,iHD, iblock, dlameda

	 enddo   ! end of iHD
      enddo   !  end of iRD
 666  enddo   ! loop over all diffraction directions

      return
      END
 
 
      SUBROUTINE equiv_planes(n4, pc, nfamily)
C  this subroutine was from C N TOME
C  it was corrected by Qingge XIE later
      IMPLICIT REAL*8 (a-h,o-z)
      DIMENSION pc(3,48), n4(3), itag(48)
      n=1
        do ip=1,3,1
          ip1= ip   - ip   /4*3
          ip2=(ip+1)-(ip+1)/4*3
          ip3=(ip+2)-(ip+2)/4*3
          pc(1,n)= n4(ip1)
          pc(2,n)= n4(ip2)
          pc(3,n)= n4(ip3)
          n=n+1
          pc(1,n)=-n4(ip1)
          pc(2,n)= n4(ip2)
          pc(3,n)= n4(ip3)
          n=n+1
          pc(1,n)= n4(ip1)
          pc(2,n)=-n4(ip2)
          pc(3,n)= n4(ip3)
          n=n+1
          pc(1,n)=-n4(ip1)
          pc(2,n)=-n4(ip2)
          pc(3,n)= n4(ip3)
          n=n+1
 
         itmp=ip2
	    ip2=ip3
          ip3=itmp

	    pc(1,n)= n4(ip1)
		pc(2,n)= n4(ip2)
          pc(3,n)= n4(ip3)
          n=n+1
          pc(1,n)=-n4(ip1)
          pc(2,n)= n4(ip2)
          pc(3,n)= n4(ip3)
          n=n+1
          pc(1,n)= n4(ip1)
          pc(2,n)=-n4(ip2)
          pc(3,n)= n4(ip3)
          n=n+1
          pc(1,n)=-n4(ip1)
          pc(2,n)=-n4(ip2)
          pc(3,n)= n4(ip3)
          n=n+1         
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
        enddo
      nfamily=n-1
c normalize
      do nf=1, nfamily, 1
        itag(nf)=0
        pcn=dsqrt(pc(1,nf)**2+pc(2,nf)**2+pc(3,nf)**2)
        do j=1,3
          pc(j,nf)=pc(j,nf)/pcn
        enddo
      enddo
c
      do nf=1,nfamily-1, 1
        do mf=nf+1,nfamily, 1
          pcdif=(pc(1,nf)-pc(1,mf))**2+(pc(2,nf)-pc(2,mf))**2+
     #          (pc(3,nf)-pc(3,mf))**2
          pcsum=(pc(1,nf)+pc(1,mf))**2+(pc(2,nf)+pc(2,mf))**2+
     #          (pc(3,nf)+pc(3,mf))**2
          if(pcdif.le.1.d-4 .or. pcsum.le.1.d-4) itag(mf)=1
        enddo
      enddo
c
      nfax=0
      do nf=1,nfamily, 1
        if(itag(nf).eq.0) then
          nfax=nfax+1
          pc(1,nfax)=pc(1,nf)
          pc(2,nfax)=pc(2,nf)
          pc(3,nfax)=pc(3,nf)
        endif
      enddo
      nfamily=nfax
      return
      END	


      Subroutine Tmatrix(T,fi1,PHI,fi2)
      IMPLICIT double precision (A-H,O-Z)
C     To calculate T-matrix from Euler angles
      dimension T(3,3)
      C1=COS(fi1)
      C= COS(PHI)
      C2=COS(fi2)
      S1=SIN(fi1)
      S= SIN(PHI)
      S2=SIN(fi2)
      T(1,1)=C1*C2-S1*S2*C
      T(1,2)=S1*C2+C1*S2*C
      T(1,3)=S2*S
      T(2,1)=-C1*S2-S1*C2*C
      T(2,2)=-S1*S2+C1*C2*C
      T(2,3)=C2*S
      T(3,1)=S1*S
      T(3,2)=-C1*S
      T(3,3)=C
      return
      end
