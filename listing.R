library(jsonlite)
library(curl)
library(stringr)
library(data.table)

#download and readlisting dataset
curl_download("https://data.gov.sg/dataset/dba9594b-fb5c-41c5-bb7c-92860ee31aeb/download/",
              "processed_data/dataset-listing.zip")
unzip("processed_data/dataset-listing.zip",exdir ="processed_data/dataset-listing")
dtListing <- fread("processed_data/dataset-listing/data-gov-sg-dataset-listing.csv")

#setup before querying CKAN API
query <- "https://data.gov.sg/api/action/datastore_search?"
parameter <- "resource_id="
dirOutput <- "processed_data/"

#navigate and select dataset of interest
dtListing

#query for downloading dataset
index <- 5
dtListing[index]
id <- dtListing[index,resource_id]
name <- dtListing[index,resource_name]
format <- dtListing[index,resource_format]

if(format == "CSV"){
  #downloading dataset
  curl_download(str_c(query,parameter,id),
                str_c(dirOutput,name,".JSON"))
  lsDataset <- fromJSON(str_c(dirOutput,name,".JSON"))
}
#unzip(str_c(dirOutput,name,".zip"),
#      exdir = str_c(dirOutput,name)
#      )
