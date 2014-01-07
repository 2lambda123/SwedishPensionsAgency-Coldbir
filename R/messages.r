#' Log messages
#' 
#' Handlers for showing messages, warnings and errors.
#' These functions are useful as many of the log messages
#' are re-used in the code. `msg()` is used for ordinary messages,
#' `wrn()` for warnings and `err()` for throwing an error and
#' interrupting the code from further evaulation.
#' 
#' @param n message code. The number used must exist in table available in the code.
#' @param ... arguments passed on to `sprintf()`.
#' 
#' @examples
#' \dontrun{
#' msg(3, "foo")
#' }
#' 
#' @rdname messages
msg <- function(n, ...) {
  
  # Message codes are available in the table below;
  # some numbers in between have been removed since they aren't used anymore.
  str <- sprintf(switch(
    as.character(n),  # obs: convert to char since int otherwise refers to index
    "0"   = "Error message is not defined!",
    "1"   = "Config file updated, although `db$read_only` is set to TRUE",
    "2"   = "%s - writing failed; rollback! (%s)",
    "3"   = "%s - no such data base",
    "4"   = "%s : %s - no documantation for this variable",
    "6"   = "%s - file does not exist",
    "7"   = "%s - version of coldbir package and file format does not match",
    "8"   = "You're only allowed to read data, to change this use db$read_only <- F",
    "9"   = "%s - variable is NULL; nothing to write",
    "11"  = "%s - length of variable doesn't match the size of the other columns; nothing will be written",
    "13"  = "%s - data type is not supported",
    "14"  = "%s - writing failed; rollback! (%s)",
    "16"  = "input must be a two-column data frame"
  ), ...)
  
  if (is.null(str)) err(0)
  
  switch(
    as.character(match.call()[[1]]),  # name of calling function
    "msg" = message(str),
    "wrn" = warning(str),
    "err" = stop(str)
  )
}

#' @rdname messages
wrn <- msg

#' @rdname messages
err <- msg