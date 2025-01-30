# Fill here the code to estimate the linear_model3 from the notebook
c<-ggplot(data= db_int, 
          mapping = aes(y=totalHoursWorked, x="")) +
  theme_bw() +
  geom_boxplot()  +
  ggtitle("")+
  ylab("Total Hours Worked")+
  xlab("")

low <- mean(db_int$totalHoursWorked) - 2* sd(db_int$totalHoursWorked)
up <- mean(db_int$totalHoursWorked) + 2* sd(db_int$totalHoursWorked)
grid.arrange(b, c, ncol = 2)

db_int<- db_int %>% mutate(out_totalHoursWorked=  ifelse( test=(totalHoursWorked< low | totalHoursWorked> up), 
                                                          yes= 1,
                                                          no= 0))
c <- c + geom_hline(yintercept = low,linetype="solid",color="red",size=0.7) +
  geom_hline(yintercept = up,linetype="solid",color="red",size=0.7)
