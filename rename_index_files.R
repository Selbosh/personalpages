# Run this script before publishing, because University of Manchester's
# personal pages server defaults to "default.htm" rather than "index.html"
# for some reason.
filenames <- list.files('public_html', recursive = TRUE, full.names = TRUE)
filenames1 <- grep('public_html/.+index.html$', filenames, value = TRUE, perl = TRUE)
filenames2 <- gsub('index.html$', 'default.htm', filenames1)
file.rename(filenames1, filenames2)

# Replace the current zip archive with an updated one.
file.remove('public_html.zip')
zip(zipfile = 'public_html', files = dir('public_html', full.names = TRUE))
