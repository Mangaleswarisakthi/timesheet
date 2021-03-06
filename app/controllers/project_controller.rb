class ProjectController < ApplicationController
before_action :authenticate_user!
  def index
	@project=Proj.new
	@projects=Proj.order(:title).page(params[:page]).per(5)
  end
def create
	@project=Proj.new(add_params)
	if @project.save
		render :json => {success: "Project Successfully Added"}
	else
		render :json => {error: @project.errors.full_messages}
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
	has_errors = false
	rem=Array.new
	params[:proj][:tasks_attributes].values.each do |tast_attr|
		rem << tast_attr.except("_destroy")
	@tasks = Task.new(tast_attr.except("_destroy"))
		unless @tasks.valid?
			has_errors=true
			break
		end
	end
  sum1=params[:proj][:tasks_attributes].values.map {|hash| hash["duration"].to_i}.sum
  puts sum1
	 t=8-Task.where(:taskdate => @taskdate).sum(:duration)	
	if  sum1 > t || sum1>8 || has_errors==true
		if sum1>8
			render :json => {error: "Only 8 Hours Work will be Updated" }
		elsif sum1 > t
 			if t > 0
				render :json => {error: " #{@taskdate} have Your Remaining hours #{t}"}
 			else 
				render :json => {error: "Sry No Remaining Hours for You #{@taskdate}"}
			 end
		else
			render :json => {error: @tasks.errors.full_messages}
		end
	else	
		if Task.create(rem)
			result=render_to_string(:partial => '/project/view', :locals => {:@projects => @projects})
			render :json => {success: "Tasks Successfully Added", project: result}
		end
	end
end
def add_params
	params.require(:proj).permit(:title, :desc, :id, :tasks_attributes => [:id, :proj_id, :taskdate, :title, :desc, :duration, :_destroy])
end
def task_params
	params.require(:tasks_attributes).permit(:proj_id, :taskdate, :title, :desc, :duration, :_destroy)
end
end