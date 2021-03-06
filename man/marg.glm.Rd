% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/glm_marg.R
\name{marg.glm}
\alias{marg.glm}
\title{Predicted Margins for `glm` objects}
\usage{
\method{marg}{glm}(mod, var_interest,
  data = mod$data[names(mod$prior.weights), ],
  weights = mod$prior.weights, ...)
}
\arguments{
\item{mod}{model object, currently only support those of class \code{\link[stats]{glm}}
or \code{\link[AER]{ivreg}}}

\item{var_interest}{name of the variable of interest, must correspond to a
covariate in the model}

\item{data}{data.frame that margins should run over, defaults changes based
on class-specific method}

\item{weights}{numeric, vector of weights used to generate predicted levels,
defaults changes based on class-specific method. Must be equal to the number
of rows in \code{data}.}

\item{...}{additional parameters passed to \code{?marg}.}
}
\description{
Obtains predicted margins and standard errors
of those predictions from a fitted generalized linear model object.
}
\examples{
data(mtcars)
mod <- glm(vs ~ as.factor(gear) + mpg, data = mtcars, family = 'binomial')

# Get the level of the outcome variable at different values of `gear`
marg(mod, var_interest = 'gear', type = 'levels')
# Get the effect of `gear` on the outcome value, holding values of `mpg`
# constant
marg(mod, var_interest = 'gear', type = 'effects',
     at = list(mpg = c(15, 21)))

data(margex)
mod <- glm(outcome ~ as.factor(treatment) + distance,
       data = margex, family = 'binomial')
# Get the level of the outcome variable at different values of `treatment`
marg(mod, var_interest = 'treatment', type = 'levels', at = NULL)
# Get the effect of `treatment` on the outcome variable
marg(mod, var_interest = 'treatment', type = 'effects', at = NULL)
# Get the level of the outcome variable at different values of `distance`
marg(mod, var_interest = 'distance', type = 'levels',
          at = NULL, at_var_interest = c(10, 20, 30))

# Using a custom variance-covariance matrix for clustered standard errors
# (also requires custom degrees of freedom for T statistic with OLS model),
# clustering on the "arm" variable

data(margex)
data(cvcov)
# ?cvcov
v <- cvcov$ols$clust
d <- cvcov$ols$stata_dof
mod <- glm(outcome ~ treatment + distance,
           data = margex, family = 'binomial')
marg(mod, var_interest = 'treatment', type = 'levels',
          vcov_mat = v, dof = d)

# Using weights
data(margex)
mm <- glm(y ~ as.factor(treatment) + age, data = margex, family = 'gaussian',
          weights = distance)
z1 <- marg(mod = mm, var_interest = 'treatment', type = 'levels')[[1]]
z2 <- marg(mod = mm, var_interest = 'treatment', type = 'effects')[[1]]

}
