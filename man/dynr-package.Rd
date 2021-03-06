\name{dynr-package}
\alias{dynr-package}
\alias{dynr}
\docType{package}
\title{
\packageTitle{dynr}
}
\description{
\packageDescription{dynr}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{dynr}
\packageIndices{dynr}
Because the \pkg{dynr} package compiles C code in response to user input, more setup is required for the \pkg{dynr} package than for many others. We acknowledge that this additional setup can be bothersome, but we believe the ease of use for the rest of the package and the wide variety of models it is possible to fit with it will compensate for this initial burden.  Hopefully you will agree!

See the installation vignette referenced in the Examples section below for installation instructions.

The naming convention for \pkg{dynr} exploits the pronunciation of the package name, \pkg{dynr}, pronounced the same as ``dinner''. That is, the names of functions and methods are specifically designed to relate to things done surrounding dinner, such as gathering ingredients (e.g., the data), preparing recipes, cooking, and serving the finished product. The general procedure for using the \pkg{dynr} package can be summarized in five steps as below. 
\enumerate{
    \item Data are prepared using with the \code{dynr.data()} function. 
    \item \emph{Recipes} are prepared. To each part of a model there is a corresponding \code{prep.*()} recipe function. Examples of such \code{prep.*()} functions include: \code{prep.measurement()}, \code{prep.matrixDynamics()}, \code{prep.formulaDynamics()}, \code{prep.initial()}, \code{prep.noise()}, and \code{prep.regimes()}.
    \item The function \code{dynr.model()} mixes the data and recipes together into a model object of class \code{dynrModel}.
    \item The model is cooked with \code{dynr.cook()}.
    \item Results from model fitting and related estimation are served using functions such as \code{summary()}, \code{plot()}, \code{dynr.ggplot()} (or its alias \code{autoplot()}), \code{plotFormula()}, and \code{printex()}.
}
}
\author{
\packageAuthor{dynr}

Maintainer: \packageMaintainer{dynr}
}
\references{
\insertRef{Chow13a}{dynr}

\insertRef{Chow13b}{dynr}

\insertRef{Ou17b}{dynr}

\insertRef{Yang10a}{dynr}

\insertRef{Chow17a}{dynr}
}
\note{
State-space modeling, 
dynamic model, 
differential equation, 
regime switching, 
nonlinear
}

\concept{State-space modeling}
\concept{dynamic model}
\concept{differential equation}
\concept{regime switching}
\concept{nonlinear}
\concept{Time series}

\seealso{
For other annotated tutorials using the \pkg{dynr} package see
\url{
https://quantdev.ssri.psu.edu/resources/what%E2%80%99s-dynr-package-linear-and-nonlinear-dynamic-modeling-r
}
}

\examples{
# For installation instructions see the package vignette below
\dontrun{
vignette(package='dynr', 'InstallationForUsers')
}
# This should open a pdf/html file to guide you through proper
#  installation and configuration.

#For illustrations of the functions in dynr, check out some of the demo examples in:
\dontrun{
demo(package='dynr')
}

#For example, to run the demo 'LinearSDE' type
# the following without the comment character (#) in front of it.
\dontrun{
demo('LinearSDE', package='dynr')
}
}
