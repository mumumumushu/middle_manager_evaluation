require 'acceptance_helper'

resource	'中层干部 打分表 查看修改' do
	header "Accept", "application/json"

	get '/middle_managers/evaluations' do
		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-User-Token", middle_manager_attrs[:authentication_token]
    header "X-User-JobNum", middle_manager_attrs[:job_num]
    
    before do
      #当前用户 查看人
      @middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      #其他中层干部 被查看人 evaluations的拥有者
      @other_middle_manager = create(:middle_manager2)
      create(:user_info, user: @other_middle_manager)  #创建活动会创建self_evaluation  创建self_evaluation 会set_user_info 
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @other_middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @middle_manager)            
    end

    parameter :page, "当前页", require: false
    parameter :per_page, "每页的数量", require: false

    let(:page) {1}
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
      create(:user_info, user: @middle_manager)
      
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
    
    parameter :thought_morals, "思想道德情况. 项目与分数 英文逗号隔开，项目之间 英文分号隔开， 例：'项目1,80;项目2,70;项目3,60;项目4,90'", required: true, scope: :evaluation
    parameter :duties, "履行岗位职责情况", required: true, scope: :evaluation
    parameter :upright_incorruptiable, "廉洁自律情况", required: true, scope: :evaluation
    parameter :evaluation_totality, "总体评价", required: true, scope: :evaluation

    before do
      @middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
                                    self_evaluation: @self_evaluation,
                                    user: @middle_manager)
    end

    let(:thought_morals) { '{"new":90}' }
    let(:duties) { '{"new":90}'}
    let(:upright_incorruptiable) { '{"new":90}' }
    let(:evaluation_totality) { 99 }

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