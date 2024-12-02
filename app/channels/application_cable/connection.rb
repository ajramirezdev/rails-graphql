module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      token = request.params[:token]
      Rails.logger.debug("Token received: #{token}")

      self.current_user = authenticate_user_from_token(token)

      if current_user
        Rails.logger.debug("Authenticated as: #{current_user.first_name}")
      else
        Rails.logger.debug("Failed to authenticate user")
        reject_unauthorized_connection
      end
    rescue => e
      Rails.logger.error("Connection error: #{e.message}")
      reject_unauthorized_connection
    end

    private

    def authenticate_user_from_token(token)
      return nil if token.blank?

      begin
        decoded_token = JWT.decode(token, "my_secret", true)
        user_id = decoded_token[0]["user_id"]
        user = User.find_by(id: user_id)

        if decoded_token[0]["exp"] < Time.now.to_i
          logger.error("Token has expired")
          nil
        end

        user

      rescue JWT::DecodeError => e
        logger.error("JWT Decode Error: #{e.message}")
        nil
      rescue JWT::ExpiredSignature => e
        logger.error("JWT Expired Error: #{e.message}")
        nil
      end
    end
  end
end
