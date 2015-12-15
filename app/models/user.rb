class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :fullname, :presence => true, length: {maximum: 50, minimum: 2}

  has_many :phrases, dependent: :destroy
  has_many :comments
  has_one :cup

  after_create :create_cup
  def self.from_omniauth(auth)
    result = User.where(email: auth.info.email).first

    if result
      return result
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.fullname = auth.info.name
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.image = auth.info.image
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end

  private

  def create_cup
    Cup.create(user_id: self.id)
  end

end
