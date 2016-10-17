require 'acceptance_helper'

resource	'中层干部 自评表 查看修改' do
	header "Accept", "application/json"

	get '/middle_managers/self_evaluation' do
		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-MiddleManager-Token", middle_manager_attrs[:authentication_token]
    header "X-MiddleManager-JobNum", middle_manager_attrs[:job_num]

    before do
      @middle_manager = create(:middle_manager)
      @activity = create(:activity)
      create(:self_evaluation, middle_manager: @middle_manager,
      												 activity: @activity)
    end

    example "中层干部 自评表 查看 成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end

    # describe "查询不存在的用户信息" do
    #   let(:openid) { "new openid" }
    #   example "用户查询不存在该微信openid的用户，返回错误的信息" do
    #     do_request
    #     puts response_body
    #     expect(status).to eq(404)
    #   end 
    # end
	end	


  put '/middle_managers/self_evaluation' do
    middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

    header "X-MiddleManager-Token", middle_manager_attrs[:authentication_token]
    header "X-MiddleManager-JobNum", middle_manager_attrs[:job_num]

    parameter :duties, "履行岗位职责情况", require: false, scope: :self_evaluation
    parameter :self_evaluation_totality, "自我总体评价", require: false, scope: :self_evaluation

    before do
      @middle_manager = create(:middle_manager)
      @activity = create(:activity)
      create(:self_evaluation, middle_manager: @middle_manager,
                               activity: @activity)
    end

    let(:duties) { "new duties" }
    let(:self_evaluation_totality) { "new 优秀" }


    example "中层干部 修改 自评表 成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

end	