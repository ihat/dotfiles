if (interactive()) {
  suppressMessages(require(devtools))
  l <- function(pkg, ...) {
    pkg <- tolower(deparse(substitute(pkg)))
    load_all(pkg, ...)
  }
}

s <- base::summary;
h <- utils::head;
n <- base::names;

options("width"=161)     # wide display with multiple monitors
options("digits.secs"=3) # show sub-second time stamps

r <- getOption("repos")  # hard code the US repo for CRAN
r["CRAN"] <- "http://cran.us.r-project.org"
options(repos=r)
rm(r)

setHook(packageEvent("grDevices", "onLoad"),
        function(...) grDevices::X11.options(width=8, height=8,
                                             xpos=0, pointsize=10,
                                             type="nbcairo"))

options(prompt="R> ", digits=4, show.signif.stars=FALSE)
