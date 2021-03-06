library(lme4)
library(party)
library(lattice)
library(plyr)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(wesanderson)

df <- read.csv("25-04-2018.csv")
df <- df[complete.cases(df[7]),]
levels(df$dep.var)
df <- droplevels(df[df$dep.var != ""&
				 df$dep.var != "/"&
				 df$dep.var != "NA"&
				 df$speaker != "tomo"&
				 df$speaker != "kiranpreet",])
df$dep.var <- relevel(df$dep.var,"zero")

df <- droplevels(df[df$matrix.verb != "feel"&
				 df$matrix.verb != "guess",])

# clean up stance
df <- droplevels(df[df$affect!="",])
levels(df$affect)
levels(df$affect) <- c("negative","neutral","positive","positive")

df <- droplevels(df[df$investment!="",])
levels(df$investment)
levels(df$investment) <- c("high","high","low","low","mid","mid","mid","mid","mid","high","low")
df$investment <- factor(df$investment, levels = c("low","mid","high"))


df <- droplevels(df[df$alignment!="",])
levels(df$alignment)
levels(df$alignment) <- c("align","align","align","neutral","neutral","disalign","align","neutral")
df$alignment <- relevel(df$alignment,"disalign")

df <- droplevels(df[df$hierarchy!="",])
levels(df$hierarchy)
levels(df$hierarchy) <- c("same","expert","expert","novice","novice","same","same","same")
df$hierarchy <- relevel(df$hierarchy,"novice")

# xtabs(~matrix.verb,df) # match other group
# levels(df$matrix.verb) <- c("other","other","other","other","other",
#                             "other","other","other","other","other",
#                             "other","other","other","other", "other",
#                             "other","other","other","other","other",
#                             "other","know","other","other","make-sure",
#                             "other","other","other","other","other",
#                             "other", "other","other","other","other",
#                             "other","say","other","other","other",
#                             "other","other","other","other","other",
#                             "other","think","other","other","other",
#                             "other","other")

xtabs(~matrix.verb,df) # think only
levels(df$matrix.verb) <- c("other","other","other","other","other",
							"other","other","other","other","other",
							"other","other","other","other", "other",
							"other","other","other","other","other",
							"other","other","other","other","other",
							"other","other","other","other","other",
							"other", "other","other","other","other",
							"other","other","other","other","other",
							"other","other","other","other","other",
							"other","think","other","other","other",
							"other","other")
# levels(df$matrix.verb) <- c("other","other","other","other",
#                             "other","other","other","other",
#                             "other","other", "other","other",
#                             "other","other", "other","other",
#                             "other","other","other","other",
#                             "other","other","other","other",
#                             "other","other","other","other",
#                             "other","other","other", "other",
#                             "other","other","other","other",
#                             "other","other","other","other",
#                             "other","other","other","other",
#                             "other", "think","other","other",
#                             "other","other","other")


# levels(df$matrix.verb) <- c("other","other","be","be+adj","other", # above 10
#                             "be+np","other","other","other","other",
#                             "other","feel","other","other","other",
#                             "other","other","other","guess","hear",
#                             "other","other","other","other","other",
#                             "know","other","other","make-sure","other",
#                             "mean","other","other","other","other",
#                             "other","other","other","other","say",
#                             "say","other","other","other","other",
#                             "other","other","other","other","tell",
#                             "think","other","other","other","other",
#                             "other")

# fiddling with stance
#levels(df$hierarchy) <- c("nonexpert","nonexpert","expert")
#levels(df$investment)
#levels(df$investment) <- c("none","some","some")
#df$investment <- relevel(df$investment,"none")

# fiddling with matrix-subj
#df$matrix.subj.simp <- relevel(df$matrix.subj.simp, "other")
