
# Fill here the code to estimate the linear_model2 from the notebook
# re run the model
linear_model2<- lm(totalHoursWorked ~ ofic_ingLab + nmenores  +  nmenores*gender + H_Head + age + gender, data=db_int2  )
# el numero de niños crecio, el efecto de ingreso ocupados también (entre (1) y (2))

