require 'acceptance_helper'

resource	'中层干部 打分表 查看修改' do
	header "Accept", "application/json"

	get '/middle_managers/evaluations' do
		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-MiddleManager-Token", middle_manager_attrs[:authentication_token]
    header "X-MiddleManager-Job_num", middle_manager_attrs[:job_num]
    header "X-MiddleManager-Email", middle_manager_attrs[:email]

    before do
   
      @middle_manager = create(:middle_manager)
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @middle_manager)#<=====主键？===###
                ##!!!!!!!!!!!!!!!!!!!!!!!!!!#######
    end

    parameter :page, "当前页", require: false
    parameter :per_page, "每页的数量", require: false

    let(:page) {2}
    let(:per_page) {4}

    example "中层干部 打分表列表 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
	end	

  get '/middle_managers/evaluations/:id' do
    middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

    header "X-MiddleManager-Token", middle_manager_attrs[:authentication_token]
    header "X-MiddleManager-Job_num", middle_manager_attrs[:job_num]
    header "X-MiddleManager-Email", middle_manager_attrs[:email]

    before do
   
      @middle_manager = create(:middle_manager)
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, middle_manager: @middle_manager,
                               activity: @activity)

      @evaluations = create_list(:evaluation, 5,
                               self_evaluation: @self_evaluation,
                               evaluationable_type: 'middle_manager')#<========###
                ##!!!!!!!!!!!!!!!!!!!!!!!!!!#######
    end

    example "中层干部 打分表详情成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
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