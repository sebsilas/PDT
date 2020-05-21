
items <- read.csv("PDCT_IRT_ItemBank.csv")


items[, c("tone.1", "tone.2", "tone.3")] <- 330
items$answer <- NULL

for (row in 1:nrow(items)) {
  
  variable.pitch <- items[row, "level"]
  
  i <- sample(3,1)
  
  if (i == 1) {
    items[row, "tone.1"] <- variable.pitch
    items[row, "answer"] <- 1
  }
  else if (i == 2) {
    items[row, "tone.2"] <- variable.pitch
    items[row, "answer"] <- 2
  }
  
  else {
    items[row, "tone.3"] <- variable.pitch
    items[row, "answer"] <- 3
  }
  
}

write.csv(items, "ItemBank.csv", row.names = FALSE)
