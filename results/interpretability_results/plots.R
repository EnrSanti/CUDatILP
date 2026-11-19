library(readODS)
library(dplyr)
library(ggplot2)

############################################################
# FILES
############################################################

file1 <- "experiments/loan/sum_up.ods"
file2 <- "experiments/ai_argicoluture/sum_up.ods"
file3 <- "experiments/beans/sum_up.ods"
file4 <- "experiments/gaming_behaviour/sum_up.ods"
file5 <- "experiments/iris/sum_up.ods"
file6 <- "experiments/PM-acl/sum_up.ods"

############################################################
read_test <- function(file, name){
  
  df <- read_ods(file)
  
  names(df) <- c(
    "run",
    "length_no_bg",
    "length_bg",
    "split",
    "rule_ratio",
    "acc_no_bg",
    "acc_bg")
  
  df <- df[df$run != "MEANS:",]
  
  df$length_no_bg <- as.numeric(df$length_no_bg)
  df$length_bg    <- as.numeric(df$length_bg)
  df$acc_no_bg    <- as.numeric(df$acc_no_bg)
  df$acc_bg       <- as.numeric(df$acc_bg)
  
  df$dataset <- name
  df
}

############################################################

data <- bind_rows(
  read_test(file1, "Loan approval"),
  read_test(file2, "IOT Agricolture"),
  read_test(file3, "Dry beans"),
  read_test(file4, "Gaming beh."),
  read_test(file5, "Iris"),
  read_test(file6, "PM ACL")
)

data$dataset <- factor(data$dataset, levels = unique(data$dataset))

############################################################

data <- data %>%
  mutate(
    Reduction    = 100 * (length_no_bg - length_bg) / length_no_bg,
    AccuracyGain = 100 * (acc_bg - acc_no_bg)
  )

############################################################
# SD calcolate PRIMA delle medie (altrimenti sono NA)
############################################################

summary <- data %>%
  group_by(dataset) %>%
  summarise(
    ReductionSD  = sd(Reduction),
    AccuracySD   = sd(AccuracyGain),
    Reduction    = mean(Reduction),
    AccuracyGain = mean(AccuracyGain),
    .groups = "drop"
  )

scaleFactor <- max(summary$Reduction) / max(summary$AccuracyGain)

############################################################
# PLOT
############################################################

col_bar  <- "#4a7ba6"
col_line <- "#3a9942"

p <- ggplot(summary, aes(x = dataset)) +
  
  geom_col(aes(y = Reduction, fill = "Avg. hypothesis Reduction (%)"),
           width = .6) +
  
  geom_line(aes(y = AccuracyGain * scaleFactor,
                group = 1,
                color = "Avg. accuracy Gain (%)"),
            linewidth = 1.5) +
  
  geom_point(aes(y = AccuracyGain * scaleFactor,
                 color = "Avg. accuracy Gain (%)"),
             size = 3) +
  
  scale_y_continuous(
    name = "Avg. hypothesis Reduction (%)",
    labels = function(x) paste0(x, "%"),
    sec.axis = sec_axis(~ . / scaleFactor,
                        name = "Avg. accuracy Gain (%)",
                        labels = function(x) paste0(x, "%"))
  ) +
  
  scale_fill_manual(name = "",
                    values = c("Avg. hypothesis Reduction (%)" = col_bar)) +
  scale_color_manual(name = "",
                     values = c("Avg. accuracy Gain (%)" = col_line)) +
  
  # barra prima (sinistra), linea dopo (destra)
  guides(fill  = guide_legend(order = 1),
         color = guide_legend(order = 2)) +
  
  labs(x = NULL, title = NULL) +
  
  theme_bw(base_size = 15) +
  theme(
    legend.position = "top",
    legend.text = element_text(size = 15, face = "bold"),
    
    axis.text.x = element_text(angle = 45, hjust = 1, size = 15, face = "bold"),
    
    axis.title.y.left  = element_text(color = col_bar,  face = "bold", size = 16, margin = margin(r = 10)),
    axis.text.y.left   = element_text(color = col_bar,  face = "bold", size = 16),
    axis.ticks.y.left  = element_line(color = col_bar,  linewidth = 1),
    
    axis.title.y.right = element_text(color = col_line, face = "bold", size = 16, margin = margin(l = 10)),
    axis.text.y.right  = element_text(color = col_line, face = "bold", size = 16),
    axis.ticks.y.right = element_line(color = col_line, linewidth = 1),
    
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank()
  )

print(p)

ggsave("relative_improvement.pdf", plot = p, width = 9, height = 5)