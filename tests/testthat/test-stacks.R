#! This file was automatically produced by the testextra package.
#! Changes will be overwritten.

context('tests extracted from file `stacks.R`')
#line 43 "R/stacks.R"
test_that('peek_progress', {#@testing
    expect_identical(get_progress_stack('test stack'), list())

    pb1 <- progress_bar(3, show=TRUE, type='none')
    push_progress(pb1, 'test stack')

    expect_identical(get_progress_stack('test stack'), list(pb1))
    expect_identical(peek_progress('test stack'), pb1)

    pb1$step()
    expect_equal(peek_progress('test stack')$current, 1L)

    pb2 <- progress_bar(5, title = "sub-progress", type='win')
    push_progress(pb2, 'test stack')

    expect_identical(get_progress_stack('test stack'), list(pb1, pb2))
    expect_identical(peek_progress('test stack'), pb2)

    pop_progress('test stack')

    expect_identical(get_progress_stack('test stack'), list(pb1))
    expect_identical(peek_progress('test stack'), pb1)

    pb1$step()

    pop_progress('test stack')

    expect_identical(get_progress_stack('test stack'), list())
    expect_error( peek_progress('test stack')
                , class = "purrrogress-error-empty progress stack" )

    expect_error( pop_progress('test stack')
                , class = "purrrogress-error-empty progress stack" )


    txt <- txtProgressBar()
    push_progress(txt, 'test stack')

    expect_identical(peek_progress('test stack'), txt)

})
