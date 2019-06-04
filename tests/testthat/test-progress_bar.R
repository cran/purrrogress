#! This file was automatically produced by the testextra package.
#! Changes will be overwritten.

context('tests extracted from file `progress_bar.R`')
#line 48 "R/progress_bar.R"
test_that('infer_type', {#@testing
    expect_equal(infer_type('Windows', TRUE), 'win')
    expect_equal(infer_type('Windows', FALSE), 'none')
    expect_equal(infer_type('Linux', TRUE), 'txt')
    expect_equal(infer_type('FooBar', TRUE), 'txt')
    expect_equal(infer_type('FooBar', FALSE), 'none')
})
#line 79 "R/progress_bar.R"
test_that('resolve_type', {#@testing
    expect_identical(resolve_type('win'), R6_win_progress)
    expect_error(resolve_type('tk'))
    expect_identical(resolve_type('txt'), R6_txt_progress)
    expect_identical(resolve_type('bar'), R6_line_progress)
    expect_identical(resolve_type('line'), R6_line_progress)
    expect_identical(resolve_type('box'), R6_box_progress)
    expect_identical(resolve_type('none'), R6_progress)
    expect_warning( resolve_type('foobar')
                  , class = "purrrogress-warning-invalid progress type"
                  )
    expect_identical(suppress_warnings(resolve_type('none')
                                      , class = "purrrogress-warning-invalid progress type")
                    , R6_progress)

})
