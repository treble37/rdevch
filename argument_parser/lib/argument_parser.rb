class ArgumentParser

  def initialize
  end

  def parse(args)
    raise_error(args)
    Tokenize.new(args).get_final_tokens
  end

  def raise_error(str)
    ErrorChecker.new(str).no_errors?
  end

end

class Tokenize
  attr_accessor :base_string, :tokens, :esc_tokens, :real_chars

  def initialize(base_string="")
    @base_string = base_string
    @tokens = []
    @esc_tokens = {
      /\|,/ => "<esc_comma>",
      /\|\{/ => "<esc_left_brace>",
      /\|\}/ => "<esc_right_brace>",
    }
    @real_chars = {
      /\<esc_comma\>/ => ",",
      /\<esc_left_brace\>/ => "{",
      /\<esc_right_brace\>/ => "}",
    }
  end

  def get_final_tokens
    esc = substitute_escape(base_string)
    tokens = tokenize(esc)
    real_tokens = substitute_real_chars(tokens)
    real_tokens
  end
  
  def substitute_escape(str)
    esc_tokens.each do |escape_sequence,token|
      str = str.gsub(escape_sequence,token)
    end
    str
  end

  def tokenize(str)
    tokens = str.split(/, /)
    tokens[0][0] = ""
    tokens[-1][tokens[-1].length-1] = ""
    tokens
  end

  def substitute_real_chars(tokens)
    tokens.each do |token|
      real_chars.each do |esc_token,replacement|
        token.gsub!(esc_token,replacement)
      end
    end
    tokens
  end
  
end

class ErrorChecker
  attr_accessor :base_string

  def initialize(str="")
    @base_string = str
  end
  
  def no_errors?
    raise ArgumentError, "Args list is invalid" unless conditions_met?
    true
  end

  def conditions_met?
    string? && matching_braces? && no_unescaped_braces? && correct_comma_spaces?
  end
  
  def string?
    base_string.instance_of?(String)
  end

  def matching_braces?
    base_string[0] == "{" && base_string[-1] == "}"
  end
  
  def no_unescaped_braces?
    (/\A{.*((?<!\|)[{}]).*}\Z/ =~ base_string).nil?
  end
  
  def correct_comma_spaces?
    (/(?<!\|),(?! )/ =~ base_string).nil?
  end

end
