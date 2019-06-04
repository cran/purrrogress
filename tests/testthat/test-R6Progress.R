#! This file was automatically produced by the testextra package.
#! Changes will be overwritten.

context('tests extracted from file `R6Progress.R`')
#line 147 "R/R6Progress.R"
test_that('R6_progress', {#@testing
    test <- R6_progress$new(100)

    expect_equal(test$title, "Progress")
    expect_equal(test$label, "0/100 items completed")

    expect_true(is.na(test$etr))
    expect_identical(test$init(), test)
    Sys.sleep(0.1)
    expect_true(is.na(test$etr))
    expect_equal(test$current, 0L)

    expect_identical(test$step(), test)
    expect_equal(test$current, 1L)
    expect_false(is.na(test$etr))


    expect_equal(test$percent, "1%")
    expect_null(test$term())

    words <- stringi::stri_rand_lipsum(1, FALSE) %>%
             stringi::stri_split(fixed = ' ') %>%
             unlist()
    i <- 1
    pb <-
        R6_progress$new( length(words)
                       , "Test Progress {current}/{total} ({estimated.time.remaining} remaining.)"
                       , "{elapsed.time}/{estimated.total.time} estimated.\n {word}"
                       , bindings = list(word = ~words[i])
                       , expose = 'i'
                       )

    expect_identical(pb$total, length(words))
    expect_identical(pb$current, 0L)
    expect_equal(pb$title, "Test Progress 0/" %<<<% length(words) %<<<% " (NA remaining.)")
    expect_equal(pb$label, "NA/NA estimated.\n" %<<<% words[[1]])
    expect_equal(pb$frac, "0/" %<<<% length(words))

    pb$step()
    Sys.sleep(1)
    et <- pb$elapsed.time
    expect_is(et, 'hms')
    expect_true(et >= 1)

    at <- pb$average.time
    expect_is(at, 'hms')
    expect_true(at >= 1)

    expect_error(pb$expose(i, overwrite = FALSE)
                , class = "purrrogress-error-already-exists")
    expect_warning(pb$expose(i, overwrite = NA)
                  , class = "purrrogress-warning-already-exists")
    expect_silent(pb$expose(i, overwrite = TRUE))

    pb$add_bindings(next_word = function()words[[pb$current+2]])


})
#line 297 "R/R6Progress.R"
test_that('R6_win_progress', {#@testing
    words <- stringi::stri_rand_lipsum(1, FALSE) %>%
             stringi::stri_split(fixed = ' ') %>%
             unlist()

    pb <-
        R6_win_progress$new( length(words)
                           , "Test Progress {current}/{total} ({estimated.time.remaining} remaining.)"
                           , "{elapsed.time}/{estimated.total.time} estimated.\n {word}"
                           , width = 600
                           , bindings = list(word = ~words[i])
                           )
    i <- 1

    expect_identical(pb$total, length(words))
    expect_identical(pb$current, 0L)
    expect_equal(pb$title, "Test Progress 0/" %<<<% length(words) %<<<% " (NA remaining.)")
    expect_equal(pb$label, "NA/NA estimated.\n" %<<<% words[[1]])
    expect_equal(pb$frac, "0/" %<<<% length(words))

    pb$init()
    pb$elapsed.time
})
