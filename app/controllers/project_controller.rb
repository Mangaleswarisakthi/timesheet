class ProjectController < ApplicationController
before_action :authenticate_user!
  def index
	#@project=Proj.order("title").page params[:page]
	@project=Proj.order(:title).page(params[:page]).per(5)
 ' if params[:title]
    @project = Proj.tagged_with(params[:title])
  else
    @project = Proj.all
  end
  @project = @project.order(created_at: :desc).paginate(page:params[:page], per_page: 3 )'
  end
def create
	@project=Proj.new(add_params)
	if @project.save
		flash[:notice]='Success'
		redirect_to root_path
	else
		flash[:notice]='Not Success'
		render :new
	end
	
end
def edit
 	@project = Proj.find_by_id(params[:id])
end
def update
	@project=Proj.find(params[:id])
	if @project.update_attributes(add_params)
		flash[:notice] = 'Your Details Successfully Updated!'	
	else
		flash[:error] = 'Sorry Updation is Failed!'
	end
	redirect_to root_path
	
end
def alltask
	@project=Proj.new
	@projects=Proj.order(:title).page(params[:page]).per(5)
	

end

def destroy
	@project=Proj.find_by(params[:id])
	flash[:alert] = 'not deleted!'
	if @project.delete
		flash[:alert] = 'Deleted'
		
	end		
	
	@project=Proj.all
	redirect_to root_path
end
def new
	@project=Proj.new
	#@project=Proj.tasks.build
end 
  def show
	@project=Proj.find_by(id: params[:id])
  end

def uptasks
@projects=Proj.order(:title).page(params[:page]).per(5)
	@taskdate=params[:obj][:taskdate]
	@tasks=params[:proj][:tasks_attributes]
	sum=0
	count=0
	valid=0
	@tasks.each do |i|
	j=@tasks[i]
	sum += j["duration"].to_i
	if j["title"].blank? || j["duration"].blank?
		valid+=1
	end
	count+=1
	end
t=8-Task.where(:taskdate => @taskdate).sum(:duration)	
	if sum > 8 || sum > t || @taskdate.blank? || valid>0
		if sum > 8 
			flash[:notice] = 'Sry Only 8 hours should be Updated'
		elsif sum > t
			if t > 0
				flash[:notice] =" #{@taskdate} have Your Remaining hours #{t}"
			else 
				flash[:notice] ="Sry No Remaining Hours for You #{@taskdate}"
			end
		elsif @taskdate.blank?
			flash[:notice] ="Please Select Date"
		else
			flash[:notice] ="Pls Enter all Fields"
		end

	@project=Proj.new()
	count.times {@project.tasks.build}
	count=0
	@tasks.each do |i|
		j=@tasks[i]
		@project.tasks[count].proj_id = j["proj_id"]
		@project.tasks[count].title = j["title"]
		@project.tasks[count].desc = j["desc"]
		@project.tasks[count].duration=j["duration"]
		count+=1
	end
		count = 0
		render 'alltask'		
	else
	@tasks.each do |i|	
	j=@tasks[i]
	@task=Task.create(
		:proj_id => j["proj_id"],
		:taskdate => @taskdate,
		:title => j["title"],
		:desc => j["desc"],
		:duration => j["duration"]
		)
	if @task.save

		flash[:notice] = 'Your Details Successfully Updated!'
	else
		flash[:error] = 'Sorry Updation is Failed!'
	end

		
end


redirect_to '/project/alltask'
end
end
  
def add_params
	params.require(:proj).permit(:title, :desc, :id, :tasks_attributes => [:id, :proj_id, :taskdate, :title, :desc, :duration, :_destroy] )

end

end
