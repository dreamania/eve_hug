class Comment < ActiveRecord::Base
  belongs_to :user
  
  scope :published, -> { where(status: "show") } 
  def post_message
    self.message
  end
  
  def post
    user = self.user
    api = Koala::Facebook::API.new(self.user.authentications.first.token)
    # pictures = %w(posting_img posting_01 posting_02 posting_03)
    #  picture = "#{Rails.root.to_s}/app/assets/images/#{pictures.shuffle.last}.jpg"
    begin 
      api.put_wall_post(self.post_message)
    rescue Koala::Facebook::AuthenticationError
      Rails.logger.info "@@@@@@@@@@@@@@@@@"
      Rails.logger.info "Koala::Facebook::AuthenticationError"
      Rails.logger.info "@@@@@@@@@@@@@@@@@"
    end
  end
end
