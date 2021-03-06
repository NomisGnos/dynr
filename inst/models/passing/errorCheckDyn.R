#------------------------------------------------------------------------------
# Author: Michael D. Hunter
# Date: 2017-10-30
# Filename: errorCheckDyn.R
# Purpose: Check that errors are caught and reported properly.
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------

require(dynr)
vd <- matrix(c(0, -0.1, 1, -0.2), 2, 2)
pd <- matrix(c('fixed', 'spring', 'fixed', 'friction'), 2, 2)
pd4 <- matrix(c('fixed', 'spring', 'fixed', 'friction'), 4, 4)

#------------------------------------------------------------------------------
# Check covariate conformability errors
#  Specifically, the number of covariates suggested by the values.exo matrix/matrices
#  is different from that implied by the covariates argument.

# No Error
dynamics <- prep.matrixDynamics(
	values.dyn=vd,
	params.dyn=pd,
	isContinuousTime=TRUE)

# Error
testthat::expect_error(
	prep.matrixDynamics(
		values.dyn=vd,
		params.dyn=pd,	isContinuousTime=TRUE,
		values.exo=matrix(1, 2, 1)),
	regexp="Mind your teaspoons and tablespoons.  The 'exo.values' argument says there are\n (1) covariates, but the 'covariates' arg says there are (0).",
	fixed=TRUE)

# No Error
dynamicsU <- prep.matrixDynamics(
	values.dyn=vd,
	params.dyn=pd,	isContinuousTime=TRUE,
	values.exo=matrix(1, 2, 1),
	covariates='u1')

# Error
testthat::expect_error(
	prep.matrixDynamics(
		values.dyn=vd,
		params.dyn=pd,	isContinuousTime=TRUE,
		values.exo=matrix(1, 2, 1),
		covariates=c('u1', 'u2')),
	regexp="Mind your teaspoons and tablespoons.  The 'exo.values' argument says there are\n (1) covariates, but the 'covariates' arg says there are (2).",
	fixed=TRUE)

# Walter Error
testthat::expect_error(
	prep.matrixDynamics(
		values.dyn=vd,
		params.dyn=pd4,	isContinuousTime=TRUE),
	regexp="'values' and 'params' are not all the same size.\nWalter Sobchak says you can't do that.",
	fixed=TRUE)

# Donny Error
testthat::expect_error(
	prep.matrixDynamics(
		values.dyn=vd,
		params.dyn=pd,	isContinuousTime=TRUE,
		values.exo=list(matrix(1, 2, 1), matrix(1, 2, 2)),
		covariates='u1'),
	regexp="Some of the 'values' list elements are not the same size as each other\nNot cool, Donny.",
	fixed=TRUE)

# Error
# covariates and exo.values imply different number of covariates
testthat::expect_error(
	prep.matrixDynamics(
		values.dyn=vd,
		params.dyn=pd,	isContinuousTime=TRUE,
		values.exo=list(matrix(1, 2, 2), matrix(1, 2, 2)),
		params.exo=list(matrix(0, 2, 2), matrix(0, 2, 2)),
		covariates='u1'),
	regexp="Mind your teaspoons and tablespoons.  The 'exo.values' argument says there are\n (2) covariates, but the 'covariates' arg says there are (1).",
	fixed=TRUE)

testthat::expect_error(
	prep.matrixDynamics(
		values.dyn=vd,
		params.dyn=pd,	isContinuousTime=TRUE,
		covariates='u1'),
	regexp="Mind your teaspoons and tablespoons.  The 'exo.values' argument says there are\n (0) covariates, but the 'covariates' arg says there are (1).",
	fixed=TRUE)

testthat::expect_error(
	prep.matrixDynamics(
		values.dyn=vd,
		params.dyn=pd,	isContinuousTime=TRUE,
		values.exo=list(matrix(1, 2, 2), matrix(1, 2, 2)),
		params.exo=list(matrix(0, 2, 2), matrix(0, 2, 2))),
	regexp="Mind your teaspoons and tablespoons.  The 'exo.values' argument says there are\n (2) covariates, but the 'covariates' arg says there are (0).",
	fixed=TRUE)


#------------------------------------------------------------------------------
# Check for friendly error when user hands wrong stuff to prep.formulaDynamics()

testthat::expect_error(
	prep.formulaDynamics(eta ~ phi*eta),
	regexp="'formula' argument is a formula but 'formula' should be a list of formulas.\nCan't nobody tell me nothin'",
	fixed=TRUE
)

testthat::expect_error(
	prep.formulaDynamics(matrix(1, 2, 2)),
	regexp="'formula' argument should be a list of formulas.\nCan't nobody tell me nothin'",
	fixed=TRUE
)


#------------------------------------------------------------------------------
# End
