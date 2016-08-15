module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      current_user = Vertigo::Rtm.user_class.find_by(id: cookies.signed[:user_id])

      if current_user.present?
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
