# word-counter
Lists words, the frequency in which they appear, and location based on sentence number from given text doc.
Issues right now...The way the file is opened and read, it could freeze the host if file is too big. Will not work with languages other than English. Will not show how many times a given word will show up in which line.

I decided to take all punctuation out of the given text...explanation below:

	# http://stackoverflow.com/questions/25454391/regex-match-that-will-ignore-punctuation-within-the-string
 #	pot_sentences.downcase.gsub!(/[^\w\s]/, '')
	# I've decided to remove all punctuation from each tokenized sentence
	# so that I can count the values. I realize that many hyphened words will
	# not be calculated properly, also words with apostrophes such as we're vs 
	# were but I could not find a word tokenizer that made me feel confident in 
	# saying that words tokenized from given sentences would be correctly tabulated 
	# anyway. I thought that words that are abbreviated, such as USA, would fit better 
	# against their counterpart U.S.A. This also took care of the problem at the end 
	# of each sentence, where punctuation could be a factor, as well as quotes or 
	# parentheses. While it is not 100% accurate, I can say with more certainty and 
	# better understanding what words will be returned and IMO would be easier to read.
