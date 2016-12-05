#' @importFrom testit assert

#' @title Reorder Levels of a factor
#' @description A new version of reorder that uses desc from dplyr
#' @param x an atomic factor vector
#' @param X a vector of the same length as x, whose subset of values for each unique level of x 
#' determines the eventual order of that level.
#' @param FUN a function whose first argument is a vector and returns a scalar, to be applied to 
#' each subset of X determined by levels of x
#' @param ... optional extra arguments to be supplied to FUN
#' @param order a logical defining whether the output is ordered or not
#' @return A factor or an ordered vector, with the order of levels determined by FUN applied to X
#' grouped by x. The levels are sorted in descending order of the values returned by FUN.
#' @export
reorder <- function(x, X, FUN= mean, ..., order = is.ordered(x)){
  assert("x should be a factor", is.factor(x))
  assert("X and x are of the same length", length(x) == length(X))
  assert("FUN should be a function", is.function(FUN))
  assert("order should be logical", is.logical(order))
  
  scores <- tapply(X=X, INDEX = x, FUN = FUN, ...)
  new_factors <- c()
  
  tmp_sort_df <- data.frame(names = levels(x), scores = scores)
  tmp_sort_df <- dplyr::arrange(tmp_sort_df, dplyr::desc(tmp_sort_df$scores))
  new_names <- tmp_sort_df$names
  if(order){
    new_factors <- ordered(x, levels = new_names)
  }else{
    new_factors <- factor(x, levels = new_names)
  }
  attr(new_factors, "scores") <- scores
  return(new_factors)
}