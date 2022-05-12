# Pitch Discrimination Task (PDT)

The PDT is an adaptive test for testing pitch discrimination.


## Citation

We also advise mentioning the software versions you used,
in particular the versions of the `PDT`, `psychTestR`, and `psychTestRCAT` packages.
You can find these version numbers from R by running the following commands:

``` r
library(PDT)
library(psychTestR)
library(psychTestRCAT)
if (!require(devtools)) install.packages("devtools")
x <- devtools::session_info()
x$packages[x$packages$package %in% c("PDT", "psychTestR", "psychTestRCAT"), ]
```


## Installation instructions (local use)

1. If you don't have R installed, install it from here: https://cloud.r-project.org/

2. Open R.

3. Install the ‘devtools’ package with the following command:

`install.packages('devtools')`

4. Install the PDT:

`devtools::install_github('sebsilas/PDT')`

## Usage

### Quick demo 

You can demo the PDT at the R console, as follows:

``` r
# Load the PDT package
library(PDT)

# Run a demo
PDT_standalone()

# Include in timeline

PDT()

```
