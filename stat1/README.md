# Statistics 1: Introduction to ANOVA, Regression, and Logistic Regression

## Chapter 1 Concepts

### GLM:
- Continuous reponse + normal distribution of errors
- A linear function of input predictors multiplied by betas
- epsilon accounts for the errors in our model

- when predictor variables are categorical, we will use ANVOA
- changing how the level of predictors will change the response variable


- if response variable is binary, we will use logistic regression
- the logit of Y is a linear function of predictor variables and betas


### Explanatory vs Predictive
Explanatory --> Inferential  
how is X related to Y  
tend to have small sample sizes  
is assessed mainly using p-values and confidence intervals  

  

  
Predictive --> future values  
making accurate predictions  
use holdout (validation and testing) datasets  
tend to have large samples and many variables  


### Inferential Review

Population parameters and Sample Statistics
- Greek letters for Population, English letters for Sample
- Here we are interested in random samples such that we build point estimates of the population

Normal Distribution (Gaussian)
- central limit theorem
- subsets of means approximates the normal distribution
- With sampling, we get a Standard Error of the mean, which is $\frac{\sigma}{\sqrt{n}}$
- Hence, larger samples equal lower standard errors of the mean

Confidence Intervals
- The X percentage of our sample means drawn from infinite number of means will contain the true population mean

Hypothesis Testing
- null hypothesis : equality
- alternative hypothesis : inequality
- a low p-value casts doubt on the null hypothesis
- but a p-value above a threshold simply allows us to fail to reject the null hypothesis, not conclude that the null hypothesis is actually true
- thus: when we reject the NULL HYPOTHESIS when it is actually true, we commit a TYPE I error
- when we fail to reject the NULL HYPOTHESIS when it is actually false, we commit a TYPE II error

P-Value
- it is effected by effect size as well as sample size
- effect size is the difference between the observed statistic and the hypothesized value
- smaller p-values reflect the confidence that comes with larger sample sizes


### One Sample T-Tests

Comparing a mean from a sample to a hypothesized mean
- sigma is unknown
- we need to use the Student's T Distribution
- we need to use the t-value
- we can do this in SAS by using the `proc ttest;`


### Two Sample T-Tests

Comparing the means from two populations and whether they are equal or differ
- is there a difference in the mean from one another
- null hypothesis : u1 = u2 or u1 - u2 = 0
- alternative hypothesis : u1 != u2

- some assumptions
  - observations of two sample are independent 
  - normally distributed populations for the two samples
  - we need equal population variances of the two samples
- we can test for equal variance using the F Test for Equality of Variances
- F Value is close to 1, we fail to reject the alternative that the two variances are unequal
- `PROC TTEST` is also used for two sample ttest : use `class var` to create the two samples for two sample t-test


