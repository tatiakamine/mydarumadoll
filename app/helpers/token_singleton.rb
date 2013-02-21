require 'singleton'

class TokenSingleton
  include Singleton
   
  def generateToken
    return Digest::SHA1.hexdigest([Time.now, rand].join)
  end  
  
end