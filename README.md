# Sheffield-spatial-pattern-mining

This study is a part of MSc Data Science dissertation "Exploring the Spatial Relationship Between Air Quality Diffusion Tube Monitoring Locations and Vulnerable Communities in Sheffield" at the University of Sheffield.

The aim of this study is to examine the spatial co-location patterns between diffusion tubes and sensitive areas such as schools, hospitals, kindergartens, and care homes. It applies advanced spatial data mining and co-location pattern mining techniques to assess the spatial relationship between diffusion tube monitoring sites and vulnerable communities, identifying critical gaps in coverage.

## 🎯 Research Goal
The central aim is to use spatial data mining to enhance environmental monitoring and public health outcomes in Sheffield by ensuring monitoring efforts are concentrated where vulnerable populations are most at risk.

## ❓Research Questions & Objectives
This study addresses the following key questions and aims:
- Question 1:	Are there significant gaps in the current monitoring network where sensitive areas are not adequately covered?
- Question 2:	What are the prevalent patterns of diffusion tube placement in relation to sensitive communities in Sheffield?
- Objective 3:	Extract maximal co-location patterns to reveal the most comprehensive spatial associations.
- Objective 4:	Analyse non-prevalent co-location patterns to detect areas where diffusion tube coverage is insufficient relative to sensitive locations.

## ⚙️ Libraries
1. Geospatial Processing:	geopandas, osmnx, shapely
2. Spatial Statistics: libpysal, esda
3. Pattern Mining:	itertools, mlxtend
4. Visualisation:	folium, matplotlib.pyplot
5. Utility:	scipy.spatial (cKDTree)

## 🔬 Methodology: Spatial Co-location Pattern Mining
The project follows a rigorous six-step methodology focused on transforming raw spatial data into actionable insights regarding coverage equity.
1. Data Preparation
- Projection: All geospatial data is transformed from WGS84 (EPSG:4326) to the British National Grid (BNG - EPSG:27700) for accurate distance calculations.
- Geometry Transformation: All heterogeneous feature types (Polygons, Multi-Polygons, Lines) are standardised to single-point geometries (centroids) to facilitate efficient Euclidean distance-based neighbourhood calculations.
2. Determining Distance Threshold

The optimal distance threshold for determining spatial proximity between features is calculated based on the inherent spatial characteristics of the Sheffield study area.

3. Co-location Patterns Mining
- Neighbourhood Graph Construction: A k-d tree query is used to efficiently identify potential neighbours.
- Prevalent Pattern Generation (Size-2): A star-based approach is employed to identify size-2 patterns.
- Prevalent Pattern Generation (Size-k): The Apriori-like algorithm is used for candidate generation and pruning to find larger co-occurring patterns 
4. Maximal Pattern Mining

Identifies the Maximal Prevalent Patterns—the largest and most comprehensive spatial associations between diffusion tubes and various types of sensitive locations.

5. Non-Prevalent Pattern Analysis

Identifies spatial features that are not co-located with monitoring sites, directly highlighting the insufficiency in diffusion tube coverage relative to the distribution of vulnerable communities.

