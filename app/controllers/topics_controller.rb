class TopicsController < ApplicationController
	before_action :find_topic, only: [:show,:edit,:update,:destroy]

	def index
		if params[:category].blank?  #if the category params are empty
		  @topics= Topic.all.order("created_at DESC") #show all the topics
		else
			@category_id = Category.find_by(name: params[:category]).id #find the category_id
			@topics = Topic.where(category_id: @category_id).order("created_at DESC") #loop through the jobs that have that ID 
		end
	end


	def show
	end


	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)

		if @topic.save
			redirect_to @topic
		else 
			render "new"
		end
	end


	def edit
	end

	def update


		if @topic.update(topic_params)
			redirect_to @topic
        else
        	render "edit"
		end
	end	

	def destroy

		 @topic.destroy

		 redirect_to root_path

	end


	private
		def topic_params
			params.require(:topic).permit(:title,:content,:category_id)
		end

		def find_topic
		  @topic = Topic.find(params[:id])
		end



end
