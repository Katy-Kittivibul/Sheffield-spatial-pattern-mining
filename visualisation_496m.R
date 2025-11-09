# This code is a part of Dissertation. 
# Topic: Co-location patterns of diffusion tubes and sensitive locations in Sheffield.
# Kulisara Kittivibul

#------------------------------------------------------------------------------#

# Install and load packages

install.packages("remotes")
remotes::install_github("gastonstat/arcdiagram")

install.packages("igraph")
install.packages("readxl")
install.packages("networkD3")

library(arcdiagram)
library(igraph)
library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)
library(networkD3)

# Import file
# add "all_prevalent_patterns_XXX.xlsx" file at a specific distance threshold. (E.g. all_prevalent_patterns_600m.xlsx)
# can extract prevalent pattern at specific distance from "all_prevalent_patterns_combined.csv"
pattern <- read_excel("all_prevalent_patterns_496m.xlsx") # example file
View(pattern)

#---------------------------------Sankey diagram-------------------------------#

# 1. Extract flows for pattern_length = 2: location_1 to location_2
flows_L2 <- pattern %>%
  filter(pattern_length == 2) %>%
  select(source = location_1, target = location_2, value = min_pi_threshold) %>%
  na.omit() # Remove rows with NA in target (e.g., if a pattern doesn't have loc_2)

# 2. Extract flows for pattern_length = 3: location_2 to location_3
flows_L3 <- pattern %>%
  filter(pattern_length == 3) %>%
  select(source = location_2, target = location_3, value = min_pi_threshold) %>%
  na.omit()

# 3. Extract flows for pattern_length = 4: location_3 to location_4
flows_L4 <- pattern %>%
  filter(pattern_length == 4) %>%
  select(source = location_3, target = location_4, value = min_pi_threshold) %>%
  na.omit()

# 4. Combine all flows into a single data frame
all_flows <- bind_rows(flows_L2, flows_L3, flows_L4)

# Remove any leading/trailing whitespace from location names
all_flows$source <- trimws(all_flows$source)
all_flows$target <- trimws(all_flows$target)

# Convert source and target to factors for proper handling in networkD3
all_flows$source <- as.factor(all_flows$source)
all_flows$target <- as.factor(all_flows$target)

# Create a unique list of all nodes (locations)
nodes <- data.frame(name = unique(c(as.character(all_flows$source),
                                    as.character(all_flows$target))))

# Map node names to zero-indexed integers (required by networkD3)
# We subtract 1 because networkD3 expects 0-indexed IDs.
links_data <- data.frame(
  source = match(as.character(all_flows$source), nodes$name) - 1,
  target = match(as.character(all_flows$target), nodes$name) - 1,
  value = all_flows$value
)

# Plot the Sankey diagram
sankey_plot <- sankeyNetwork(Links = links_data, Nodes = nodes,
                             Source = "source", Target = "target",
                             Value = "value", NodeID = "name",
                             units = "Participation Index", 
                             fontSize = 16, # Size of the node labels
                             nodeWidth = 30, # Width of the nodes
                             width = 1000,
                             height = 600) 

# Display the plot
sankey_plot
htmlwidgets::saveWidget(sankey_plot, file = "sankey_diagram_496.html")

------------------------------
  # Improved chart
  
  # Nodes and links colour
  node_colors <- paste0("d3.scaleOrdinal(d3.schemeCategory10).domain([",
                        paste0("'", nodes$name, "'", collapse = ", "), "])")
links_data$group <- all_flows$source

sankey_plot_attractive <- sankeyNetwork(Links = links_data, Nodes = nodes,
                                        Source = "source", Target = "target",
                                        Value = "value", NodeID = "name",
                                        units = "Participation Index",
                                        fontSize = 12,
                                        nodeWidth = 30,
                                        colourScale = node_colors,
                                        LinkGroup = "group",
                                        NodeGroup = "name",
                                        width = 1200,
                                        height = 800)
sankey_plot_attractive
# htmlwidgets::saveWidget(sankey_plot_attractive, file = "sankey_diagram_attractive.html", selfcontained = TRUE)
