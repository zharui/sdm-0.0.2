class PublishersController < ApplicationController
	def index
	end

	def get_publishers
		publishers = Publisher.search(params[:searchType], params[:searchTxt])
		totalCount = publishers.count()
		totalPage = totalCount / params[:pageSize] + 1
		start = (params[:pageNo] - 1) * params[:pageSize]
		stop = start + params[:pageSize] - 1
		page_no = params[:pageNo]
		if start >= totalCount
			publishers = publishers[0..params[:pageSize] - 1]
			page_no = 1
		else
			publishers = publishers[start..stop]
		end
		body_data = []
		publishers.each do |publisher|
			record = {}
			record['id'] = publisher['id']
			record['name'] = publisher['name']
			record['url'] = publisher['url']
			record['status'] = State.find(publisher['state_id']).name
			record['cnum'] = Channel.find(:all, conditions: ['publisher_id = ?', publisher.id]).size
			record['pnum'] = Position.find(:all, conditions: ['publisher_id = ?', publisher.id]).size
			record['time'] = publisher['updated_at']
			record['user'] = User.find(publisher['user_id']).name
			body_data.push(record)	
		end
		respond_to do |format|
			msg = {totalCount: totalCount, pageNo: page_no, pageSize: params[:pageSize], totalPage: totalPage, bodyData: body_data}.to_json
			format.json { render json: msg }
  	end
	end

	def new
		@publisher = Publisher.new
	end

	def create
		to_be_created = { name: params[:publisher][:name],
											url: params[:publisher][:url],
											state_id: State.find_by(name: params[:publisher][:state_id]).id,
											user_id: 1 }
		@publisher = Publisher.new(to_be_created)
		if @publisher.save
			redirect_to publishers_path
		else
			render 'new'
		end
	end

	def edit
		@publisher = Publisher.find(params[:id])
	end
	
	def update
		Publisher.update(params[:id],
										name: params[:publisher][:name],
										url: params[:publisher][:url],
										state_id: State.find_by(name: params[:publisher][:state_id]).id,
										user_id: 2)
		redirect_to publishers_path	
	end

	def destroy
		Publisher.find(params[:id]).destroy
		session[:return_to] ||= request.referer	
		redirect_to session.delete(:return_to)
	end

end
