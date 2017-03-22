TextPredictor: a next word predictor algorithm
========================================================
author: Len Greski
date: 22 March 2017
autosize: true

Overview
========================================================

Over four million texts, new algorithms and packages to consider, and a new problem domain. The Capstone project for the Johns Hopkins Data Science Specialization is the ultimate experience in the <em>hacker mentality</em>. 

<strong>Problem:</strong> build a Shiny application that predicts the next word in a phrase or sentence, using the Heliohost corpus as the basis for predictions. The work product includes:

- A text prediction algorithm, based on natural language processing techniques
- A Shiny application that takes text input and predicts a single word
- An R Presenter presentation that describes the algorithm and Shiny app

textPredictor: Algorithm 
========================================================

Given the constraints of Shiny, the algorithm and supporting data need to fit within a 1 gigabyte memory space. As a text predictor application, once data is loaded, end users expect subsecond response time. Therefore, we chose a <em>backoff model</em> as our algorithm to predict the next word in a string entered by the user. 

- Parse the input string
- Extract right most words, up to four words: predict 5th. If no match in database,
- Extract n - 1 words, if no match, repeat down to 1 word
- If no match, return a randomly selected word from the top 20 words in the corpus 

<em>Database:</em> An R data frame built with the data.table package for high performance due to its indexing feature. 

textPredictor: Processing the Data
========================================================

- Info about processing the data goes here 

textPredictor: the App
========================================================

- screenshot goes here
