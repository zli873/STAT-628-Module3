library(dplyr)
library(ggradar)


# AB ----------------------------------------------------------------------

AB_bars <- bars_business[bars_business$state == "AB", ]
AB_total <- length(AB_bars[, 1])
AB$topic_1_rank <- (rank(AB$topic_1) + 34) / AB_total * 100
AB$topic_2_rank <- (rank(AB$topic_2) + 34) / AB_total * 100
AB$topic_3_rank <- (rank(AB$topic_3) + 34) / AB_total * 100
AB$topic_4_rank <- (rank(AB$topic_4) + 34) / AB_total * 100
AB$topic_5_rank <- (rank(AB$topic_5) + 34) / AB_total * 100

zipdata_AB <- AB_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

AB_1 <- bars_business[bars_business$state == "AB", c(2, 3)]
zipdata2 <- merge(AB_1, AB, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / AB_total * 100
zipdata2 <- zipdata2[, c(1, 8, 9 , 10, 11, 12)]
zipdata_AB <- merge(zipdata_AB, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(AB)
rm(AB_1)
rm(AB_bars)
rm(AB_total)

# AZ ----------------------------------------------------------------------

AZ_bars <- bars_business[bars_business$state == "AZ", ]
AZ_total <- length(AZ_bars[, 1])
AZ$topic_1_rank <- (rank(AZ$topic_1) + 55) / AZ_total * 100
AZ$topic_2_rank <- (rank(AZ$topic_2) + 55) / AZ_total * 100
AZ$topic_3_rank <- (rank(AZ$topic_3) + 55) / AZ_total * 100
AZ$topic_4_rank <- (rank(AZ$topic_4) + 55) / AZ_total * 100
AZ$topic_5_rank <- (rank(AZ$topic_5) + 55) / AZ_total * 100

zipdata_AZ <- AZ_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

AZ_1 <- bars_business[bars_business$state == "AZ", c(2, 3)]
zipdata2 <- merge(AZ_1, AZ, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / AZ_total * 100
zipdata2 <- zipdata2[, c(1, 8, 9 , 10, 11, 12)]
zipdata_AZ <- merge(zipdata_AZ, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(AZ)
rm(AZ_1)
rm(AZ_bars)
rm(AZ_total)

# IL ----------------------------------------------------------------------

IL_bars <- bars_business[bars_business$state == "IL", ]
IL_total <- length(IL_bars[, 1])
IL$topic_1_rank <- (rank(IL$topic_1) + 11) / IL_total * 100
IL$topic_2_rank <- (rank(IL$topic_2) + 11) / IL_total * 100
IL$topic_3_rank <- (rank(IL$topic_3) + 11) / IL_total * 100
IL$topic_4_rank <- (rank(IL$topic_4) + 11) / IL_total * 100

zipdata_IL <- IL_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

IL_1 <- bars_business[bars_business$state == "IL", c(2, 3)]
zipdata2 <- merge(IL_1, IL, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / IL_total * 100
zipdata2 <- zipdata2[, c(1, 7, 8, 9, 10)]
zipdata_IL <- merge(zipdata_IL, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(IL)
rm(IL_1)
rm(IL_bars)
rm(IL_total)

# NC ----------------------------------------------------------------------

NC_bars <- bars_business[bars_business$state == "NC", ]
NC_total <- length(NC_bars[, 1])
NC$topic_1_rank <- (rank(NC$topic_1) + 53) / NC_total * 100
NC$topic_2_rank <- (rank(NC$topic_2) + 53) / NC_total * 100
NC$topic_3_rank <- (rank(NC$topic_3) + 53) / NC_total * 100
NC$topic_4_rank <- (rank(NC$topic_4) + 53) / NC_total * 100


zipdata_NC <- NC_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

NC_1 <- bars_business[bars_business$state == "NC", c(2, 3)]
zipdata2 <- merge(NC_1, NC, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / NC_total * 100
zipdata2 <- zipdata2[, c(1, 7, 8, 9, 10)]
zipdata_NC <- merge(zipdata_NC, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(NC)
rm(NC_1)
rm(NC_bars)
rm(NC_total)

# NV ----------------------------------------------------------------------

NV_bars <- bars_business[bars_business$state == "NV", ]
NV_total <- length(NV_bars[, 1])
NV$topic_1_rank <- (rank(NV$topic_1) + 80) / NV_total * 100
NV$topic_2_rank <- (rank(NV$topic_2) + 80) / NV_total * 100
NV$topic_3_rank <- (rank(NV$topic_3) + 80) / NV_total * 100
NV$topic_4_rank <- (rank(NV$topic_4) + 80) / NV_total * 100
NV$topic_5_rank <- (rank(NV$topic_5) + 80) / NV_total * 100

zipdata_NV <- NV_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

NV_1 <- bars_business[bars_business$state == "NV", c(2, 3)]
zipdata2 <- merge(NV_1, NV, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / NV_total * 100
zipdata2 <- zipdata2[, c(1, 8, 9, 10, 11, 12)]
zipdata_NV <- merge(zipdata_NV, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(NV)
rm(NV_1)
rm(NV_bars)
rm(NV_total)

# OH ----------------------------------------------------------------------

OH_bars <- bars_business[bars_business$state == "OH", ]
OH_total <- length(OH_bars[, 1])
OH$topic_1_rank <- (rank(OH$topic_1) + 101) / OH_total * 100
OH$topic_2_rank <- (rank(OH$topic_2) + 101) / OH_total * 100
OH$topic_3_rank <- (rank(OH$topic_3) + 101) / OH_total * 100
OH$topic_4_rank <- (rank(OH$topic_4) + 101) / OH_total * 100


zipdata_OH <- OH_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

OH_1 <- bars_business[bars_business$state == "OH", c(2, 3)]
zipdata2 <- merge(OH_1, OH, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / OH_total * 100
zipdata2 <- zipdata2[, c(1, 7, 8, 9, 10)]
zipdata_OH <- merge(zipdata_OH, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(OH)
rm(OH_1)
rm(OH_bars)
rm(OH_total)

# ON ----------------------------------------------------------------------

ON_bars <- bars_business[bars_business$state == "ON", ]
ON_total <- length(ON_bars[, 1])
ON$topic_1_rank <- (rank(ON$topic_1) + 144) / ON_total * 100
ON$topic_2_rank <- (rank(ON$topic_2) + 144) / ON_total * 100
ON$topic_3_rank <- (rank(ON$topic_3) + 144) / ON_total * 100
ON$topic_4_rank <- (rank(ON$topic_4) + 144) / ON_total * 100
ON$topic_5_rank <- (rank(ON$topic_5) + 144) / ON_total * 100

zipdata_ON <- ON_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

ON_1 <- bars_business[bars_business$state == "ON", c(2, 3)]
zipdata2 <- merge(ON_1, ON, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / ON_total * 100
zipdata2 <- zipdata2[, c(1, 8, 9, 10, 11, 12)]
zipdata_ON <- merge(zipdata_ON, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(ON)
rm(ON_1)
rm(ON_bars)
rm(ON_total)


# PA ----------------------------------------------------------------------

PA_bars <- bars_business[bars_business$state == "PA", ]
PA_total <- length(PA_bars[, 1])
PA$topic_1_rank <- (rank(PA$topic_1) + 76) / PA_total * 100
PA$topic_2_rank <- (rank(PA$topic_2) + 76) / PA_total * 100
PA$topic_3_rank <- (rank(PA$topic_3) + 76) / PA_total * 100
PA$topic_4_rank <- (rank(PA$topic_4) + 76) / PA_total * 100


zipdata_PA <- PA_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

PA_1 <- bars_business[bars_business$state == "PA", c(2, 3)]
zipdata2 <- merge(PA_1, PA, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / PA_total * 100
zipdata2 <- zipdata2[, c(1, 7, 8, 9, 10)]
zipdata_PA <- merge(zipdata_PA, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(PA)
rm(PA_1)
rm(PA_bars)
rm(PA_total)

# QC ----------------------------------------------------------------------

QC_bars <- bars_business[bars_business$state == "QC", ]
QC_total <- length(QC_bars[, 1])
QC$topic_1_rank <- (rank(QC$topic_1) + 154) / QC_total * 100
QC$topic_2_rank <- (rank(QC$topic_2) + 154) / QC_total * 100
QC$topic_3_rank <- (rank(QC$topic_3) + 154) / QC_total * 100



zipdata_QC <- QC_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

QC_1 <- bars_business[bars_business$state == "QC", c(2, 3)]
zipdata2 <- merge(QC_1, QC, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / QC_total * 100
zipdata2 <- zipdata2[, c(1, 6, 7, 8)]
zipdata_QC <- merge(zipdata_QC, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(QC)
rm(QC_1)
rm(QC_bars)
rm(QC_total)


# SC ----------------------------------------------------------------------

SC_bars <- bars_business[bars_business$state == "SC", ]
SC_total <- length(SC_bars[, 1])
SC$topic_1_rank <- (rank(SC$topic_1) + 2) / SC_total * 100
SC$topic_2_rank <- (rank(SC$topic_2) + 2) / SC_total * 100
SC$topic_3_rank <- (rank(SC$topic_3) + 2) / SC_total * 100
SC$topic_4_rank <- (rank(SC$topic_4) + 2) / SC_total * 100
SC$topic_5_rank <- (rank(SC$topic_5) + 2) / SC_total * 100


zipdata_SC <- SC_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

SC_1 <- bars_business[bars_business$state == "SC", c(2, 3)]
zipdata2 <- merge(SC_1, SC, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / SC_total * 100
zipdata2 <- zipdata2[, c(1,  8, 9, 10, 11, 12)]
zipdata_SC <- merge(zipdata_SC, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(SC)
rm(SC_1)
rm(SC_bars)
rm(SC_total)

# WI ----------------------------------------------------------------------

WI_bars <- bars_business[bars_business$state == "WI", ]
WI_total <- length(WI_bars[, 1])
WI$topic_1_rank <- (rank(WI$topic_1) + 24) / WI_total * 100
WI$topic_2_rank <- (rank(WI$topic_2) + 24) / WI_total * 100
WI$topic_3_rank <- (rank(WI$topic_3) + 24) / WI_total * 100
WI$topic_4_rank <- (rank(WI$topic_4) + 24) / WI_total * 100


zipdata_WI <- WI_bars %>%
  select(
    business_id = business_id,
    name = name,
    address = address,
    city = city,
    state = state,
    postal_code = postal_code,
    latitude = latitude,
    longitude = longitude,
    stars = stars,
    review_count = review_count
  )

WI_1 <- bars_business[bars_business$state == "WI", c(2, 3)]
zipdata2 <- merge(WI_1, WI, by = "business_id", all = T)
zipdata2[is.na(zipdata2)] <- 1 / WI_total * 100
zipdata2 <- zipdata2[, c(1, 7, 8, 9, 10)]
zipdata_WI <- merge(zipdata_WI, zipdata2, by = "business_id", all = T)
rm(zipdata2)
rm(WI)
rm(WI_1)
rm(WI_bars)
rm(WI_total)
