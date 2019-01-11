# single-cell-IMP-methods


### Running

Command to run each algorithm:

```
# scImpute
./run_scripts/scimpute.sh input_file.csv output_file.csv output_dir
# MAGIC
./run_scripts/magic.sh input_file.csv output_file.csv output_dir
# UNCURL
./run_scripts/uncurl.sh input_file.csv output_file.csv output_dir
# BISCUIT (is very buggy)
./run_scripts/uncurl.sh input_file.csv output_file.csv output_dir 
```


### Re-Building

There is no need to build images locally.
However, To build docker images run:

```
./build_all.sh
```
