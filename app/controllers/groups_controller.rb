class GroupsController < ApplicationController
  def index
  	@groups = Group.eager_load(:members).all
  	
  end

  def view
  	@group = Group.eager_load(:members).find_by(id: params[:id])
  	@creator = User.find(@group.user_id)
  	@you = 'YOU!'
  	@toggle_join_button = true
  end
  def create
  	# p params
  	@group = Group.new(group_params)
  	@group.user = current_user
  	if @group.valid?
  		@group.save
  		Member.create(user: current_user,group: Group.find(@group.id))
  		flash[:alert] = 'Group created!'
  	else
  		flash[:alert] = @group.errors.full_messages
  	end
  	redirect_to :back
  end
  def join
  	@joined = Member.create(user: current_user, group: Group.find(params[:group_id]))
  	redirect_to :back
  end
  def leave
  	member1 = Member.find_by(user: current_user, group_id: params[:group_id])
  	if member1
  		member1.destroy
  		@toggle_join_button = true
  		redirect_to :back
  	else
  		p 'cannot find'
  		redirect_to :back
  	end
  end
  def destroy
  	group = Group.destroy(params[:group_id])
  	if group.valid?
  		flash[:alert] = 'group deleted!'
  	end
  	redirect_to :back
  end
  private
  	def group_params
  		params.require(:group).permit(:name, :description)
  	end
end
