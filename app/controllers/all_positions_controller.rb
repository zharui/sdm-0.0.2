class AllPositionsController < ApplicationController
	def index
	end

	def get_all_positions	
		positions = Position.search(params[:searchType], params[:searchTxt])
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
			record['publisher'] = Publisher.find(position['publisher_id']).name
			record['channel'] = Channel.find(position['channel_id']).name
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
		@position = Position.find(params[:id])
	end

	def create
		to_be_created = { name: params[:position][:name],
											url: params[:position][:url],
											publisher_id: Publisher.find_by(name: params[:position][:publisher_id]).id,
											channel_id: Channel.find_by(name: params[:position][:channel_id]).id,
											state_id: State.find_by(name: params[:position][:state_id]).id,
											adtype_id: AdType.find_by(name: params[:position][:adtype_id]).id,
											material_id: Material.find_by(name: params[:position][:material_id]).id,
											layout_id: Layout.find_by(name: params[:position][:layout_id]).id,
											format_id: Format.find_by(name: params[:position][:format_id]).id,
											dimension_id: Dimension.find_by(name: params[:position][:dimension_id]).id,
											size: params[:position][:size],
											serving_id: ServingType.find_by(name: params[:position][:serving_id]).id,
											payment_id: PaymentType.find_by(name: params[:position][:payment_id]).id,
											user_id: 1 }
		@position = Position.new(to_be_created)
		if @position.save
			redirect_to all_positions_path
		else
			render 'new'
		end
	end

	def update
		Position.update(params[:id],
						name: params[:position][:name],
											url: params[:position][:url],
											publisher_id: Publisher.find_by(name: params[:position][:publisher_id]).id,
											channel_id: Channel.find_by(name: params[:position][:channel_id]).id,
											state_id: State.find_by(name: params[:position][:state_id]).id,
											adtype_id: AdType.find_by(name: params[:position][:adtype_id]).id,
											material_id: Material.find_by(name: params[:position][:material_id]).id,
											layout_id: Layout.find_by(name: params[:position][:layout_id]).id,
											format_id: Format.find_by(name: params[:position][:format_id]).id,
											dimension_id: Dimension.find_by(name: params[:position][:dimension_id]).id,
											size: params[:position][:size],
											serving_id: ServingType.find_by(name: params[:position][:serving_id]).id,
											payment_id: PaymentType.find_by(name: params[:position][:payment_id]).id,
											user_id: 1)
		redirect_to	all_positions_path
	end

	def destroy
		Position.find(params[:id]).destroy
		session[:return_to] ||= request.referer	
		redirect_to session.delete(:return_to)
	end

end
