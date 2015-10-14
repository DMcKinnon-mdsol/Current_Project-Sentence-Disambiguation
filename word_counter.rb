require 'pragmatic_segmenter'

def word_counter
	# Lists words, their frequency, and location based on sentence # from given text doc.
	# The way the file is read, it could freeze the host if file given is too big.
	# Will not work with languages other than English
	#
	# Created 9/16/2015
	# Author: Nitro7777
	# find a way to turn this into a class
	
	# setting new values
	h = Hash.new(0)
	i = 0
	alph = "a".ord
	pot_sentences, words = [], []

	# Testing to make sure the arg after program name is a txt file that exists
	# need to make sure to start throwing/raising real error signs
	case 
	when ARGV[0].nil?
		puts "Please enter a filename following the program name."
		puts "Exitting Program"
		exit(0)
		# raise error no text file
	when !(File.exist?(ARGV[0]))
		puts "Could not find file #{ARGV[0]}"
		puts "Exitting Program"
		exit(0)
		# raise error text file DNE in current directory
	when ARGV[0].to_s.scan(/[.txt']/)
		# https://github.com/diasks2/pragmatic_segmenter
		# GitHub UN: diasks2
		txt = File.open(ARGV[0], "r+")
		ps = PragmaticSegmenter::Segmenter.new(text: txt.read)
		pot_sentences = ps.segment
		txt.close
		# adjust here so that File Open closes automatically
	else
		puts "Something is wrong."
		puts "Exitting program"
		exit(0)
		# raise error - undefined problem
	end
	
	# replacing everything that is not a word with nothing
	pot_sentences.map! { |elmt| elmt.downcase.gsub!(/[^\w\s]/, '') }

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
