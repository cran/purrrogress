#! This file was automatically produced by the testextra package.
#! Changes will be overwritten.

context('tests extracted from file `group_map.R`')
#line 44 "R/group_map.R"
test_that('with_progress_group_map', {#@testing
    if( requireNamespace('dplyr')
      & requireNamespace('tibble')
      & requireNamespace('datasets')
      ){

    x <- dplyr::group_by(datasets::iris, Species)
    test_group_map_progress <- function(df, key, ...){
        val <- test_progress_status( step = match(key$Species, unique(iris$Species)), ...)
        tibble::tibble(val)
    }

    val <- dplyr::group_map( dplyr::group_by(iris, Species)
                           , with_progress(test_group_map_progress, type="none")
                           , total=3
                           , title = ".dplyr::group_map. progress"
                           , label = "\\d/3 items completed")
    expect_true(all(val$val))

    val <- dplyr::group_map(x, with_progress(test_group_map_progress, type="none")
                           , total=3
                           , title = "group_map\\(x, test_group_map_progress, ...)"
                           , label = "\\d/3 items completed")
    expect_true(all(val$val))

    val <- dplyr::group_map(x, with_progress(function(...){
                                    test_group_map_progress(...)
                                }, type="none")
                           , total=3
                           , title = "group_map\\(x, ...)"
                           , label = "\\d/3 items completed")
    expect_true(all(val$val))

    delayedAssign('f', with_progress(test_group_map_progress, type="none"))
    val <- dplyr::group_map(x, f
                           , total=3
                           , title = "group_map\\(x, f, \\.\\.\\.\\)"
                           , label = "\\d/3 items completed")
    expect_true(all(val$val))
    }
})
