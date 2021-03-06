class Product < ApplicationRecord

  has_many :line_items
  has_many :orders, through: :line_items
  has_many :comments, dependent: :destroy

  has_one_attached :image

  before_destroy :ensure_not_referenced_by_any_line_item

  # validates :title, :description, :image_url, presence: true
  # validates :title, :description, :image_data, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :title, length:{minimum: 10}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|png|jpg)\Z}i,
    message: 'must be a URL for GIF, PNG or JPG image.'
  }


  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:bass, 'Line Items present')
      throw :abort
    end
  end
end
