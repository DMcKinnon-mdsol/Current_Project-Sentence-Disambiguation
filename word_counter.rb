require 'pragmatic_segmenter'
# how do you include a gem such as this so that the program will run on a given computer?

def word_counter
	# Lists words, their frequency, and location based on sentence # from given text doc.
	# The way the file is read, it could freeze the host if file given is too big.
	# Will not work with languages other than English
	#
	# Started 9/16/2015
	# Updated 2/14/2016
	# Author: Christopher Gabriel Manna
	# find a way to turn this into a class
	
	# setting new values
	h = Hash.new(0)
	i = 0
	alph = "a".ord
	pot_sentences = []
	words = []
	

	file_name = ARGV[0]
	if (File.extname(file_name).to_s == ".txt" && File.exist?(file_name))
		# https://github.com/diasks2/pragmatic_segmenter
		# GitHub UN: diasks2
		txt = File.open(file_name, "r+")
		ps = PragmaticSegmenter::Segmenter.new(text: txt.read)
		pot_sentences = ps.segment
		txt.close
		# pot_sentences
		# adjust here so that File Open closes automatically
	else
		puts "Something is wrong, please retry."
		puts "Exitting Program."
		exit(0)
	end


	# replacing everything that is not a word with nothing
	pot_sentences.map! { |elmt| elmt.downcase.gsub!(/[^\w\s]/, '') }
	# rewrite this

	# finding word without gramatical interruption and sorting vals
	# finding frequency for each word that appears and storing in hash
	pot_sentences.join(" ").scan(/[\w']+/).sort.each { |elmt| words << elmt }
	
	poss_words = words.uniq
	poss_words.each do |word|
		freq = 0 
		loc = []
		pot_sentences.each_with_index do |sentence, i|
			if sentence.include?(word)
				freq += 1
				loc << i.to_i + 1
			end
		end
		h[word] = [freq, loc.join(", ")]
	end
		
	# setting indent length for table formatting based on the longest word length
	# in the hash that has all the word keys.
	val = (h.keys.max_by(&:length)).length + 30 + (h.size / 26)
		
	# title of printed table, 
	printf "%-#{val + 1}s %s\n","Word List","Frequency & Locations"

	h.each do |k, v| 
		str = "" # resetting alpha value so as not to include previous
		
		((i / 26)+1).times {str += (alph + (i % 26)).chr}
			# dynamically increase list alphabetically and roll over at end of alpha
		
		printf("%s. %-#{val - str.length}s{%s:%s}\n", str,k,v[0],v[1]) 
			# dynamically create output table
		i += 1
			# increment through alpha
	end
end
word_counter
