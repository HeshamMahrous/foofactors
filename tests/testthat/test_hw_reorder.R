context("Reorder with dplyr")

test_that("Case 1: The factor variable x is NULL",{
  expect_error(reorder(NULL, c(1,2), median),"is.factor(x) is not TRUE", fixed = TRUE)  
  expect_error(reorder(NA, c(1,2), median),"is.factor(x) is not TRUE", fixed = TRUE)  
})

test_that("Case 2: The value variable X is NULL/NA",{
  expect_error(reorder(as.factor(c("a", "b")), NULL, mean),"length(x) == length(X) is not TRUE", fixed = TRUE)  
  expect_error(reorder(as.factor(c("a", "b")), NA, mean),"length(x) == length(X) is not TRUE", fixed = TRUE)  
})

test_that("Case 3: The function FUN is NULL/NA",{
  expect_error(reorder(as.factor(c("a", "b")), c(1,2), NULL),"is.function(FUN) is not TRUE", fixed = TRUE)  
  expect_error(reorder(as.factor(c("a", "b")), c(1,2), NA),"is.function(FUN) is not TRUE", fixed = TRUE)  
})

test_that("Case 4: The length of variable x and X is different",{
  expect_error(reorder(as.factor(c("a", "b")), c(1,2,3,4), mean),"length(x) == length(X) is not TRUE", fixed = TRUE)  
  expect_error(reorder(as.factor(c("a", "b","c")), c(1,2), mean),"length(x) == length(X) is not TRUE", fixed = TRUE)  
})

test_that("Case 5: Checking for output with data without order",{
  test_factors <- as.factor(c("a","a","b","b","c","c","a","b","c","a","c","a"))
  test_vals <- seq(1,12)
  
  expected_output <- base::factor(c("a","a","b","b","c","c","a","b","c","a","c","a"), levels = c("c","a","b"))
  expected_scores <- c(6.40, 5.00, 7.75)
  dim(expected_scores) <- 3
  dimnames(expected_scores) <- list(c("a", "b", "c"))
  attr(expected_output, "scores") <- expected_scores 
  check_output <- reorder(test_factors, test_vals, mean)
  expect_equal(expected_output, check_output)
})

test_that("Case 6: Checking for output with data with order",{
  test_factors <- ordered(c("a","a","b","b","c","c","a","b","c","a","c","a"))
  test_vals <- seq(1,12)
  
  expected_output <- ordered(c("a","a","b","b","c","c","a","b","c","a","c","a"), levels = c("c","a","b"))
  expected_scores <- c(6.40, 5.00, 7.75)
  dim(expected_scores) <- 3
  dimnames(expected_scores) <- list(c("a", "b", "c"))
  attr(expected_output, "scores") <- expected_scores 
  check_output <- reorder(test_factors, test_vals, mean)
  expect_equal(expected_output, check_output)
})
