require 'acceptance_helper'

resource	'管理员 统计结果 查看 与 设置 单位评鉴结果' do
	header "Accept", "application/json"

	get '/admin/results' do
		admin_attrs = FactoryGirl.attributes_for(:admin)

		header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    
    before do
    	create(:admin)
    	@middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      @leader = create(:leader)
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @leader)            

   		@results = create_list(:result, 5,
   																self_evaluation: @self_evaluation
             								)	
      
    end

    parameter :page, "当前页", require: false
    parameter :per_page, "每页的数量", require: false

    let(:page) {2}
    let(:per_page) {2}

    example "管理员 统计结果列表 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
	end	

	get '/admin/results/:id' do
		admin_attrs = FactoryGirl.attributes_for(:admin)

		header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    
    before do
    	create(:admin)
    	@middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      @leader = create(:leader)
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @leader
                                )            

   		@results = create_list(:result, 5,
   															self_evaluation: @self_evaluation
             													)	
      
    end

   		let(:id) {@results.first.id}

    example "管理员 统计详情 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
	end


	patch '/admin/results/:id/set_final_result' do
    admin_attrs = FactoryGirl.attributes_for(:admin)

		header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    parameter :final_result, "单位评鉴意见", require: true, scope: :result

    before do
    	create(:admin)
    	@middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      @leader = create(:leader)
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity
                                )
      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @leader
                                )            
   		@results = create_list(:result, 5,
   																self_evaluation: @self_evaluation
          														)	      
    end

    let(:final_result) { '优秀' }
    let(:id) {@results.first.id}


    example "管理员 设置 单位评鉴意见 成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end







end