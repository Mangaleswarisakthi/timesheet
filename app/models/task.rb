class Task < ApplicationRecord
 	 belongs_to :proj, required: false, optional: true
	validates :taskdate, presence: true
	validates :title, presence: true 
	validates :desc, presence: false
	validates :duration, presence: true, :inclusion => { :in =>1.0..8.0 }, numericality: true
	#validate :validate_total
	' def validate_total()
    totals = proj.tasks.sum(:duration)

    if totals > 8
      proj.errors.add(:total, " should be lower or equal to the total amount of the invoice")
      return false # I think you can alternatively raise an exception here
  end
end'
end
