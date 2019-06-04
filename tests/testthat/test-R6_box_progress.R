#! This file was automatically produced by the testextra package.
#! Changes will be overwritten.

context('tests extracted from file `R6_box_progress.R`')
#line 92 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/R6_box_progress.R"
test_that('make_txt_progress_bar', {#@testing
    val <- make_txt_progress_bar(20, 1/3, basic.charset)
    expect_equal(val, "|======            |")

    val <- make_txt_progress_bar(20, 1/2, basic.charset)
    expect_equal(val, "|=========         |")

    val <- make_txt_progress_bar(20, 0, basic.charset)
    expect_equal(val, "|                  |")

    val <- make_txt_progress_bar(20, 1, basic.charset)
    expect_equal(val, "|==================|")
})
#line 249 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/R6_box_progress.R"
test_that('R6_txt_progress', {#@testing
    pb <- R6_txt_progress$new( 1000, title = "Test text progress"
                             , label = "{fwfrac} {bar}({percent}) {etr} remaining"
                             , width = 50
                             )

    expect_equal(pb$fwfrac, "   0/1000")
    expect_match(pb$bar, "\\| +\\|")
    expect_equal(pb$title, "Test text progress")
    expect_equal( pb$label
                , "   0/1000 |             |(0%) NA remaining"
                )
    expect_output( pb$step(999)
                 , " 999/1000 |=+|\\(99%\\) 00:00:00 remaining"
                 )
    expect_output( pb$step()
                 , "1000/1000 |=+|\\(100%\\) 00:00:00 remaining\n"
                 )
})
#line 290 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/R6_box_progress.R"
test_that('line.charset', {#@testing
    val <- make_txt_progress_bar(23, 1/3, line.charset)
    expect_equal(nchar(val), 23)

    get_char(8.3, line.charset$start)

    expected <- paste0('\u2523'
                      , strrep('\u2501', floor(23/3-1))
                      , '\u2578' #< heavy left i.e. >= 50% of block
                      , strrep(' ', 23-3-6)
                      , '\u2502'
                      )
    expect_equal(val, expected)

    val <- make_txt_progress_bar(23, 1, line.charset)
    expect_equal(nchar(val), 23)
    expected <- paste0('\u2523'
                      , strrep('\u2501', 21)
                      , '\u252B'
                      )
    expect_equal(val, expected)
})
#line 319 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/R6_box_progress.R"
test_that('R6_line_progress', {#@testing
    pb <- R6_line_progress$new( 80, title = "Test line text progress"
                              , label = "{fwfrac}{bar}({percent}) {etr} remaining"
                              , width = 50
                              )

    expect_equal(pb$fwfrac, " 0/80")
    expect_equal(pb$title, "Test line text progress")
    expect_true(pb$bar=="\u250A                  \u2502")
    expect_output(pb$init(), " 0/80(.*)\\(0%\\) NA remaining")

    expect_output( pb$step(), regexp = ".* 1/80(.*)\\(1%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2502                  \u2502")

    expect_output( pb$step(), regexp = ".* 2/80(.*)\\(2%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2503                  \u2502")

    expect_output( pb$step(), regexp = ".* 3/80(.*)\\(3%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2520                  \u2502")

    expect_output( pb$step(), regexp = ".* 4/80(.*)\\(5%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2523                  \u2502")

    expect_output( pb$step(), regexp = ".* 5/80(.*)\\(6%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2523\u2574                 \u2502")

    expect_output( pb$step(), regexp = ".* 6/80(.*)\\(7%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2523\u2578                 \u2502")

    expect_output( pb$step(), regexp = ".* 7/80(.*)\\(8%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2523\u257E                 \u2502")

    expect_output( pb$step(), regexp = ".* 8/80(.*)\\(10%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2523\u2501                 \u2502")

    expect_output( pb$step(), regexp = ".* 9/80(.*)\\(11%\\) ([0-9:]{8}) remaining")
    expect_true(pb$bar=="\u2523\u2501\u2574                \u2502")

    expect_output(pb$step(67))
    expect_true(pb$bar==paste0("\u2523", strrep("\u2501", 18), "\u2502"))

    expect_output(pb$step())
    expect_true(pb$bar==paste0("\u2523", strrep("\u2501", 18), "\u2524"))

    expect_output(pb$step())
    expect_true(pb$bar==paste0("\u2523", strrep("\u2501", 18), "\u2525"))

    expect_output(pb$step())
    expect_true(pb$bar==paste0("\u2523", strrep("\u2501", 18), "\u252B"))
})
#line 381 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/R6_box_progress.R"
test_that('block.charset', {#@testing
    val <- make_txt_progress_bar(10, 9/80, block.charset)
    expect_equal(nchar(val), 10)
    expect_equal( val, "\u2588\u258F        ")
    expect_equal( make_txt_progress_bar(10, 12/80, block.charset)
                , "\u2588\u258C        ")
})
#line 395 "C:/Users/u0092104/Box Sync/Projects/Personal/purrrogress/R/R6_box_progress.R"
test_that('R6_box_progress', {#@testing
    pb <- R6_box_progress$new( 160, title = "Test block box progress"
                               , label = "{fwfrac}{bar}({percent}) {etr} remaining"
                               , width = 52
                               )

    expect_equal(pb$fwfrac, "  0/160")
    expect_match(pb$bar, " {20}")
    expect_equal(pb$title, "Test block box progress")
    expect_match( pb$label, "  0/160 {20}\\(0%\\) NA remaining")
    expect_output(pb$init(), "  0/160 {20}\\(0%\\) NA remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  1/160(\u258F) {19}\\(0%\\) \\d\\d:\\d\\d:\\d\\d remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  2/160(\u258E) {19}\\(1%\\) \\d\\d:\\d\\d:\\d\\d remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  3/160(\u258D) {19}\\(1%\\) \\d\\d:\\d\\d:\\d\\d remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  4/160(\u258C) {19}\\(2%\\) \\d\\d:\\d\\d:\\d\\d remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  5/160(\u258B) {19}\\(3%\\) \\d\\d:\\d\\d:\\d\\d remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  6/160(\u258A) {19}\\(3%\\) \\d\\d:\\d\\d:\\d\\d remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  7/160(\u2589) {19}\\(4%\\) \\d\\d:\\d\\d:\\d\\d remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  8/160(\u2588) {19}\\(5%\\) \\d\\d:\\d\\d:\\d\\d remaining")

    expect_output( pb$step())
    expect_match(pb$label, regexp = "  9/160(\u2588\u258F) {18}\\(5%\\) \\d\\d:\\d\\d:\\d\\d remaining")
})
