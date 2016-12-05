require 'acceptance_helper'

resource	'管理员 统计结果 查看 与 设置 单位评鉴结果' do
	header "Accept", "application/json"

  describe '管理员操作' do
    admin_attrs = FactoryGirl.attributes_for(:admin)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

      
    before do
    	create(:admin)
    	@middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      @leader = create(:leader)
      create(:user_info, user: @leader)

      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 1,
      												      self_evaluation: @self_evaluation,
                                    user: @leader)            

  		@results = create_list(:result, 3,
  																self_evaluation: @self_evaluation,
                                  activity_year: 2016
           								)	
      
    end

    get '/admin/results' do
      parameter :activity_year, "考核年度", required: true

      let(:activity_year) {2016}

      example "管理员 统计结果列表 查看成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end	

    get '/admin/results/:id' do
      before do
        @staff = create(:staff)
        @evaluations = @evaluations.concat create_list(:evaluation, 2,
                                    self_evaluation: @self_evaluation,
                                    user: @staff,
                                    evaluation_totality: 10)
      end

     	let(:id) {@results.first.id}

      example "管理员 某人统计结果详情 查看成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    get '/admin/results/:id/feedback_form' do

      let(:id) {@results.first.id}

      example "管理员 某人统计结果的 反馈表 查看成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end


    patch '/admin/results/:id/set_final_result' do

      parameter :final_result, "单位评鉴意见", required: true, scope: :result

      let(:final_result) { '优秀' }
      let(:id) {@results.first.id}


      example "管理员 设置 单位评鉴意见 成功" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

    get 'admin/evaluation_count' do 
      parameter :activity_year, "考核年度", required: true

      let(:activity_year) {2016}

      example "管理员 打分表填写情况 查看成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

  end

end