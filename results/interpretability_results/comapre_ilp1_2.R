library(ggplot2)
library(dplyr)

# 1. Caricamento dei dati da benchmark.txt
df <- read.csv(
  "benchmark.txt",
  strip.white = TRUE,
  check.names = FALSE
)

# Dizionario per rinominare i dataset
nomi_puliti <- c(
  "human_activity"   = "Human",
  "MNIST"            = "MNIST",
  "crops"            = "Crops",
  "MiniBooNE"        = "MiniBooNE",
  "lifestyle"        = "Lifestyle",
  "sloan"            = "Sloan",
  "diabetes"         = "Diabetes",
  "jannis"           = "Jannis",
  "smoke_drink"      = "SmokeDrink",
  "covertype"        = "CoverType",
  "weather"          = "Weather",
  "nepal_earthquake" = "Earthquake"
)

# 2. Calcolo della media sulle 5 run per dataset e delle due metriche
df_summary <- df %>%
  group_by(Test) %>%
  summarise(
    time_ilp1 = mean(`CUD@ILP`, na.rm = TRUE),
    time_ilp2 = mean(`CUD@ILP2`, na.rm = TRUE),
    time_fold = mean(`FOLD-RM`, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    speedup = time_fold / time_ilp2,
    pct_decrease = ((time_ilp1 - time_ilp2) / time_ilp1) * 100,
    Test_label = nomi_puliti[Test]
  ) %>%
  arrange(pct_decrease) %>%
  mutate(Test_label = factor(Test_label, levels = Test_label))

# 3. Fattore di scala (32% allineato a 60x) e colori coordinati
scale_factor <- 60 / 32

col_bar  <- "#6e98c2"
col_line <- "#23783b"

# 4. Creazione del grafico con assi Y colorati, labellati e griglia completa
p <- ggplot(df_summary, aes(x = Test_label)) +
  
  geom_col(
    aes(y = speedup, fill = "Speedup of CUD@ILP2 over FOLD-RM"),
    width = 0.62
  ) +
  
  geom_line(
    aes(
      y = pct_decrease * scale_factor,
      color = "Decrease in runtime from CUD@ILP to CUD@ILP2",
      group = 1
    ),
    linewidth = 1.5
  ) +
  
  geom_point(
    aes(
      y = pct_decrease * scale_factor,
      color = "Decrease in runtime from CUD@ILP to CUD@ILP2"
    ),
    size = 3
  ) +
  
  # Doppio asse Y con titoli e formattazione
  scale_y_continuous(
    name = "Speedup over FOLD-RM",
    limits = c(0, 60.5),
    breaks = seq(0, 60, by = 20),
    labels = function(x) paste0(x, "x"),
    expand = expansion(mult = c(0.02, 0.01)),
    sec.axis = sec_axis(
      transform = ~ . / scale_factor,
      name = "Runtime decrease (%)",
      breaks = seq(0, 30, by = 10),
      labels = function(x) paste0(x, "%")
    )
  ) +
  
  scale_fill_manual(
    name = "",
    values = c("Speedup of CUD@ILP2 over FOLD-RM" = col_bar)
  ) +
  scale_color_manual(
    name = "",
    values = c("Decrease in runtime from CUD@ILP to CUD@ILP2" = col_line)
  ) +
  
  # Barra prima (sinistra), linea dopo (destra)
  guides(
    fill  = guide_legend(order = 1),
    color = guide_legend(order = 2)
  ) +
  
  labs(x = NULL, title = NULL) +
  
  theme_bw(base_size = 15) +
  theme(
    legend.position = "top",
    legend.text = element_text(size = 14, face = "bold"),
    
    axis.text.x = element_text(angle = 35, hjust = 1, size = 14, face = "bold"),
    
    # Asse sinistro colorato (blu)
    axis.title.y.left  = element_text(color = col_bar,  face = "bold", size = 15, margin = margin(r = 10)),
    axis.text.y.left   = element_text(color = col_bar,  face = "bold", size = 15),
    axis.ticks.y.left  = element_line(color = col_bar,  linewidth = 1),
    
    # Asse destro colorato (verde)
    axis.title.y.right = element_text(color = col_line, face = "bold", size = 15, margin = margin(l = 10)),
    axis.text.y.right  = element_text(color = col_line, face = "bold", size = 15),
    axis.ticks.y.right = element_line(color = col_line, linewidth = 1),
    
    # Griglia completa (verticale e orizzontale)
    panel.grid.major = element_line(color = "#E5E5E5", linewidth = 0.5),
    panel.grid.minor = element_line(color = "#F2F2F2", linewidth = 0.3)
  )

print(p)

ggsave("bifigR.pdf", plot = p, width = 10, height = 6)