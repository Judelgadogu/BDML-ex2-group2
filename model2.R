
"
                              Modelo 2
                              --------
"


"
---------------------------
Alistar ambiente de trabajo: 
---------------------------
"

rm(list = ls())
cat("\014")

#Cargar paquetes: 

if(!require(pacman)) install.packages("pacman") ; require(pacman)


p_load(rio, # import/export data
       tidyverse, # tidy-data
       skimr, # summary data
       gridExtra, # visualizing missing data
       corrplot, # Correlation Plots 
       stargazer, # tables/output to TEX. 
       MASS # various statistical functions
)   

#Cargar datos: 
db <- import("https://github.com/ignaciomsarmiento/datasets/blob/main/GEIH_sample1.Rds?raw=true")
db <- as_tibble(db) %>% rename(gender=sex) 


"
---------------
Correr modelos: 
---------------
"

#Crear variables: 
db_of<- db %>% 
  group_by(oficio, gender)  %>% 
  summarise(ofic_ingLab= mean(y_ingLab_m, na.rm=T), .groups="drop") %>%
  mutate(ofic_ingLab= ofic_ingLab/1000000)

#merge with the original data set
db_int <- db %>% inner_join(db_of, by=c("oficio", "gender"))

#child indicator
db_int <- db_int %>%
  mutate(flag = ifelse(age <= 18, 1, 0))

#total number of children per household

db_int <- db_int %>%
  group_by(directorio, secuencia_p) %>%
  mutate(nmenores = sum(flag)) %>%
  dplyr::select(-flag) %>% 
  ungroup()

#the category 1 is Jefe de Hogar.

db_int <- db_int %>%
  mutate(H_Head = ifelse( p6050== 1, 1, 0))
"
re run the model
"
linear_model2<- lm(totalHoursWorked ~ ofic_ingLab + nmenores  +  nmenores*gender + H_Head + age + gender, data=db_int2 )
summary(linear_model2)
# el numero de niños crecio, el efecto de ingreso ocupados también (entre (1) y (2))

