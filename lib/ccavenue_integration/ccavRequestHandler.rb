
require 'helper'

class CcavRequestHandler < ActionView::TestCase    
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

    def test_encrypt_decrypt_reversibility_with_merchant_data
        command            = "initiateTransaction"
        access_code        = ''   #Shared by CCAVENUES
        submit_url         = :submit_url
        merchant_id        = :merchant_id           
        order_id           = :order_id             
        currency           = :currency
        amount             = :amount
        redirect_url       = :redirect_url
        cancel_url         = :cancel_url
       # integration_type   = ''
        language           = :language
        billing_name       = :billing_name
        billing_address    = :billing_address
        billing_city       = :billing_city
        billing_state      = :billing_state
        billing_zip        = :billing_zip
        billing_country    = :billing_country
        billing_tel        = :billing_tel
        billing_email      = :billing_email
        billing_notes      = :billing_notes
        merchant_param1    = :merchant_param1
        merchant_data      = "merchant_id=#{merchant_id}&order_id=#{order_id}&amount=#{amount}&currency=#{currency}&redirect_url=#{redirect_url}&cancel_url=#{cancel_url}&language=#{language}&billing_name=#{billing_name}&billing_address=#{billing_address}&billing_city=#{billing_city}&billing_state=#{billing_state}&billing_zip=#{billing_zip}&billing_country=#{billing_country}&billing_tel=#{billing_tel}&billing_email=#{billing_email}&billing_notes=#{billing_notes}&merchant_param1=#{merchant_param1}"
        cipher_text        = CCAvenue::Crypto.encrypt(merchant_data, @encryption_key)
        assert_not_equal merchant_data,cipher_text
        decrypted_text     = CCAvenue::Crypto.decrypt(cipher_text, @encryption_key)
        assert_equal merchant_data, decrypted_text
    end
end
