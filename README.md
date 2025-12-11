# Reproduction: Kim & Kim (2022 *PNAS*) | UCSD PSYC201A

written by **Jinwoo Lee** ([jil527@ucsd.edu](jil527@ucsd.edu))

> [!NOTE]
> - original paper: [https://doi.org/10.1073/pnas.2205162119](https://doi.org/10.1073/pnas.2205162119) 
> - preregistration: [https://doi.org/10.17605/OSF.IO/38WV4](https://doi.org/10.17605/OSF.IO/38WV4)
> - final reproduction report: [https://psyc-201.github.io/kim2022/](https://psyc-201.github.io/kim2022/)

This repository serves as a workspace for the Reproduction Project in UCSD PSYC201A. The goal of this project is to reproduce the following key findings reported in **Kim & Kim (2022, *PNAS*)**:

> **Younger adults:** “Mantel tests revealed that the left amygdala-ventral PFC tract-morphology dissimilarity matrix was significantly correlated with the trait-anxiety dissimilarity matrix.”          
> **Older adults:** “Tests on the older adult sample also depicted a significant correlation between the trait-anxiety dissimilarity matrix and the left amygdala-ventral PFC tract-morphology dissimilarity matrix.”  


## Code Availability
All dependencies required to run the code are stored in a **Pixi-based** virtual environment named ‘kim2024’ (note: “2024” is a typo of “2022” in the original naming). To set up and use the environment, please follow the steps below:     

1. Clone the GitHub repository: `git clone https://github.com/psyc-201/kim2022.git`.    
2. Activate the Pixi-based virtual environment in your local machine: `pixi shell`.    
3. When using Jupyter, select the kernel named “**Python (kim2024)**” or "**R**".    

Also, the key analytic package - `DIM` is on-going project in [UCSD SciMinds Research Studio](https://sciminds.stuido/). For this reason, the directory of `DIM` was not shared in this repository. For the sharing request, please contact the project lead: Jinwoo Lee ([jil527@ucsd.edu](jil527@ucsd.edu)).

## Data Availability    
This project assumes the presence of two datasets:

- **Preprocessed data for confirmatory analysis:** This data includes metadata, STAI-G-X2 self-report total scores, and tractgraphy-based imaging driven phenotypes. To request access to the data, please contact Dr. Justin Minue Kim ([minuekim@skku.edu](minuekim@skku.edu)), the corresponding author of Kim & Kim (2022 *PNAS*). Once you receive the data, place it in a folder named `data-from-authors` located in the top-level directory of this project.     

- **Raw data for exploratory analysis:** Exploratory analysis uses additional self-report scores - Emotion Regulation Questionnaire (ERQ), NEO Five-Factor Inventory (NEO-FFI), and Impulsive Behavior Scale (UPPS). You can download the full dataset at [the official website of LEMON dataset](https://fcon_1000.projects.nitrc.org/indi/retro/MPI_LEMON.html). Once you download the data, place it in a folder named `Behavioural_Data_MPILMBB_LEMON` located in the top-level directory of this project. 

## Contact    
For inquiries regarding this reproducibility project, please contact the project lead:
Jinwoo Lee ([jil527@ucsd.edu](jil527@ucsd.edu)).    

## References
Kim, W., & Kim, M. J. (2022). Morphological similarity of amygdala-ventral prefrontal pathways represents trait anxiety in younger and older adults. *Proceedings of the National Academy of Sciences, 119*(42), e2205162119.   