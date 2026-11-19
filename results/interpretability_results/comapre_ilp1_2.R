# library(ggplot2)
# library(tidyr)
# library(dplyr)
# 
# # Load data
# df <- read.csv(
#   "benchmark_against_1.txt",
#   strip.white = TRUE,
#   check.names = FALSE
# ) 
# # Compute grouping
# groups <- df %>%
#   group_by(Test) %>%
#   summarise(
#     median_time = median(`CUD@ILP`),
#     .groups = "drop"
#   ) %>%
#   mutate(
#     Group = ifelse(
#       median_time < 15,
#       "Median time CUD@ILP < 15 s",
#       "Median time CUD@ILP ≥ 15 s"
#     )
#   )
# 
# # Attach group
# df <- left_join(df, groups[, c("Test", "Group")], by = "Test")
# 
# # Long format
# df_long <- pivot_longer(
#   df,
#   cols = c("CUD@ILP", "CUD@ILP2"),
#   names_to = "Algorithm:",
#   values_to = "Time"
# )
# 
# # Reorder inside each group implicitly via data ordering
# df_long <- df_long %>%
#   group_by(Group, Test) %>%
#   mutate(Test = reorder(Test, Time, FUN = median)) %>%
#   ungroup()
# 
# # Plot
# ggplot(df_long, aes(x = Test, y = Time, fill = `Algorithm:`)) +
#   
#   stat_summary(
#     fun = mean,
#     geom = "bar",
#     position = position_dodge(0.7),
#     width = 0.7
#   ) +
#   
#   stat_summary(
#     fun.min = min,
#     fun.max = max,
#     geom = "errorbar",
#     position = position_dodge(0.7),
#     width = 0.1,
#     color = "#4d4d4d",
#     linewidth = 0.8
#   ) +
#   
#   facet_wrap(
#     ~ Group,
#     nrow = 1,
#     scales = "free"
#   ) +
#   
#   scale_fill_manual(
#     values = c(
#       "CUD@ILP" = "#40916c",
#       "CUD@ILP2" = "#b7e4c7"
#     )
#   ) +
#   
#   labs(
#     x = "Instance",
#     y = "Time (s)"
#   ) +
#   
#   theme_minimal(base_size = 18) +   # ⬅️ main global scaling
#   
#   theme(
#     panel.grid.major = element_blank(),
#     panel.grid.minor = element_blank(),
#     axis.line = element_line(color = "black"),
#     
#     # X/Y axis text
#     axis.text.x = element_text(
#       angle = 45,
#       hjust = 1,
#       size = 14
#     ),
#     axis.text.y = element_text(size = 14),
#     
#     # Axis titles
#     axis.title.x = element_text(size = 18, face = "bold"),
#     axis.title.y = element_text(size = 18, face = "bold"),
#     
#     # Facet labels ("Median time < 15s")
#     strip.text = element_text(size = 16, face = "bold"),
#     
#     # Legend
#     legend.title = element_text(size = 15),
#     legend.text = element_text(size = 14),
#     
#     legend.position = c(0.6, 0.8)
#   )
# 
library(ggplot2)
library(tidyr)
library(dplyr)

# Load data
df <- read.csv(
  "benchmark_against_1.txt",
  strip.white = TRUE,
  check.names = FALSE
) 

# Compute grouping
groups <- df %>%
  group_by(Test) %>%
  summarise(
    median_time = median(`CUD@ILP`),
    .groups = "drop"
  ) %>%
  mutate(
    Group = ifelse(
      median_time < 15,
      "Median time CUD@ILP < 15 s",
      "Median time CUD@ILP ≥ 15 s"
    )
  )

# Attach group
df <- left_join(df, groups[, c("Test", "Group")], by = "Test")

# Long format
df_long <- pivot_longer(
  df,
  cols = c("CUD@ILP", "CUD@ILP2"),
  names_to = "Algorithm",
  values_to = "Time"
)

# Reorder inside each group implicitly via data ordering
df_long <- df_long %>%
  group_by(Group, Test) %>%
  mutate(Test = reorder(Test, Time, FUN = median)) %>%
  ungroup()

# Colori coordinati con l'altro grafico
col_alg1 <- "#4a7ba6"
col_alg2 <- "#3a9942"

# Plot
p <- ggplot(df_long, aes(x = Test, y = Time, fill = Algorithm)) +
  
  stat_summary(
    fun = mean,
    geom = "bar",
    position = position_dodge(0.7),
    width = 0.65
  ) +
  
  stat_summary(
    fun.min = min,
    fun.max = max,
    geom = "errorbar",
    position = position_dodge(0.7),
    width = 0.15,
    color = "#333333",
    linewidth = 0.7
  ) +
  
  facet_wrap(
    ~ Group,
    nrow = 1,
    scales = "free"
  ) +
  
  scale_fill_manual(
    name = "",
    values = c(
      "CUD@ILP"  = col_alg1,
      "CUD@ILP2" = col_alg2
    )
  ) +
  
  labs(
    x = NULL,
    y = "Time (s)"
  ) +
  
  theme_bw(base_size = 15) +
  
  theme(
    # Legenda in alto come nell'altro grafico
    legend.position = "top",
    legend.text = element_text(size = 15, face = "bold"),
    
    # Testi assi uniformati
    axis.text.x = element_text(angle = 45, hjust = 1, size = 15, face = "bold"),
    axis.text.y = element_text(size = 16, face = "bold"),
    axis.title.y = element_text(size = 16, face = "bold", margin = margin(r = 10)),
    
    # Intestazioni dei pannelli (facet)
    strip.background = element_rect(fill = "#f2f4f7", color = "black"),
    strip.text = element_text(size = 15, face = "bold"),
    
    # Griglia pulita (solo linee orizzontali principali)
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank()
  )

print(p)

# ggsave("benchmark_against_1.pdf", plot = p, width = 9, height = 5)