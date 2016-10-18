require 'acceptance_helper'

resource	'管理员 统计结果 查看 与 设置 单位评鉴结果' do
	header "Accept", "application/json"

	get '/middle_managers/evaluations' do
		admin_attrs = FactoryGirl.attributes_for(:admin)

		header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    user_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-JobNum", user_attrs[:job_num]
    
    before do
    	# create(:admin)
    	@middle_manager = create(:middle_manager)
      # create(:user_info, user: @middle_manager)
      # @other_middle_manager = create(:middle_manager2)
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      # @evaluations = create_list(:evaluation, 10,
      # 												      self_evaluation: @self_evaluation,
      #                               user: @other_middle_manager)            

   		create_list(:result, 5,
   																self_evaluation: @self_evaluation,
   																final_result: "?"
   								)	
      
    end

    parameter :page, "当前页", require: false
    parameter :per_page, "每页的数量", require: false

    let(:page) {2}
    let(:per_page) {4}

    example "管理员 统计结果列表 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
	end	






end