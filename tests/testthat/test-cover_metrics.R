#-------------------------------------------------------------------------------
#testing cover_mean_c()

test_that("cover_mean_c() works in perfect setting", {
  expect_equal(cover_mean_c(x = quadrat, key = "acronym", db = "michigan_2014",
                            native = FALSE, allow_duplicates = FALSE),
               4.92307692)
  expect_equal(cover_mean_c(x = transect, key = "acronym", db = "michigan_2014",
                            native = FALSE, allow_duplicates = TRUE),
               5.94605809)
})

#-------------------------------------------------------------------------------
#testing cover_FQI()

test_that("cover_FQI() works in perfect setting", {
  expect_equal(cover_FQI(x = transect, key = "acronym", db = "michigan_2014", native = FALSE,
                         allow_duplicates = TRUE),
               11.8921162)
})

#-------------------------------------------------------------------------------
#testing transect_summary()

test_that("transect_summary() works in perfect setting", {
  expect_equal(transect_summary(x = transect, key = "acronym", db = "michigan_2014"),

               data.frame(metrics = c("Total Species Richness",
                                      "Native Species Richness",
                                      "Introduced Species Richness",
                                      "% of Species with no C Value",
                                      "% of Species with 0 C Value",
                                      "% of Species with 1-3 C Value",
                                      "% of Species with 4-6 C Value",
                                      "% of Species with 7-10 C Value",
                                      "Mean C",
                                      "Native Mean C",
                                      "Cover-Weighted Mean C",
                                      "Cover-Weighted Native Mean C",
                                      "Total FQI",
                                      "Native FQI",
                                      "Cover-Weighted FQI",
                                      "Cover-Weighted Native FQI",
                                      "Adjusted FQI",
                                      "Mean Wetness",
                                      "Native Mean Wetness",
                                      "% Hydrophytes"),
                          values = c(4,
                                     3,
                                     1,
                                     0,
                                     25.0,
                                     25.0,
                                     0.0,
                                     50.0,
                                     5.75,
                                     7.66666667,
                                     5.94605809,
                                     9.49006623,
                                     11.5,
                                     13.27905619,
                                     11.892116,
                                     16.437277,
                                     66.395281,
                                     1.75,
                                     0.6666667,
                                     14.2857143
                          )))
})

test_that("transect_summary() works in with synonyms (diff names, same ID)", {
  expect_equal(transect_summary(x = same_id, key = "name", db = "wyoming_2017"),

               data.frame(metrics = c("Total Species Richness",
                                      "Native Species Richness",
                                      "Introduced Species Richness",
                                      "% of Species with no C Value",
                                      "% of Species with 0 C Value",
                                      "% of Species with 1-3 C Value",
                                      "% of Species with 4-6 C Value",
                                      "% of Species with 7-10 C Value",
                                      "Mean C",
                                      "Native Mean C",
                                      "Cover-Weighted Mean C",
                                      "Cover-Weighted Native Mean C",
                                      "Total FQI",
                                      "Native FQI",
                                      "Cover-Weighted FQI",
                                      "Cover-Weighted Native FQI",
                                      "Adjusted FQI",
                                      "Mean Wetness",
                                      "Native Mean Wetness",
                                      "% Hydrophytes"),
                          values = c(species_richness(same_id, "name", "wyoming_2017"),
                                     species_richness(same_id, "name", "wyoming_2017", native = TRUE),
                                     0, #introduced
                                     0, #no c score
                                     0, #0 score
                                     0, #1-3 score
                                     100, #4-6 score
                                     0, #7-10 score
                                     mean_c(same_id, "name", "wyoming_2017"),
                                     mean_c(same_id, "name", "wyoming_2017", native = TRUE),
                                     cover_mean_c(same_id, "name", "wyoming_2017", allow_duplicates = T),
                                     cover_mean_c(same_id, "name", "wyoming_2017", native = TRUE, allow_duplicates =T),
                                     FQI(same_id, "name", "wyoming_2017"),
                                     FQI(same_id, "name", "wyoming_2017", native = TRUE),
                                     cover_FQI(same_id, "name", "wyoming_2017", allow_duplicates = T),
                                     cover_FQI(same_id, "name", "wyoming_2017", allow_duplicates = T, native = TRUE),
                                     adjusted_FQI(same_id, "name", "wyoming_2017"),
                                     mean_w(same_id, "name", "wyoming_2017"),
                                     mean_w(same_id, "name", "wyoming_2017", native = TRUE),
                                     0 #hydro
                          )))
})

test_that("transect_summary() works in with duplicates", {
  expect_equal(transect_summary(accepted_dup, "acronym", "michigan_2014"),

               data.frame(metrics = c("Total Species Richness",
                                      "Native Species Richness",
                                      "Introduced Species Richness",
                                      "% of Species with no C Value",
                                      "% of Species with 0 C Value",
                                      "% of Species with 1-3 C Value",
                                      "% of Species with 4-6 C Value",
                                      "% of Species with 7-10 C Value",
                                      "Mean C",
                                      "Native Mean C",
                                      "Cover-Weighted Mean C",
                                      "Cover-Weighted Native Mean C",
                                      "Total FQI",
                                      "Native FQI",
                                      "Cover-Weighted FQI",
                                      "Cover-Weighted Native FQI",
                                      "Adjusted FQI",
                                      "Mean Wetness",
                                      "Native Mean Wetness",
                                      "% Hydrophytes"),
                          values = c(species_richness(accepted_dup, "acronym", "michigan_2014"),
                                     species_richness(accepted_dup, "acronym", "michigan_2014", native = TRUE),
                                     1, #introduced
                                     0, #no c score
                                     50.0, #0 score
                                     50.0, #1-3 score
                                     0, #4-6 score
                                     0, #7-10 score
                                     mean_c(accepted_dup, "acronym", "michigan_2014"),
                                     mean_c(accepted_dup, "acronym", "michigan_2014", native = TRUE),
                                     cover_mean_c(accepted_dup, "acronym", "michigan_2014", allow_duplicates = T),
                                     cover_mean_c(accepted_dup, "acronym", "michigan_2014", native = TRUE, allow_duplicates = T),
                                     FQI(accepted_dup, "acronym", "michigan_2014"),
                                     FQI(accepted_dup, "acronym", "michigan_2014", native = TRUE),
                                     cover_FQI(accepted_dup, "acronym", "michigan_2014", allow_duplicates = T),
                                     cover_FQI(accepted_dup, "acronym", "michigan_2014", allow_duplicates = T, native = TRUE),
                                     adjusted_FQI(accepted_dup, "acronym", "michigan_2014"),
                                     mean_w(accepted_dup, "acronym", "michigan_2014"),
                                     mean_w(accepted_dup, "acronym", "michigan_2014", native = TRUE),
                                     0 #hydro
                          )))
})

test_that("transect_summary() works in with no c score", {
  expect_equal(transect_summary(no_c_test, "name", "montana_2017"),

               data.frame(metrics = c("Total Species Richness",
                                      "Native Species Richness",
                                      "Introduced Species Richness",
                                      "% of Species with no C Value",
                                      "% of Species with 0 C Value",
                                      "% of Species with 1-3 C Value",
                                      "% of Species with 4-6 C Value",
                                      "% of Species with 7-10 C Value",
                                      "Mean C",
                                      "Native Mean C",
                                      "Cover-Weighted Mean C",
                                      "Cover-Weighted Native Mean C",
                                      "Total FQI",
                                      "Native FQI",
                                      "Cover-Weighted FQI",
                                      "Cover-Weighted Native FQI",
                                      "Adjusted FQI",
                                      "Mean Wetness",
                                      "Native Mean Wetness",
                                      "% Hydrophytes"),
                          values = c(species_richness(no_c_test, "name", "montana_2017", allow_no_c = T),
                                     species_richness(no_c_test, "name", "montana_2017", native = TRUE, allow_no_c = T),
                                     1, #introduced
                                     50.00, #no c score
                                     0.0, #0 score
                                     25.0, #1-3 score
                                     25.0, #4-6 score
                                     0, #7-10 score
                                     mean_c(no_c_test, "name", "montana_2017"),
                                     mean_c(no_c_test, "name", "montana_2017", native = TRUE),
                                     cover_mean_c(no_c_test, "name", "montana_2017", allow_duplicates = T),
                                     cover_mean_c(no_c_test, "name", "montana_2017", native = TRUE, allow_duplicates = T),
                                     FQI(no_c_test, "name", "montana_2017"),
                                     FQI(no_c_test, "name", "montana_2017", native = TRUE),
                                     cover_FQI(no_c_test, "name", "montana_2017", allow_duplicates = T),
                                     cover_FQI(no_c_test, "name", "montana_2017", allow_duplicates = T, native = TRUE),
                                     adjusted_FQI(no_c_test, "name", "montana_2017"),
                                     mean_w(no_c_test, "name", "montana_2017", allow_no_c = T),
                                     mean_w(no_c_test, "name", "montana_2017", native = TRUE, allow_no_c = T),
                                     NA #hydro
                          )))
})


#-------------------------------------------------------------------------------
#testing plot_summary()

test_that("plot_summary() works without bare ground", {
  expect_equal(plot_summary(transect, key = "acronym", db = "michigan_2014",
                            cover_class = "percent_cover", plot_id = "quad_id"),

               data.frame(quad_id = c(1,2),
                          species_richness = c(4,3),
                          native_species_richness = c(3,2),
                          mean_wetness = c(1.75, 3.33333333),
                          mean_c = c(5.750000, 4.3333333),
                          native_mean_c = c(7.6666667, 6.5),
                          cover_mean_c = c(4.92307692, 5.80373832),
                          FQI = c(11.5, 7.5055535),
                          native_FQI = c(13.2790562, 9.1923882),
                          cover_FQI = c(9.8461538, 10.0523696 ),
                          native_cover_FQI = c(16.42240766, 13.10786003),
                          adjusted_FQI = c(66.3952810, 53.0722778),
                          percent_ground_cover = c(NA_real_, NA_real_),
                          percent_water_cover = c(NA_real_, NA_real_)))

  expect_error(plot_summary(transect, key = "acronym", db = "michigan_2014",
                            cover_class = "percent_cover", plot_id = "quad_idd"),
               "'plot_id' must be the name of a column in x.")
})

test_that("plot_summary() works with bare ground, water, and duplicates in same plot", {
  expect_equal(plot_summary(transect_dup, key = "acronym", db = "michigan_2014",
                            cover_class = "percent_cover", plot_id = "quad_id"),

               data.frame(quad_id = c(1,2),
                          species_richness = c(4,3),
                          native_species_richness = c(3,2),
                          mean_wetness = c(1.75, 3.33333333),
                          mean_c = c(5.750000, 4.3333333),
                          native_mean_c = c(7.6666667, 6.5),
                          cover_mean_c = c(4.92307692, 5.80373832),
                          FQI = c(11.5, 7.5055535),
                          native_FQI = c(13.2790562, 9.1923882),
                          cover_FQI = c(9.8461538, 10.0523696 ),
                          native_cover_FQI = c(16.42240766, 13.10786003),
                          adjusted_FQI = c(66.3952810, 53.0722778),
                          percent_ground_cover = c(100, 20),
                          percent_water_cover = c(NA_real_, 20)))

  expect_message(plot_summary(transect_dup, key = "acronym", db = "michigan_2014",
                            cover_class = "percent_cover", plot_id = "quad_id"),
               "Duplicate entries detected in the same plot. Duplicates in the same plot will be counted once. Cover values of duplicate species will be added together.")
})


