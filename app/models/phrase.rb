class Phrase < ActiveRecord::Base
  belongs_to :user

  validates :phrase, presence: true
  validates :author, presence: true
  validates :background, presence: true
  validates :foreground, presence: true
  validates :font, presence: true

  has_many :comments, dependent: :destroy

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :inspirationals
end
