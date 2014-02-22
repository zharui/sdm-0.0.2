class ChannelsController < ApplicationController
	def index
		gon.publisher = Publisher.find(params[:publisher]).id
	end

	def get_channels	
		publisher = Publisher.find(params[:publisher])
		channels = publisher.channels.search(params[:searchType], params[:searchTxt])
		totalCount = channels.count()
		totalPage = totalCount / params[:pageSize] + 1
		start = (params[:pageNo] - 1) * params[:pageSize]
		stop = start + params[:pageSize] - 1
		page_no = params[:pageNo]
		if start >= totalCount
			channels = channels[0..params[:pageSize] - 1]
			page_no = 1
		else
			channels = channels[start..stop]
		end
		body_data = []
		channels.each do |channel|
			record = {}
			record['id'] = channel['id']
			record['name'] = channel['name']
			record['url'] = channel['url']
			record['status'] = State.find(channel['state_id']).name
			record['pnum'] = Position.find(:all, conditions: ['channel_id = ?', channel.id]).size
			record['time'] = channel['updated_at']
			record['user'] = User.find(channel['user_id']).name
			body_data.push(record)	
		end
		respond_to do |format|
			msg = {totalCount: totalCount, pageNo: page_no, pageSize: params[:pageSize], totalPage: totalPage, bodyData: body_data}.to_json
			format.json { render json: msg }
  	end
	end

	def new
		@channel = Channel.new
	end

	def create
		to_be_created = { name: params[:channel][:name],
											url: params[:channel][:url],
											state_id: State.find_by(name: params[:channel][:state_id]).id,
											publisher_id: params[:publisher].to_i,
											user_id: 1 }
		@channel = Channel.new(to_be_created)
		if @channel.save
			redirect_to action: :index, publisher: params[:publisher]
		else
			render action: :new, publisher: params[:publisher]
		end
	end

	def edit
		@channel = Channel.find(params[:id])
	end

	def update
		Channel.update(params[:id],
										name: params[:channel][:name],
										url: params[:channel][:url],
										state_id: State.find_by(name: params[:channel][:state_id]).id,
										user_id: 3)
		redirect_to action: :index, publisher: params[:publisher]
	end

	def destroy
		Channel.find(params[:id]).destroy
		session[:return_to] ||= request.referer	
		redirect_to session.delete(:return_to)
	end
end
