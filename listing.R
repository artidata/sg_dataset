library(jsonlite)
library(curl)
library(stringr)
library(data.table)

dir.create(str_c("processed_data/",today()))
dirOutput <- str_c("processed_data/",today(),"/")
#download and readlisting dataset

curl_download("https://data.gov.sg/dataset/dba9594b-fb5c-41c5-bb7c-92860ee31aeb/download/",
              str_c(dirOutput,"dataset-listing.zip"))
unzip(str_c(dirOutput,"dataset-listing.zip"),
      exdir = str_c(dirOutput,"dataset-listing"))
dtListing <- fread(str_c(dirOutput,
                         "dataset-listing/data-gov-sg-dataset-listing.csv"))

#navigate and select dataset of interest
dtListing

#setup before querying CKAN API
query <- "https://data.gov.sg/dataset/"
index <- 1140 #Master Plan 2014 Planning Area Boundary (Web) (SHP)
dtListing[index]
id <- dtListing[index,dataset_id]
name <- dtListing[index,dataset_name]
format <- dtListing[index,resource_format]

curl_download(str_c(query,id,"/download"),
              str_c(dirOutput,name,".zip"))

unzip(str_c(dirOutput,"dataset-listing.zip"),
      exdir = str_c(dirOutput,"dataset-listing"))



if(format == "CSV"){
  #downloading dataset
  curl_download(str_c(query,parameter,id),
                str_c(dirOutput,name,".JSON"))
  lsDataset <- fromJSON(str_c(dirOutput,name,".JSON"))
}
#unzip(str_c(dirOutput,name,".zip"),
#      exdir = str_c(dirOutput,name)
#      )
dtListing[,!c("description","resource_description")][resource_format=="SHP"]

'https://data.gov.sg/dataset/5589d1bc-d3bd-4d62-923d-7b59b4e822e2/download'
'https://data.gov.sg/dataset/0d1ace9a-baa2-46ed-b5e3-09b9dcdc60e1/download'
