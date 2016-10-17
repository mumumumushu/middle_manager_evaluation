require 'acceptance_helper'

resource	'中层干部 打分表 查看修改' do
	header "Accept", "application/json"

	get '/middle_managers/evaluations' do
		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-User-Token", middle_manager_attrs[:authentication_token]
    header "X-User-JobNum", middle_manager_attrs[:job_num]
    
    before do
   
      @middle_manager = create(:middle_manager)
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @middle_manager)            
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

    header "X-User-Token", middle_manager_attrs[:authentication_token]
    header "X-User-JobNum", middle_manager_attrs[:job_num]
    
    before do
   
      @middle_manager = create(:middle_manager)
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
                                    self_evaluation: @self_evaluation,
                                    user: @middle_manager)    #evaluations belongs_to user        
    end

    let(:id) {@evaluations.first.id}

    example "中层干部 打分表详情 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end 

  put '/middle_managers/evaluations/:id' do
    middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

    header "X-User-Token", middle_manager_attrs[:authentication_token]
    header "X-User-JobNum", middle_manager_attrs[:job_num]
    
    parameter :thought_morals, "思想道德情况", require: false, scope: :evaluation
    parameter :duties, "履行岗位职责情况", require: false, scope: :evaluation
    parameter :upright_incorruptiable, "廉洁自律情况", require: false, scope: :evaluation
    parameter :evaluation_totality, "总体评价", require: false, scope: :evaluation

    before do
      @middle_manager = create(:middle_manager)
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
                                    self_evaluation: @self_evaluation,
                                    user: @middle_manager)
    end

    let(:thought_morals) { "new thought_morals" }
    let(:duties) { "new upright_incorruptiable" }
    let(:upright_incorruptiable) { "new duties" }
    let(:evaluation_totality) { 100 }

    let(:id) {@evaluations.first.id}


    example "中层干部 打分表 修改成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
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