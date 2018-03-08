class Proj < ApplicationRecord
	has_many :tasks, dependent: :destroy
#attr_accessor :duration, :tasks_attributes

accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc { |attributes| attributes['title'].blank? }

validates :title, presence: true 
	validates :desc, presence: true 
validates_associated :tasks	


'validate :total, on: :create
def total
	#invoices.map(&:duration).sum
	t=self.tasks.sum(:duration)
	if t > 9
		errors.add(:duration, "error")
	end	
end

#validate :calculate_and_store_amount

 before_save :calculate_and_store_amount    
                          # the critical code 2/2

 private    
  def calculate_and_store_amount
    # may include amounts of items you marked for destruction
  #  self.duration = tasks.collect(&:duration).sum
	#t=self.tasks.sum(:duration)
	self.tasks.each do |task|
	unless task.sum(:duration) > 9
		errors.add(:duration, "error")
	end
		
  end
validate_associa :my_custom_validation

def my_custom_validation
 errors.add_to_base("error message") if sum(:duration) > 8

end	
 validates_associated :count
private
def count
	t=self.tasks.sum(:duration)
	if t > 9
		errors.add(:duration, "error")
	end
end




def validate_total(proj, task)
    totals = invoice.task.sum(:duration)

    if totals > 8
      invoice.errors.add(:total, " should be lower or equal to the total amount of the invoice")
      return false # I think you can alternatively raise an exception here
  end
end'
end
