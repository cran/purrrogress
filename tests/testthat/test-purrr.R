#! This file was automatically produced by the testextra package.
#! Changes will be overwritten.

context('tests extracted from file `purrr.R`')
#line 23 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/purrr.R"
test_that('is_purrr_map_call', {#@testing
    vals <- purrr::map_lgl(1:2, function(x)
        is_purrr_map_call(sys.call(sys.parent(1)))
    )
    expect_true(all(vals))

    v2 <- sapply(1:2, function(x)
        is_purrr_map_call(sys.call(sys.parent(1)))
    )
    expect_false(any(v2))
})
#line 40 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/purrr.R"
test_that('is_purrr_frame', {#@testing
    vals <- purrr::map_lgl(1:2, function(x)
        is_purrr_frame(sys.frame(sys.parent(1)))
    )
    expect_true(all(vals))

    v2 <- sapply(1:2, function(x)
        is_purrr_frame(sys.frame(sys.parent(1)))
    )
    expect_false(any(v2))
})
#line 65 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/purrr.R"
test_that('in_purrr_map', {#@testing
    vals <- purrr::map_lgl(1:1, function(x){
        # which <- sys.parent(1):sys.nframe()
        # calls <- sys.calls()[which]
        # frames <- sys.frames()[which]
        # in_purrr_map(which, calls, frames) == sys.parent(1)
        in_purrr_map() == sys.parent(1)
    })
    expect_true(all(vals))

    v2 <- sapply(1:2, function(x)
        in_purrr_map( sys.parent(1):sys.nframe()) == sys.parent()
    )
    expect_false(any(v2))
})
#line 80 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/purrr.R"
test_that('in_purrr_map nested.', {#@testing in_purrr_map nested.
    purrr::map(1:1, function(x){
        parent <- sys.parent()
        inner.vals <- purrr::map_int(1:2, function(...)
            in_purrr_map()
        )
        expect_true(all(inner.vals > parent))

        me.val <- in_purrr_map()
        expect_equal(me.val, parent)
    })
})
#line 121 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/purrr.R"
test_that('with_purrr_progress', {#@testing
    purrr::map_lgl(1:5, with_progress(test_progress_status, type='none')
                  , 5
                  , "purrr::map(...)"
                  , "\\d+/\\d+ items completed"
                  , class = "R6 Progress Base Class"
                  )

    purrr::map_lgl(1:5, with_progress( test_progress_status, type='none'
                                     , total = 10
                                     , title = "Mapping progress"
                                     , label = "{elapsed.time}/{estimated.total.time} this will take forever"
                                     )
                  , total = 10
                  , "Mapping progress"
                  , "this will take forever"
                  , class = "R6 Progress Base Class"
                  )
})
