# Complete R script to combine PDFs from specific directory

# Install and load required package
if (!require(qpdf, quietly = TRUE)) {
  install.packages("qpdf")
  library(qpdf)
}

# Set the specific directory path
dir_path <- "C:/Users/M329279/Downloads/M3554_aCRF_check"

# Check if directory exists
if (!dir.exists(dir_path)) {
  stop("Directory does not exist: ", dir_path)
}

# Get all PDF files from the specified directory
pdf_files <- list.files(path = dir_path, pattern = "\\.pdf$", full.names = TRUE)

# Remove output file if it exists in the list
output_file <- file.path(dir_path, "combined_pdfs.pdf")
pdf_files <- pdf_files[pdf_files != output_file]

# Check if PDFs found
if (length(pdf_files) == 0) {
  stop("No PDF files found in directory: ", dir_path)
}

cat("Found", length(pdf_files), "PDF files:\n")
print(basename(pdf_files))

# Combine PDFs
cat("\nCombining PDFs...\n")
qpdf::pdf_combine(input = pdf_files, output = output_file)

cat("Success! Combined PDF saved as:", output_file, "\n")
