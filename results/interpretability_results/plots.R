library(readODS)
library(dplyr)
library(ggplot2)

############################################################
# FILES & LETTURA
############################################################

file1 <- "experiments/loan/sum_up.ods"
file2 <- "experiments/ai_argicoluture/sum_up.ods"
file3 <- "experiments/beans/sum_up.ods"
file4 <- "experiments/gaming_behaviour/sum_up.ods"
file5 <- "experiments/iris/sum_up.ods"
file6 <- "experiments/PM-acl/sum_up.ods"

read_test <- function(file, name) {
  df <- read_ods(file)
  names(df) <- c(
    "run", "length_no_bg", "length_bg",
    "split", "rule_ratio", "acc_no_bg", "acc_bg"
  )
  
  df %>%
    filter(run != "MEANS:") %>%
    mutate(
      length_no_bg = as.numeric(length_no_bg),
      length_bg    = as.numeric(length_bg),
      acc_no_bg    = as.numeric(acc_no_bg),
      acc_bg       = as.numeric(acc_bg),
      dataset      = name
    )
}

data <- bind_rows(
  read_test(file1, "Loan approval"),
  read_test(file2, "IoT Agriculture"),
  read_test(file3, "Dry beans"),
  read_test(file4, "Gaming beh."),
  read_test(file5, "Iris"),
  read_test(file6, "PM ACL")
) %>%
  mutate(
    dataset      = factor(dataset, levels = unique(dataset)),
    Reduction    = 100 * (length_no_bg - length_bg) / length_no_bg,
    AccuracyGain = 100 * (acc_bg - acc_no_bg)
  )

############################################################
# AGGREGAZIONE E SCALA PULITA DEGLI ASSI
############################################################

summary <- data %>%
  group_by(dataset) %>%
  summarise(
    ReductionSD  = sd(Reduction, na.rm = TRUE),
    AccuracySD   = sd(AccuracyGain, na.rm = TRUE),
    Reduction    = mean(Reduction, na.rm = TRUE),
    AccuracyGain = mean(AccuracyGain, na.rm = TRUE),
    .groups = "drop"
  )

max_left  <- ceiling(max(summary$Reduction, na.rm = TRUE) / 5) * 5
max_right <- ceiling(max(summary$AccuracyGain, na.rm = TRUE) / 5) * 5

if (max_right == 0) max_right <- max(pretty(c(0, max(summary$AccuracyGain, na.rm = TRUE))))

scaleFactor <- max_left / max_right

############################################################
# PLOT
############################################################

col_bar  <- "#6e98c2"
col_line <- "#23783b"

p <- ggplot(summary, aes(x = dataset)) +
  
  # Barre più larghe (width = 0.78) per ridurre la distanza tra loro
  geom_col(
    aes(y = Reduction, fill = "Avg. hypothesis Reduction (%)"),
    width = 0.45
  ) +
  
  geom_line(
    aes(y = AccuracyGain * scaleFactor, group = 1, color = "Avg. accuracy Gain (%)"),
    linewidth = 1.5
  ) +
  
  geom_point(
    aes(y = AccuracyGain * scaleFactor, color = "Avg. accuracy Gain (%)"),
    size = 3
  ) +
  
  # Riduce il padding laterale sull'asse X per compattare le barre
  scale_x_discrete(
    expand = expansion(add = 0.5)
  ) +
  
  # Limite superiore portato vicino al top del riquadro
  scale_y_continuous(
    name   = "Avg. hypothesis Reduction (%)",
    limits = c(0, max_left * 1.01),
    breaks = pretty(c(0, max_left)),
    labels = function(x) paste0(x, "%"),
    expand = expansion(mult = c(0.02, 0.005)),
    sec.axis = sec_axis(
      transform = ~ . / scaleFactor,
      name      = "Avg. accuracy Gain (%)",
      breaks    = pretty(c(0, max_right)),
      labels    = function(x) paste0(x, "%")
    )
  ) +
  
  scale_fill_manual(
    name   = "",
    values = c("Avg. hypothesis Reduction (%)" = col_bar)
  ) +
  scale_color_manual(
    name   = "",
    values = c("Avg. accuracy Gain (%)" = col_line)
  ) +
  
  guides(
    fill  = guide_legend(order = 1),
    color = guide_legend(order = 2)
  ) +
  
  labs(x = NULL, title = NULL) +
  
  theme_bw(base_size = 15) +
  theme(
    legend.position = "top",
    legend.text     = element_text(size = 15, face = "bold"),
    
    axis.text.x = element_text(angle = 35, hjust = 1, size = 14, face = "bold"),
    
    axis.title.y.left  = element_text(color = col_bar,  face = "bold", size = 15, margin = margin(r = 10)),
    axis.text.y.left   = element_text(color = col_bar,  face = "bold", size = 15),
    axis.ticks.y.left  = element_line(color = col_bar,  linewidth = 1),
    
    axis.title.y.right = element_text(color = col_line, face = "bold", size = 15, margin = margin(l = 10)),
    axis.text.y.right  = element_text(color = col_line, face = "bold", size = 15),
    axis.ticks.y.right = element_line(color = col_line, linewidth = 1),
    
    panel.grid.major = element_line(color = "#E5E5E5", linewidth = 0.5),
    panel.grid.minor = element_line(color = "#F2F2F2", linewidth = 0.3)
  )

print(p)

# Salva leggermente più stretto (width = 7.5 invece di 10) per avvicinare fisicamente le 6 colonne
ggsave("gainsR.pdf", plot = p, width = 10, height = 6)