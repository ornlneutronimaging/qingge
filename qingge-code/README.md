# Files

* texture to Bragg Edge info
  - BraggEdge.for: fortran code
  - compute_int_samples.py: python code
  - List.txt: fortran output
  - int_samples.dat: python output
  - expected-...: expected outputs
  - run ./compute_int_samples.py and make sure the int_samples.dat is the same as expected-int_samples.dat
* Bragg Edge intensity calculation
  - Fortran: RHistogram.for
  - jupyter notebook: "calculate cross section.ipynb"
    - it uses compute_int_samples.read_results method to read int_samples.dat and calculates R
    - then it uses R in cross section calculation

# TODO

* Should make these two steps more pythonic. There is really no need to generate
  the text data file int_samples.dat. Maybe merge these two steps to just one step:
  read texture file (xqg.tex) and then calculates R_vs_lambda functions.