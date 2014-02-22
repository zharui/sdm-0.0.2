class PositionsController < ApplicationController
	def index
		gon.channel = Channel.find(params[:channel]).id
		gon.publisher = Publisher.find(params[:publisher]).id
	end

	def get_positions	
		channel = Channel.find(params[:channel])
		positions = channel.positions.search(params[:searchType], params[:searchTxt])
		totalCount = positions.count()
		totalPage = totalCount / params[:pageSize] + 1
		start = (params[:pageNo] - 1) * params[:pageSize]
		stop = start + params[:pageSize] - 1
		page_no = params[:pageNo]
		if start >= totalCount
			positions = positions[0..params[:pageSize] - 1]
			page_no = 1
		else
			positions = positions[start..stop]
		end
		body_data = []
		positions.each do |position|
			record = {}
			record['id'] = position['id']
			record['name'] = position['name']
			record['url'] = position['url']
			record['status'] = State.find(position['state_id']).name
			record['type'] = AdType.find(position['adtype_id']).name
			record['material'] = Material.find(position['material_id']).name
			record['layout'] = Layout.find(position['layout_id']).name
			record['format'] = Format.find(position['format_id']).name
			record['dimension'] = Dimension.find(position['dimension_id']).name
			record['size'] = position['size']
			record['serving_type'] = ServingType.find(position['serving_id']).name
			record['payment_type'] = PaymentType.find(position['payment_id']).name
			record['time'] = position['updated_at']
			record['user'] = User.find(position['user_id']).name
			body_data.push(record)	
		end
		respond_to do |format|
			msg = {totalCount: totalCount, pageNo: page_no, pageSize: params[:pageSize], totalPage: totalPage, bodyData: body_data}.to_json
			format.json { render json: msg }
  	end
	end
	
	def new
		@position = Position.new
	end

	def edit
	end
	
	def create
	end
	
	def update
	end

	def destroy
	end
end
