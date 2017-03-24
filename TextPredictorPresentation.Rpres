TextPredictor: a next word predictor algorithm
========================================================
author: Len Greski
date: 23 March 2017
autosize: true

Overview
========================================================
<small>
Over four million texts, new algorithms and packages to consider, and a new problem domain. The Capstone project for the Johns Hopkins Data Science Specialization is the ultimate experience in the <em>hacker mentality</em>. 

<strong>Problem:</strong> build a Shiny application that predicts the next word in a phrase or sentence, using the Heliohost corpus as the basis for predictions. The work product includes:

- A text prediction algorithm, based on natural language processing techniques
- A Shiny application that takes text input and predicts a single word
- An R Presenter presentation that describes the algorithm and Shiny app
</small>

textPredictor: Algorithm 
========================================================

<small>
Given the constraints of Shiny, the algorithm and supporting data need to fit within a 1 gigabyte memory space. As a text predictor application, once data is loaded, end users expect subsecond response time. Therefore, we chose a <em>backoff model</em> as our algorithm to predict the next word in a string entered by the user. 

1. Parse the input string, and count the number of words
2. Extract right most words, up to four words: predict 5th. If no match in database,
3. Extract n - 1 words, if no match, repeat down to 1 word
4. If no match, return a randomly selected word from the top 20 words in the corpus 

<em>Database:</em> An R data frame built with the <code>data.table</code> package for high performance due to its indexing feature. 
</small>

textPredictor: Processing the Data
========================================================

We used a 3 step process to build the database used for our prediction algorithm, including:

1. Read data files from the [Heliohost Corpora](http://www.corpora.heliohost.org/aboutcorpus.html), clean, and generate n-grams
2. Split n-grams into base and prediction components and aggregate frequency counts
3. For each unique base component, select the most frequently occurring prediction and write to output data frame

Due to the large size of the corpus (over 4 million texts) data was processed by type of text (blogs, news, twitter) and combined in step 3 above. Code for the project is located on the lgreski/dssCapstone github repository: https://github.com/lgreski/dssCapstone 

textPredictor: the App
========================================================


<img src="./TextPredictorPresentation-figure/textPredictorApp.png">

<small>Access the app at https://lgreski.shinyapps.io/textPredictor
