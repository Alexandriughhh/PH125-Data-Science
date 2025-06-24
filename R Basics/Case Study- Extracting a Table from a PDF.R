library(dslabs)
data("research_funding_rates")
research_funding_rates 

library("pdftools")
temp_file <- tempfile()
url <- "https://www.pnas.org/action/downloadSupplement?doi=10.1073%2Fpnas.1510159112&file=pnas.201510159SI.pdf"
download.file(url, temp_file)
txt <- pdf_text(temp_file)
file.remove(temp_file)
