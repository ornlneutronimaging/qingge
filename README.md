[![Build Status](https://travis-ci.org/ornlneutronimaging/qingge.svg?branch=master)](https://travis-ci.org/ornlneutronimaging/qingge)
[![codecov](https://codecov.io/gh/ornlneutronimaging/qingge/branch/master/graph/badge.svg)](https://codecov.io/gh/ornlneutronimaging/qingge)
[![Documentation Status](https://readthedocs.com/projects/ornl-qingge/badge/?version=latest)](https://ornl-qingge.readthedocs-hosted.com/en/latest/?badge=latest)


# QingGe's workflow

* **step1**  Use Excel to convert VDrive output to inputs suitable for MTEX
  - Inputs to MTEX could be generated by VDRIVE (VDRIVE single peak fitting).
      - typical VDRIVE output file name (VDrivesSPF-78901-79020-bk1.txt)
      - _1 and _2 stands for bank1 and bank2
      - those columns have to be copy/paste to the rigth page of Ducu's excel document 
  - They are converted by Excel (Ducu created formulas here) to something suitable for mtex (copy and paste bank1 and bank2, and then there is a formula in excel to compute a table ("OutPut").
  - Copy the output to a text file (ducu.txt) (only first 4 columns are used, only first 2 are enough)

* Run VULCAN2MTEX (fortran code) to convert ducu.txt. Output vulcan.rpf
  This program performs some linear interpolation as well as the format of the file

* Use MTEX to generate several thousand grain orientations (pole figures). 
  - MTEX is available at vulcan2.sns.gov. Start Matlab 2014a. add directory /usr/local/mtex-3.5.0. startup_mtex
  - change directory to where the data files are
  - import pole figure
  - set crystal reference frame
  - set Specimen Reference Frame
  - choose miller indices
  - import to script
  - a script is genrated
  - Now edit the script
    - mtex has a bug. change specimen symmetry to appropiate one.
      ex: 'triclinic' for Fe   ( ss = symmetry('triclinic')

* Use ???? (fortran code) to calculate Bragg Edge profile
  - inputs: texture
  - structure factors are harded-coded in the fortran code

**Files format**

**VDRivesSPF-78901-79020.txt**

 first row: names of following columns
 
 Run_number

GoodFit_Ni111_1    ChiSq_Ni111_1    d_Ni111_1    ed_Ni111_1    Tof_Ni111_1    eTof_Ni111_1    I/V_Ni111_1    eI/V_Ni111_1    I/V1_Ni111_1    eI/V1_Ni111_1    B/V_Ni111_1    eB/V_Ni111_1    Sig^2_Ni111_1    eSig^2_Ni111_1    Gam_Ni111_1    eGam_Ni111_1    FWHM_Ni111_1    eFWHM_Ni111_1    Strain_Ni111_1    eStrain_Ni111_1

and then this repeat for each Element and hkl

The excel spreadsheet seems to only used the I/V and eI/V

The **_1** and **_2** stands for bank1 and bank2
