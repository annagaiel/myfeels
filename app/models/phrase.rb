class Phrase < ActiveRecord::Base
  belongs_to :user

  validates :phrase, presence: true
  validates :author, presence: true
  validates :background, presence: true
  validates :foreground, presence: true
  validates :font, presence: true

  has_many :comments, dependent: :destroy
end
