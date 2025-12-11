setwd("/Users/jinwoolee/Documents/github/kim2024/code/")

library(parameters)
library(tidyverse)
library(psych)
library(see)
library(lavaan)
library(performance)
#library(semPlot)     # install error in pixi add r-
#library(nFactors)    # install error in pixi add r-
library(vegan)
library(jsonlite)
#library(Rtsne)       # install error in pixi add r-
library(ggplot2)
library(reshape)      # not included in the original code but needed for visualization

meta = read.csv("../data-from-authors/Meta.csv")
STAI = read.csv("../data-from-authors/STAI_G_X2.csv")

# filtering by age
youth = subset(meta, Age == "20-25" | Age == "25-30" | Age == "30-35")

# filtering by availability of MRI data
youth = subset(youth, X != "sub-032339" & X != "sub-032341" & X != "sub-032459" & X != "sub-032370"
               & X != "sub-032466" & X != "sub-032438" & X != "sub-032509")

# filtering by SKID diagnoses
youth$SKID_Diagnoses = as.factor(youth$SKID_Diagnoses)
youth$SKID_Diagnoses = as.numeric(youth$SKID_Diagnoses)
Hyouth = subset(youth, SKID_Diagnoses == 1 | SKID_Diagnoses == 10)

# leaving only relevant info
Hyouth = Hyouth[, -c(4:14, 16:21)]

# merging STAI data
Hyouth = merge(Hyouth, STAI, by = "X")

# constructing the anxiety distance matrix
HAnnaKSTAI = data.frame()
for (i in 1:119) {
  for (j in 1:119) {
    HAnnaKSTAI[j, i] = (sum(Hyouth[i, 5], Hyouth[j, 5]))/2
  }
}


yh_prob_5p_L = read.csv("../data-from-authors/tractfiles/yh_probmap_5p_L.csv", header = T)
yh_prob_5p_L = yh_prob_5p_L[,-1]  # removing the first column which is just the index

HAnnaKBrain = dist(t(yh_prob_5p_L))

set.seed(42)
results <- mantel(HAnnaKSTAI, HAnnaKBrain, method = "spearman", permutations = 10000)

# Visualizing the scatterplot of pairwise STAI and Brain Dissimilarity
HAnnaKSTAI_vec <- HAnnaKSTAI[upper.tri(HAnnaKSTAI)]
HAnnaKBrain_vec <- HAnnaKBrain[upper.tri(HAnnaKBrain)]

total_df <- data.frame(stai_mean = HAnnaKSTAI_vec, brain_dissimilarity = HAnnaKBrain_vec)

orig_scatter <- ggplot(total_df, aes(x = stai_mean, y = brain_dissimilarity)) +
  geom_point(alpha = 0.25, color = "gray", size = 0.75) +       
  geom_smooth(method = "lm", se = TRUE, color = "#1565C0") + 
  theme_classic() +
  labs(
    title = "",
    x = "Pairwise STAI Mean",
    y = "Pairwise Brain Dissimilarity"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

orig_scatter

perm.df <- data.frame(perm = results['perm'])

ggplot(perm.df, aes(x = perm)) +
  geom_histogram(bins = 100, color = "lightgray", fill = "lightgray") + 
  geom_vline(xintercept = as.numeric(results['statistic']), color = "#1565C0", linewidth = 1) +
  theme_classic()
  
# =======

dim_real_D_x <- read.csv("dim_real_D_x.csv", header = FALSE)
dim_real_D_y <- read.csv("dim_real_D_y.csv", header = FALSE)

dim_real_D_x_vec <- dim_real_D_x[upper.tri(dim_real_D_x)]
dim_real_D_y_vec <- dim_real_D_y[upper.tri(dim_real_D_y)]

dim_real_df <- data.frame(stai_mean = dim_real_D_x_vec, brain_dissimilarity = dim_real_D_y_vec)

dim_real_scatter <- ggplot(dim_real_df, aes(x = stai_mean, y = brain_dissimilarity)) +
  geom_point(alpha = 0.25, color = "gray", size = 0.75) +       
  geom_smooth(method = "lm", se = TRUE, color = "#1565C0") + 
  theme_classic() +
  labs(
    title = "",
    x = "Pairwise STAI Mean",
    y = "Pairwise Brain Dissimilarity"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

dim_real_scatter

dim_real_null <- read.csv("dim_real_null.csv", header = FALSE)

ggplot(dim_real_null, aes(x = V1)) +
  geom_histogram(bins = 100, color = "lightgray", fill = "lightgray") + 
  geom_vline(xintercept = 0.148, color = "#1565C0", linewidth = 1) +
  theme_classic()

# ===

dim_sim_D_x <- read.csv("dim_sim_D_x.csv")
dim_sim_D_y <- read.csv("dim_sim_D_y.csv")

dim_sim_D_x <- dim_sim_D_x[, -1]
dim_sim_D_y <- dim_sim_D_y[, -1]

dim_sim_D_x_vec <- dim_sim_D_x[upper.tri(dim_sim_D_x)]
dim_sim_D_y_vec <- dim_sim_D_y[upper.tri(dim_sim_D_y)]

dim_sim_df <- data.frame(stai_mean = dim_sim_D_x_vec, brain_dissimilarity = dim_sim_D_y_vec)

dim_sim_scatter <- ggplot(dim_sim_df, aes(x = stai_mean, y = brain_dissimilarity)) +
  geom_point(alpha = 0.25, color = "gray", size = 0.75) +       
  geom_smooth(method = "lm", se = TRUE, color = "#1565C0") + 
  theme_classic() +
  labs(
    title = "",
    x = "Pairwise STAI Mean",
    y = "Pairwise Brain Dissimilarity"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

dim_sim_scatter

dim_sim_null <- read.csv("dim_sim_null.csv", header = FALSE)
dim_sim_null <- data.frame(dim_sim_null[-1, -1])

ggplot(dim_sim_null, aes(x = dim_sim_null..1...1.)) +
  geom_histogram(bins = 100, color = "lightgray", fill = "lightgray") + 
  geom_vline(xintercept = 0.159, color = "#1565C0", linewidth = 1) +
  theme_classic()

# ===
dim_train_D_x <- read.csv("learn_train_D_x.csv", header = FALSE)
dim_train_D_y <- read.csv("learn_train_D_y.csv", header = FALSE)

dim_train_D_x_vec <- dim_train_D_x[upper.tri(dim_train_D_x)]
dim_train_D_y_vec <- dim_train_D_y[upper.tri(dim_train_D_y)]

dim_train_df <- data.frame(psych_mean = dim_train_D_x_vec, brain_dissimilarity = dim_train_D_y_vec)

dim_train_scatter <- ggplot(dim_train_df, aes(x = psych_mean, y = brain_dissimilarity)) +
  geom_point(alpha = 0.25, color = "gray", size = 0.75) +       
  geom_smooth(method = "lm", se = TRUE, color = "#1565C0") + 
  theme_classic() +
  labs(
    title = "",
    x = "Pairwise Composite Score Mean",
    y = "Pairwise Brain Dissimilarity"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

dim_train_scatter


dim_test_D_x <- read.csv("learn_test_D_x.csv", header = FALSE)
dim_test_D_y <- read.csv("learn_test_D_y.csv", header = FALSE)

dim_test_D_x_vec <- dim_test_D_x[upper.tri(dim_test_D_x)]
dim_test_D_y_vec <- dim_test_D_y[upper.tri(dim_test_D_y)]

dim_test_df <- data.frame(psych_mean = dim_test_D_x_vec, brain_dissimilarity = dim_test_D_y_vec)

dim_test_scatter <- ggplot(dim_test_df, aes(x = psych_mean, y = brain_dissimilarity)) +
  geom_point(alpha = 0.25, color = "gray", size = 0.75) +       
  geom_smooth(method = "lm", se = TRUE, color = "#1565C0") + 
  theme_classic() +
  labs(
    title = "",
    x = "Pairwise Composite Score Mean",
    y = "Pairwise Brain Dissimilarity"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

dim_test_scatter

dim_test_null <- read.csv("perm.csv", header = FALSE)

ggplot(dim_test_null, aes(x = V1)) +
  geom_histogram(bins = 100, color = "lightgray", fill = "lightgray") + 
  geom_vline(xintercept = 0.319, color = "#1565C0", linewidth = 1) +
  theme_classic()

boot <- read.csv("learn_feature_weights.csv", header = FALSE)
boot.upper <- read.csv("learn_feature_weights_upper.csv", header = FALSE)
boot.lower <- read.csv("learn_feature_weights_lower.csv", header = FALSE)

boot.df <- cbind(boot, boot.lower)
boot.df <- cbind(boot.df, boot.upper)
colnames(boot.df) <- c("estimates", "CI_lower", "CI_upper")
boot.df$name <- c("STAI", "ERQ_reappraisal", "ERQ_suppression", "FFI_neuroticism", "UPPS_preservence")

ggplot(boot.df, aes(x = name, y = estimates)) +
  geom_errorbar(aes(ymin = CI_lower, ymax = CI_upper), width = 0.0) +
  geom_point(size = 2) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray") +
  ylim(c(-0.2, 0.3)) + 
  theme_classic()
  