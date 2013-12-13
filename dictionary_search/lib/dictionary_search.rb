class DictionarySearch
  attr_accessor :pairs

  def initialize(file_path)
    @file_path = file_path
    @pairs = []
    @pair_found = {}
    process_word_pairs
  end

  def word_pairs
    pairs
  end

  def process_word_pairs
    swap_word = ""
    @dictionary = File.open(@file_path)
    @dictionary.each do |line|
      word = line.strip
      if word.length > 2 && !identical_word?(word)
        swap_word = word[0..-3]+word[-1]+word[-2]
        if @pair_found[swap_word] == true
          @pairs << [word, swap_word]
        else
          @pair_found[word] = true
        end
      end
    end
  end

  def identical_word?(word)
    word[-1] == word[-2]
  end

end
