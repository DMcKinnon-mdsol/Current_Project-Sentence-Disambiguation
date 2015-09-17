# word-counter
counts words given arbitrary text document
I have more information to put in here.
Lists words, their frequency, and location based on sentences from given text doc.
  # Right now...
  # The way the file is opened and read, it could freeze the host if file is too big.
  # I need to figure out a way to get the location of every word.
  # Will not work with languages other than English
  #
  # 	tried tactful_tokenizer but it was not accurate enough.
  #	tactful_tokenizer from https://github.com/zencephalon/Tactful_Tokenizer
  #	m = TactfulTokenizer::Model.new
