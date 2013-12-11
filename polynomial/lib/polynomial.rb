class Polynomial
  attr_accessor :coeffs
  def initialize(elements=[])
    @coeffs=elements.reverse
    raise ArgumentError, /Two or more coefficients are required/ unless @coeffs.length>1
  end

  def to_s
    n=coeffs.length-1
    poly_str = plus_minus(coeffs[n],true)+coeff_to_s(coeffs[n])+get_x(coeffs[n],n)
    (n-1).downto(0).each do |x|
      poly_str = poly_str+plus_minus(coeffs[x],false)+coeff_to_s(coeffs[x])+get_x(coeffs[x],x)
    end
    poly_str.empty? ? "0" : poly_str
  end
  def coeff_to_s(coeff)
    (coeff).abs>1 ? coeff.to_s : ""
  end
  def get_x(coeff,p)
    if p==0 || coeff.abs==0
      ""
    elsif coeff.abs>0 && p==1
      "x"
    elsif coeff.abs>0
      "x^#{p}"
    end
  end
  def plus_minus(coeff,first_term)
    if first_term
      coeff == -1 ? "-" : ""
    else
      if coeff==0
        ""
      elsif coeff<0
        ""
      else
        "+"
      end
    end
  end
end
