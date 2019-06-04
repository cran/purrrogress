#! This file was automatically produced by the testextra package.
#! Changes will be overwritten.

context('tests extracted from file `apply.R`')
#line 85 "R/apply.R"
test_that('with_apply_progress', {#@testing
    val <- sapply( 1:5, with_progress( test_progress_status
                                     , label="{frac} items completed"
                                     , type="none")
                 , total=5
                 , title = "sapply"
                 , label = "\\d/5 items completed")
    expect_true(all(val))
})
