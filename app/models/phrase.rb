class Phrase < ActiveRecord::Base
  belongs_to :user

  validate :phrase, presence: true
  validate :author, presence: true
  validate :background, presence: true
  validate :foreground, presence: true
  validate :font, presence: true

end
