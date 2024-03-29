% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/freq_metrics.R
\name{relative_cover}
\alias{relative_cover}
\title{Calculate Relative Cover}
\usage{
relative_cover(
  x,
  key = "name",
  db,
  col = c("species", "family", "physiog"),
  cover_class = "percent_cover",
  allow_no_c = TRUE,
  allow_non_veg = TRUE,
  plot_id = NULL
)
}
\arguments{
\item{x}{A data frame containing a list of plant species. This data frame
must have one of the following columns: \code{name} or \code{acronym}. For cover-weighted or
relative functions, this data frame must also have a column called \code{cover} containing
cover values and ideally a column containing plot IDs.}

\item{key}{A character string representing the column that will be used to join
the input data frame \code{x} with the regional FQA database. If a value is not specified, the
default is \code{"name"}. \code{"name"} and \code{"acronym"} are the only acceptable
values for \code{key}.}

\item{db}{A character string representing the regional FQA database to use. See
\code{db_names} for a list of potential values and the \code{fqadata} R package
where the databases are hosted.}

\item{col}{A character string representing the categorical variable to calculate
the relative cover of. Can be set to "species", "family" or "physiog" (for
physiognomy).}

\item{cover_class}{a character string representing the cover classification used. Acceptable
cover classes are: \code{"percent_cover"}, \code{"carolina_veg_survey"}, \code{"braun-blanquet"},
\code{"daubenmire"}, and \code{"usfs_ecodata"}. \code{"percent_cover"} is the default.}

\item{allow_no_c}{Boolean (TRUE or FALSE). If TRUE, allow species that are found in the
regional FQA database but have not been assigned a C Values. If FALSE, omit species that have not
been assigned C Values.}

\item{allow_non_veg}{Boolean (TRUE or FALSE). If TRUE, allow input to contain un-vegetated
ground and un-vegetated water.}

\item{plot_id}{A character string representing the column in \code{x} that contains plot
identification values. \code{plot_id} is a required argument in \code{plot_summary}, where it acts
as a grouping variable. \code{plot_id} is optional but highly recommended for
cover-weighted functions and relative functions. If \code{plot_id} is set in a
cover-weighted function or a relative function, it only prevents duplicates
from occurring in the same plot. It does not act as a grouping variable.}
}
\value{
A data frame with categorical variables set by the col argument and
their relative cover.
}
\description{
\code{relative_cover} calculates the total cover per group of interest (species,
taxonomic family, or physiognomic group) divided by the total cover for all
observations, then multiplied by 100. If the regional database does not have
information on species family or physiognomy, the function will return a data
frame with a single NA category.
}
\examples{
transect <- data.frame(
acronym  = c("ABEESC", "ABIBAL", "AMMBRE", "ANTELE", "ABEESC", "ABIBAL", "AMMBRE"),
cover = c(50, 4, 20, 30, 40, 7, 60),
plot_id = c(1, 1, 1, 1, 2, 2, 2))

relative_cover(transect, key = "acronym", db = "michigan_2014", col = "species",
plot_id = "plot_id")

#can also include bare ground and unvegetated water
transect_unveg <- data.frame(acronym  = c("GROUND", "ABEESC", "ABIBAL", "AMMBRE",
"ANTELE", "WATER", "GROUND", "ABEESC", "ABIBAL", "AMMBRE"),
cover = c(60, 50, 4, 20, 30, 20, 20, 40, 7, 60),
plot_id = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2))

relative_cover(transect_unveg, key = "acronym", db = "michigan_2014",
col = "species", plot_id = "plot_id")
}
