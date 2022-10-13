class Post < ApplicationRecord
   validates :title, presence: true
   validates :content, length: {minimum: 250}
   validates :summary, length: {maximum: 250}
   validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
   validate :validate_is_clickbaity

   def validate_is_clickbaity
      return if title.nil?
      clickbait = [
         /Won't Believe/,
         /Secret/,
         /Top \d/,
         /Guess/
      ]
      is_valid = clickbait.any? { |string| self.title.match?(string) }
      errors.add(:title, "not sufficiently clickbait-y") unless is_valid
   end
end
