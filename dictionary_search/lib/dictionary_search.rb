class DictionarySearch
  attr_accessor :dictionary, :pairs, :pair_stored

  def initialize(file_path)
    @dictionary = {}
    @pairs = []
    @pair_stored = {}
    File.open(file_path, "r") do |f|
      while (line = f.gets)
          line = line.strip
          @dictionary[line] = swap_last_two(String.new line) unless line.length <= 2 || identical_word?(line)
      end
    end
  end

  def word_pairs
    @dictionary.each do |word, swap_word|
     if @dictionary.key?(swap_word) && !stored_pair?(word,swap_word)
       @pairs << [word, swap_word] 
       @pair_stored[word] = swap_word
     end
    end
    @pairs
  end

  def stored_pair?(word,swap_word)
    (@pair_stored.key?(word) || @pair_stored.key?(swap_word) || @pair_stored.value?(word) || @pair_stored.value?(swap_word))
  end

  def swap_last_two(word)
    word[-1], word[-2] = word[-2], word[-1]
    word
  end

  def identical_word?(word)
    if word.length>2
      word2=swap_last_two(String.new(word))
      word2==word
    else
      true
    end
  end

end
