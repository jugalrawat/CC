module Digest
  
  class MD5

   
    def self.sha1(data, opts={})
      data = data.to_s
      if opts[:binary]
        OpenSSL::Digest::SHA1.digest(data)
      else
        OpenSSL::Digest::SHA1.hexdigest(data)
      end
    end

    # Returns the SHA224 digest for the data
    #
    # Shorcut alias: Gibberish::SHA224(data)
    #
    # @param [String] key
    # @param [#to_s] data
    # @param [Hash] options
    # @option opts [Boolean] :binary (false) encode the data in binary, not Base64
    def self.sha224(data, opts={})
      data = data.to_s
      if opts[:binary]
        OpenSSL::Digest::SHA224.digest(data)
      else
        OpenSSL::Digest::SHA224.hexdigest(data)
      end
    end

    # Returns the SHA256 digest for the data
    #
    # Shorcut alias: Gibberish::SHA256(data)
    #
    # @param [String] key
    # @param [#to_s] data
    # @param [Hash] options
    # @option opts [Boolean] :binary (false) encode the data in binary, not Base64
    def self.sha256(data, opts={})
      data = data.to_s
      if opts[:binary]
        OpenSSL::Digest::SHA256.digest(data)
      else
        OpenSSL::Digest::SHA256.hexdigest(data)
      end
    end

    # Returns the SHA384 digest for the data
    #
    # Shorcut alias: Gibberish::SHA384(data)
    #
    # @param [String] key
    # @param [#to_s] data
    # @param [Hash] options
    # @option opts [Boolean] :binary (false) encode the data in binary, not Base64
    def self.sha384(data, opts={})
      data = data.to_s
      if opts[:binary]
        OpenSSL::Digest::SHA384.digest(data)
      else
        OpenSSL::Digest::SHA384.hexdigest(data)
      end
    end

    # Returns the SHA512 digest for the data
    #
    # Shorcut alias: Gibberish::SHA512(data)
    #
    # @param [String] key
    # @param [#to_s] data
    # @param [Hash] options
    # @option opts [Boolean] :binary (false) encode the data in binary, not Base64
    def self.sha512(data, opts={})
      data = data.to_s
      if opts[:binary]
        OpenSSL::Digest::SHA512.digest(data)
      else
        OpenSSL::Digest::SHA512.hexdigest(data)
      end
    end

    # Returns the MD5 digest for the data
    #
    # Shorcut alias: Gibberish::MD5(data)
    #
    # @param [String] key
    # @param [#to_s] data
    # @param [Hash] options
    # @option opts [Boolean] :binary (false) encode the data in binary, not Base64
    def self.md5(data, opts={})
      data = data.to_s
      if opts[:binary]
        OpenSSL::Digest::MD5.digest(data)
      else
        OpenSSL::Digest::MD5.hexdigest(data)
      end
    end
  end

  def self.md5(data, opts={})
      data = data.to_s
      if opts[:binary]
        OpenSSL::Digest::MD5.digest(data)
      else
        OpenSSL::Digest::MD5.hexdigest(data)
      end
    end
	
  def self.SHA1(data, opts={})
    Digest.sha1(data,opts)
  end

  def self.SHA224(data, opts={})
    Digest.sha224(data,opts)
  end

  def self.SHA256(data, opts={})
    Digest.sha256(data,opts)
  end

  def self.SHA384(data, opts={})
    Digest.sha384(data,opts)
  end

  def self.SHA512(data, opts={})
    Digest.sha512(data,opts)
  end

  def self.MD5(data, opts={})
    Digest.md5(data,opts)
  end

end