library(ggplot2)
library(patchwork)

##### I. FIG 2: Confirmatory Analysis for Young Group ####
conf_young_auth <- read.csv("results/confirmatory/youth_vectors_authors.csv") 
conf_young_ours <- read.csv("results/confirmatory/youth_vectors_ours.csv")

fig2a <- ggplot(conf_young_auth, aes(x = anx_mean, y = brain_dissimilarity)) +
  geom_point(color = "lightgray", alpha = 0.30, size = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#1565C0") + 
  theme_classic() +
  labs(title = "Authors' script") + 
  xlab("mean anxiety score") +
  ylab("brain dissimilarity") +
  theme(plot.title = element_text(hjust = 0.5)) +
  annotate("text", x = min(conf_young_auth$anx_mean), 
           y = max(conf_young_auth$brain_dissimilarity),
           label = "r = .148\n(P = .042)", 
           hjust = 0, vjust = 1, size = 4, color = "#1565C0")
  
fig2b <- ggplot(conf_young_ours, aes(x = anx_mean, y = brain_dissimilarity)) +
  geom_point(color = "lightgray", alpha = 0.30, size = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#1565C0") + 
  theme_classic() +
  labs(title = "Our DIM script") + 
  xlab("mean anxiety score") +
  ylab("brain dissimilarity") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  annotate("text", x = min(conf_young_auth$anx_mean), 
           y = max(conf_young_auth$brain_dissimilarity),
           label = "r = .148\n(P = .043)", 
           hjust = 0, vjust = 1, size = 4, color = "#1565C0")

fig2 <- fig2a + fig2b
fig2

ggsave("../writeup/figures/fig2.png", fig2, 
       width = 6.8, height = 3.1,
       units = "in", dpi = 300)


##### II. FIG 3: Confirmatory Analysis for Older Group ####
conf_older_auth <- read.csv("results/confirmatory/older_vectors_authors.csv") 
conf_older_ours <- read.csv("results/confirmatory/older_vectors_ours.csv")

fig3a <- ggplot(conf_older_auth, aes(x = anx_mean, y = brain_dissimilarity)) +
  geom_point(color = "lightgray", alpha = 0.30, size = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#1565C0") + 
  theme_classic() +
  labs(title = "Authors' script") + 
  xlab("mean anxiety score") +
  ylab("brain dissimilarity") +
  theme(plot.title = element_text(hjust = 0.5)) +
  annotate("text", x = min(conf_older_auth$anx_mean), 
           y = max(conf_older_auth$brain_dissimilarity),
           label = "r = .294\n(P = .016)", 
           hjust = 0, vjust = 1, size = 4, color = "#1565C0")

fig3b <- ggplot(conf_older_ours, aes(x = anx_mean, y = brain_dissimilarity)) +
  geom_point(color = "lightgray", alpha = 0.30, size = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#1565C0") + 
  theme_classic() +
  labs(title = "Our DIM script") + 
  xlab("mean anxiety score") +
  ylab("brain dissimilarity") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  annotate("text", x = min(conf_older_auth$anx_mean), 
           y = max(conf_older_auth$brain_dissimilarity),
           label = "r = .294\n(P = .017)", 
           hjust = 0, vjust = 1, size = 4, color = "#1565C0")

fig3 <- fig3a + fig3b
fig3

ggsave("../writeup/figures/fig3.png", fig3, 
       width = 6.8, height = 3.1,
       units = "in", dpi = 300)


##### III. FIG 4: Exploratory Analysis within Discovery Set ####
exp_young_ours <- read.csv("results/exploratory/discovery_vectors.csv") 
exp_young_ours$comp_mean_minmax <- (exp_young_ours$comp_mean - min(exp_young_ours$comp_mean)) / (max(exp_young_ours$comp_mean) - min(exp_young_ours$comp_mean)) 
conf_young_auth$anx_mean_minmax <- (conf_young_auth$anx_mean - min(conf_young_auth$anx_mean)) / (max(conf_young_auth$anx_mean) - min(conf_young_auth$anx_mean)) 

summary(exp_young_ours)

fig4a <- ggplot(conf_young_auth, aes(x = anx_mean_minmax, y = brain_dissimilarity)) +
  geom_point(color = "lightgray", alpha = 0.30, size = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#1565C0") + 
  theme_classic() +
  xlim(c(0, 1)) + 
  labs(title = "Only Anxiety - Kim & Kim (2022)") + 
  xlab("mean anxiety score (min/max scaled)") +
  ylab("brain dissimilarity") +
  theme(plot.title = element_text(hjust = 0.5)) +
  annotate("text", x = min(conf_young_auth$anx_mean_minmax), 
           y = max(conf_young_auth$brain_dissimilarity),
           label = "r = .148", 
           hjust = 0, vjust = 1, size = 4, color = "#1565C0")

fig4b <- ggplot(exp_young_ours, aes(x = comp_mean_minmax, y = brain_dissimilarity)) +
  geom_point(color = "lightgray", alpha = 0.30, size = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#1565C0") + 
  theme_classic() +
  xlim(c(0, 1)) + 
  labs(title = "Five Traits - Ours") + 
  xlab("mean composite score (min/max scaled)") +
  ylab("brain dissimilarity") +
  theme(plot.title = element_text(hjust = 0.5)) +
  annotate("text", x = min(conf_young_auth$anx_mean_minmax), 
           y = max(conf_young_auth$brain_dissimilarity),
           label = "r = .278", 
           hjust = 0, vjust = 1, size = 4, color = "#1565C0")
  
fig4 <- fig4a + fig4b
fig4

ggsave("../writeup/figures/fig4.png", fig4, 
       width = 6.8, height = 3.1,
       units = "in", dpi = 300)


##### IV. FIG 5: WEIGHTS INFERENCE ####
exp_weights <- read.csv("results/exploratory/discovery_boot_weights.csv")
exp_weights$feature <- c("anxiety", "reappraisal", "suppression", "neuroticism", "impulsivity")
exp_weights_sorted <- exp_weights[order(-exp_weights$weights_estimates), ]
exp_weights_sorted$feature <- factor(exp_weights_sorted$feature, levels = c("neuroticism", "suppression", "anxiety", "reappraisal", "impulsivity"))

highlight_feature <- "suppression"

fig5 <- ggplot(exp_weights_sorted, aes(x = feature, y = weights_estimates)) +
  geom_errorbar(aes(ymin = weight_ci_lower, ymax = weight_ci_upper,
                    color = feature == highlight_feature),
                width = 0.0, size = 0.8, alpha = 0.8) +
  geom_point(aes(color = feature == highlight_feature), size = 3) +
  geom_text(aes(x = feature, y = weight_ci_upper + 0.02,
    label = sprintf("%.3f", weights_estimates),
    color = feature == highlight_feature
  ), size = 3.5) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  scale_color_manual(values = c("TRUE" = "#1565C0",
                                "FALSE" = "black")) + 
  theme_classic() +
  labs(y = "feature weights\n(bootstrapped 95% CI)", x = NULL) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, hjust = 1, size = 11),
    axis.title.y = element_text(size = 12)
  )

ggsave("../writeup/figures/fig5.png", fig5, 
       width = 3.0, height = 4.2,
       units = "in", dpi = 300)


##### V. FIG 6: Exploratory Analysis to Replicate Set ####
exp_older_ours <- read.csv("results/exploratory/replicate_vectors.csv") 
exp_null <- read.csv("results/exploratory/replicate_null_distribution.csv")
exp_older_ours$comp_mean_minmax <- (exp_older_ours$comp_mean - min(exp_older_ours$comp_mean)) / (max(exp_older_ours$comp_mean) - min(exp_older_ours$comp_mean)) 

fig6a <- ggplot(exp_older_ours, aes(x = comp_mean_minmax, y = brain_dissimilarity)) +
  geom_point(color = "lightgray", alpha = 0.30, size = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#1565C0") + 
  theme_classic() +
  xlim(c(0, 1)) + 
  labs(title = "Replicate Set") + 
  xlab("mean composite score (min/max scaled)") +
  ylab("brain dissimilarity") +
  theme(plot.title = element_text(hjust = 0.5)) +
  annotate("text", x = min(conf_young_auth$anx_mean_minmax), 
           y = max(conf_young_auth$brain_dissimilarity),
           label = "r = .319\n(P = .011)", 
           hjust = 0, vjust = 1, size = 4, color = "#1565C0")

fig6b <- ggplot(exp_null, aes(x = null_rho)) +
  geom_histogram(bins = 100, color = "lightgray", fill = "lightgray") + 
  geom_vline(xintercept = 0.319, color = "#1565C0", linewidth = 1) +
  theme_classic()

fig6 <- fig6a + 
  inset_element(
    p = fig6b, 
    left = 0.6, 
    bottom = 0.6,
    right = 1,    
    top = 1     
  )

ggsave("../writeup/figures/fig6.png", fig6, 
       width = 6.0, height = 4.2,
       units = "in", dpi = 300)