library(readODS)
library(dplyr)
library(ggplot2)
library(grid)
############################################################
# FILES
############################################################

file1 <- "experiments/ai_argicoluture/sum_up.ods"
file2 <- "experiments/beans/sum_up.ods"
file3 <- "experiments/gaming_behaviour/sum_up.ods"
file4 <- "experiments/iris/sum_up.ods"
file5 <- "experiments/loan/sum_up.ods"

############################################################
read_test <- function(file,name){
  
  df <- read_ods(file)
  
  names(df) <- c(
    "run",
    "length_no_bg",
    "length_bg",
    "split",
    "rule_ratio",
    "acc_no_bg",
    "acc_bg")
  
  df <- df[df$run!="MEANS:",]
  
  df$length_no_bg <- as.numeric(df$length_no_bg)
  df$length_bg <- as.numeric(df$length_bg)
  df$acc_no_bg <- as.numeric(df$acc_no_bg)
  df$acc_bg <- as.numeric(df$acc_bg)
  
  df$dataset <- name
  
  df
  
}

############################################################

data <- bind_rows(
  
  read_test(file1,"IOT Agriculture"),
  read_test(file2,"Dry beans"),
  read_test(file3,"Gaming beh."),
  read_test(file4,"Iris"),
  read_test(file5,"Loan approval")
  
)
data$dataset <- factor(
  data$dataset,
  levels = unique(data$dataset)
)
############################################################

data <- data %>%
  
  mutate(
    
    Reduction =
      100*(length_no_bg-length_bg)/length_no_bg,
    
    AccuracyGain =
      100*(acc_bg-acc_no_bg)
    
  )

############################################################

summary <-
  
  data %>%
  
  group_by(dataset) %>%
  
  summarise(
    
    Reduction=mean(Reduction),
    ReductionSD=sd(Reduction),
    
    AccuracyGain=mean(AccuracyGain),
    AccuracySD=sd(AccuracyGain),
    
    .groups="drop"
    
  )

############################################################

scaleFactor <- max(summary$Reduction)/max(summary$AccuracyGain)

############################################################
ggplot(summary,
       aes(x = dataset)) +
  
  geom_col(aes(y = Reduction, fill = "Avg. hypothesis Reduction (%)"),
           width = .6) +
  
  geom_errorbar(aes(
    ymin = Reduction - ReductionSD,
    ymax = Reduction + ReductionSD),
    width = .2) +
  
  geom_line(aes(
    y = AccuracyGain * scaleFactor,
    group = 1,
    color = "Avg. accuracy Gain (%)"),
    linewidth = 1.2) +
  
  geom_point(aes(
    y = AccuracyGain * scaleFactor,
    color = "Avg. accuracy Gain (%)"),
    size = 3) +
  
  scale_y_continuous(
    name = "Avg. hypothesis Reduction (%)",
    sec.axis = sec_axis(~./scaleFactor,
                        name = "Avg. accuracy Gain (%)")
  ) +
  
  scale_fill_manual(
    name = "",
    values = c("Avg. hypothesis Reduction (%)" = "#40916c")
  ) +
  
  scale_color_manual(
    name = "",
    values = c("Avg. accuracy Gain (%)" = "#387ab0")
  ) +
  
  theme_bw(base_size = 15) +
  
  theme(
    plot.title = element_text(
      hjust = 0.5,
      size = 26
    ),
    
    axis.title.x = element_text(
      size = 22
    ),
    
    axis.title.y.left = element_text(
      size = 22
    ),
    
    axis.title.y.right = element_text(
      size = 22
    ),
    
    axis.text.x = element_text(
      angle = 45,
      hjust = 1,
      size = 20
    ),
    
    axis.text.y = element_text(
      size = 20
    ),
    
    legend.position = c(0.88,0.85),
    
    legend.text = element_text(
      size = 15
    ),
    
    legend.spacing.y = unit(0.02, "cm"),
    legend.key.height = unit(0.02, "cm")
  ) +
  
  labs(
    title = "Effect of Background Knowledge",
    x = "Instance"
  )

ggsave(
  "relative_improvement.pdf",
  width=9,
  height=5)

