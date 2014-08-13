require 'helper'
require 'ccavenue_integration'
class HomeController < ApplicationController
  #include ActionView::Helpers::NumberHelper
  
 

  def  index
   
     
  
 
  #num = (rand() * 10000).to_i
  n = 4067.to_i
  num=rand(n + 1).to_i
  
  orderID = num.to_s
  #currency= "EUR"
  amount = 1.to_s
  name =params[:name].to_s
   
    
    street_address = params[:street_address].to_s
    country = params[:country].to_s
    cell_phone = params[:cell_phone].to_s
    email = params[:email].to_s
    state = params[:state].to_s
    current_user_name = params[:current_user_name].to_s
    city = params[:city].to_s
    pincode = params[:pincode].to_s
    
   # orderID = to_query('orderID').to_s
   
   # amount = to_query('amount').to_s
    
   # name = to_query('name')
   # street_address = to_query('street_address')
   # country = to_query('country')
   # cell_phone = to_query('cell_phone')
    
   # email = to_query('email')
   # state = to_query('state')
   # current_user_name = to_query('current_user_name')
  #  city =to_query('city')
  #  pincode = to_query('pincode')
   

     redirectURL = "http://real.hostingcentre.in/ruby/test.php/transactions/"+orderID+"/ccavenue_redirect"

    checksum = getChecksum("M_demo1_1828", orderID, amount, redirectURL, "ekvb7aezafo9r38ikfdfzrvy6srsl8st")

    @ccaRequest = 

      "Merchant_Id=M_demo1_1828&"+

      "Amount="+amount+"&"+

     # "Currency="+currency+"&"+

      "Order_Id="+orderID+"&"+

		"Redirect_Url="+redirectURL+"&"+

      "billing_cust_name="+name+"&"+

      "billing_cust_address="+street_address+"&"+

      "billing_cust_country="+country+"&"+

      "billing_cust_tel="+cell_phone+"&"+

      "billing_cust_email="+email+"&"+

      "billing_cust_state="+state+"&"+

      "delivery_cust_name="+current_user_name+"&"+

      "delivery_cust_address="+street_address+"&"+

      "delivery_cust_country="+country+"&"+

      "delivery_cust_state="+state+"&"+

      "delivery_cust_tel="+cell_phone+"&"+

      "delivery_cust_notes="+"Note"+"&"+

      "billing_cust_city="+city+"&"+

      "billing_zip_code="+pincode.to_s+"&"+

      "delivery_cust_city="+city+"&"+

      "delivery_zip_code="+pincode.to_s+"&"+

      "Checksum="+checksum.to_s


  #Dir.chdir("c:/Sites/rails_projects/ccavenue/public/jar/") doC:\rails_project\CCAvenue_projMCPG\public\jar
  
    Dir.chdir("c:/rails_project/CCAvenue_projMCPG/public/jar/") do

      @encRequest = %x[java -jar ccavutil.jar #{'ekvb7aezafo9r38ikfdfzrvy6srsl8st'} "#{@ccaRequest}" enc]

    end
    
     # merchant_data      = "order_id=#{orderID}&amount=#{amount}&redirect_url=#{redirectURL}&name=#{name}"
     #  cipher_text        = CCAvenue::Crypto.encrypt(merchant_data, @encryption_key)
      #  assert_not_equal merchant_data,cipher_text
     #   decrypted_text     = CCAvenue::Crypto.decrypt(cipher_text, @encryption_key)
     #   assert_equal merchant_data, decrypted_text   
  
  
  def setup
        # replace this with your encryption key
        @encryption_key = '' #Shared by CCAVENUES
    end

    def test_encrypt_decrypt_reversibility
        sample_plain_text = "Sample Text with special characters like (,),*,&,^,%"
        cipher_text = CCAvenue::Crypto.encrypt(sample_plain_text, @encryption_key)
        assert_not_equal sample_plain_text,cipher_text
        decrypted_text = CCAvenue::Crypto.decrypt(cipher_text, @encryption_key)
        assert_equal sample_plain_text,decrypted_text
    end
  
  end
  
  
  
  
  
  
  def ccavenue_redirect

    @encResponse = params[:encResponse]

    @checksum = false

    @authDesc = false

    @p = nil

    @ccaResponse = nil

    if (params[:encResponse])

            if @encResponse

        Dir.chdir("c:/Sites/rails_projects/ccavenue/public/jar/") do

               @ccaResponse = %x[java -jar ravi-ccavutil.jar #{'ekvb7aezafo9r38ikfdfzrvy6srsl8st'} "#{@encResponse}" dec]

        end

        @p = Rack::Utils.parse_nested_query @ccaResponse

        if (!@p.nil? && @p["Merchant_Id"] && @p["Order_Id"] && @p["Amount"] && @p["AuthDesc"] && @p["Checksum"])

          @checksum = verifyChecksum(@p["Merchant_Id"], @p["Order_Id"], @p["Amount"], @p["AuthDesc"], 'ekvb7aezafo9r38ikfdfzrvy6srsl8st', @p["Checksum"])

          @authDesc = @p["AuthDesc"].eql?("Y") ? true : false

        end

      end

      if @checksum && @authDesc 

        transaction = Transaction.find(@p["Order_Id"])

        transaction.payment_confirmed = true

        transaction.save!

        message = current_buyer.user.name + "! Thank you for your order! It will soon be at your doorsteps!" 

        redirect_to root_path, :flash => {:success => message}

      else

        if !@authDesc

          message = current_buyer.user.name + "! Your bank did not authorize the transaction. Please go to Settings > My Orders page, and click on 'Pay Now' button to finish your transaction" 

          redirect_to root_path, :flash => {:error => message}

        else

          message = current_buyer.user.name + "! Oops! There was some error in retrieving your transaction confirmation. Please drop us an email at dealbuddie@dealbuddie.com for order confirmation."

          redirect_to root_path, :flash => {:error => message}

        end

      end

    else

      message = current_buyer.user.name + "! Oops! Something went wrong while processing your request. Please go to Settings > My Orders page, and click on 'Pay Now' button to finish your transaction."

      redirect_to root_path, :flash => {:success => message}

    end

  end
  
  def getChecksum( merchantID,  orderID,  amount,  redirectUrl,  workingKey) 

    String str = merchantID + "|" + orderID + "|" + amount + "|" + redirectUrl + "|" + workingKey;

    return Zlib::adler32(str)

  end  
  
  def verifyChecksum( merchantID,  orderID,  amount,  authDesc,  workingKey,  checksum) 

    String str = merchantID+"|"+orderID+"|"+amount+"|"+authDesc+"|"+workingKey

    String newChecksum = Zlib::adler32(str).to_s

    return (newChecksum.eql?(checksum)) ? true : false

  end
    



end
