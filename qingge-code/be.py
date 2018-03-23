#!/usr/bin/env python

import numpy as np, os, sys

tex = 'xqg.tex'
N_RD = 36
N_HD = 144
tolerance = 1.25 # 90./36/2.
out = 'list-frompy.dat'

# read texture file
texdata = np.loadtxt(tex, skiprows=4)
N_grains = len(texdata)

euler_matrices = np.zeros((N_grains, 3, 3), float)

def euler_angles2matrix(fi1, PHI, fi2, T):
    COS = np.cos; SIN = np.sin
    DEG2RAD = np.deg2rad(1)
    fi1 *= DEG2RAD
    PHI *= DEG2RAD
    fi2 *= DEG2RAD
    C1=COS(fi1)
    C= COS(PHI)
    C2=COS(fi2)
    S1=SIN(fi1)
    S= SIN(PHI)
    S2=SIN(fi2)
    T[0,0]=C1*C2-S1*S2*C
    T[0,1]=S1*C2+C1*S2*C
    T[0,2]=S2*S
    T[1,0]=-C1*S2-S1*C2*C
    T[1,1]=-S1*S2+C1*C2*C
    T[1,2]=C2*S
    T[2,0]=S1*S
    T[2,1]=-C1*S
    T[2,2]=C
    return



for i in range(N_grains):
    line = texdata[i]
    fi1, PHI, fi2 = line[:3]
    euler_angles2matrix(fi1, PHI, fi2, euler_matrices[i])
    continue
#
euler_matrices = np.transpose(euler_matrices, (0, 2, 1))

_hkls = [111, 200, 220, 311, 222, 400, 331, 420, 422, 511, 333, 440, 531]
hkls = []
for hkl in _hkls:
    h = hkl//100
    k = (hkl%100)//10
    l = hkl % 10
    hkls.append([h,k,l])
    continue
print hkls

d_spacing_list = [
    2.07793,
    1.800787,
    1.272775,
    1.085376,
    1.038812,
    0.90032,
    0.825621,
    0.804956,
    0.734553,
    0.692623,
    0.692623,
    0.6356,
    0.6082,
    ]

def equiv_planes(hkl):
    h, k, l = hkl
    all = [(h, k, l)]
    candidates = [ (-h, k, l), (h, -k, l), (h,k, -l), (-h, -k, l), (-h, k, -l), (h, -k, -l), (-h, -k, -l)]
    from itertools import permutations
    for c in candidates:
        for p in permutations(c):
            if not isDuplicate(p, all):
                all.append(p)
        continue
    return all

def isDuplicate(hkl, collection):
    if hkl in collection: return True
    h,k,l = hkl; nhkl = -h,-k,-l
    if nhkl in collection: return True
    return False

def normalized_equiv_planes(hkl):
    hkls = equiv_planes(hkl)
    norm = lambda x: x/np.linalg.norm(x)
    norma = lambda x: norm(np.array(x))
    return map(norma, hkls)

# print equiv_planes((5,3,1))
# sys.exit(1)

outstream = open(out, 'wt')
matched_min = np.cos(tolerance*np.pi/180.)
for ihkl, (hkl, d_spacing) in enumerate(zip(hkls, d_spacing_list)):
    print ihkl
    for iRD in range(N_RD+1):
        # print iRD
        RD = iRD * np.pi/2. / N_RD  # from 0 to pi/2
        lambda_ = 2.*d_spacing*np.sin( RD )
        alfa = np.arccos(lambda_/2./d_spacing)
        for iHD in range(N_HD): 
            beta = iHD * np.pi*2 / N_HD  # from 0 to <2*pi
            sa=np.sin(alfa)            
            v = np.array([sa*np.cos(beta), sa*np.sin(beta), np.cos(alfa)])
            icounter = 0
            
            # equiv_planes() calculates nfamily
            hkl_family = normalized_equiv_planes(hkl) # ??? why not outside iRD and iHD?

            # print iRD, iHD, hkl_family
            for ipl, hkl1 in enumerate(hkl_family):
                # hkl1dotv = np.dot(hkl1, v)
                prodesc = np.dot(np.dot(euler_matrices, hkl1), v)
                prodesc = np.abs(prodesc)
                # prodesc is close to 1 means a match
                icounter+= np.sum(prodesc >= matched_min)
                continue
            outstream.write("%6i%8i%8i%8i%8i%14.6f\n"  % (
                ihkl+1, icounter, iRD+1, iHD+1, 0, lambda_
            ))
            continue # iHD
        continue #iRD
    continue #hkl
