# CSC151Final
Final project for the Introductory Computer Science course - Functional Problem Solving

Random Lyrics Generator

Primary Goal:
The primary goal is to write an algorithm that uses common preceding word phrases to produce song lyrics in a proper format
– verse, chorus, verse, chorus, bridge, chorus.

Data:
https://www.kaggle.com/rakannimer/billboard-top-lyrics-analysis/data

This data has 5,000 songs from 1965-2015. It is formatted in such a way where it has six columns: Rank, Song, Artists, Year,
Lyrics, and Source respectively. However, in ‘generate-lyrics-rhyme’ procedure, the dataset was altered to fit our code. 
We extracted the fifth column (lyrics) of every list of lists and outputted them together in a single file.

Algorithm & Analysis:
The ‘generate-paragraph-rhyme’ takes 3 parameters, end-word (a list of two strings), input-filepath, and num-of-lines. It uses
‘end-word’ to search through the extracted lyrics dataset to tally three-word phrases that appear before the two words in
‘end-word’ list. It randomly chooses one of the ten most common phrases and recurses this process until we have three phrases
to form a sentence. Each sentence ends with words that rhyme with ‘end-word’. And, ‘num-of-lines’ determines how many lines
the paragraph will have. By implementing ‘generate-paragraph-rhyme’ into ‘generate-lyrics-rhyme’, we were able to produce 
lyrics that followed the song format(verse, chorus, verse, chorus, bridge, and chorus).Our main procedure,
‘generate-lyrics-rhyme’ has 6 parameters, end-word-verse1, end-word-verse2, end-word-chorus, end-word-bridge, source-filepath,
and output-filepath. The parameters which start with ‘end-word’ (these parameters take a list of two strings) determines which
two words each body of the lyrics end with. For instance, if we pass end-word-verse1 as ‘(“hi” “beautiful”), then the words at
the end of each line of the first verse rhymes with ‘beautiful’, and the very last two words of the first verse are “hi” and
“beautiful”.
