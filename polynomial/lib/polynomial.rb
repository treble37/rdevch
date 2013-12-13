class Polynomial
  attr_accessor :coeffs

  def initialize(elements = [])
    raise ArgumentError, "Two or more coefficients are required" unless elements.length > 1
    @coeffs = elements.reverse
  end

  def to_s
    n = coeffs.length - 1
    poly_str = ""
    (n).downto(0).each do |x|
      poly_str = poly_str + plus_minus(coeffs[x],n==x) + coeff_to_s(coeffs[x]) + get_x(coeffs[x],x)
    end
    
    poly_str.empty? ? "0" : poly_str
  end
  
  def coeff_to_s(coeff)
    if coeff.abs<=1
      ""
    else
      coeff.abs.to_s
    end
  end
  
  def get_x(coeff,p)
    if p == 0 || coeff == 0
      ""
    elsif coeff.abs>0 && p == 1
      "x"
    elsif coeff.abs>0
      "x^#{p}"
    end
  end

  def plus_minus(coeff,first_term)
    if coeff <= -1
      "-"
    elsif coeff == 0 || first_term && coeff >=1
      ""
    else
      "+"
    end
  end

end
