class AuthService
    def self.encode_token(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
  
    def self.decode_token(token)
      JWT.decode(token, Rails.application.secrets.secret_key_base)[0]['user_id']
    rescue JWT::DecodeError
      nil
    end
end