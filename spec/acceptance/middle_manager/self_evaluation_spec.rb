require 'acceptance_helper'

resource	'中层干部 自评表 查看修改' do
	header "Accept", "application/json"

	get '/middle_managers/self_evaluation' do

		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-User-Token", middle_manager_attrs[:authentication_token]
    header "X-User-JobNum", middle_manager_attrs[:job_num]

    before do
      @middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      
      @activity = create(:activity)
      create(:self_evaluation, middle_manager: @middle_manager,
      												 activity: @activity,
                               duties: '项目1,99;项目2,99;项目3,99;项目4,99',
                               self_evaluation_totality: "优秀")
      
    end

    example "中层干部 自评表 查看 成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end

    describe "用户没有访问权限" do
      wrong_attrs = FactoryGirl.attributes_for(:wrong_type)

      header "X-User-Token", wrong_attrs[:authentication_token]
      header "X-User-JobNum", wrong_attrs[:job_num]
     
      example "用户类型错误" do    
        do_request
        puts response_body
        expect(status).to eq(401)
      end 
    end

  end



  put '/middle_managers/self_evaluation' do
    middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

    header "X-User-Token", middle_manager_attrs[:authentication_token]
    header "X-User-JobNum", middle_manager_attrs[:job_num]

    parameter :job, "从事及分管工作", required: true, scope: :user_info
    parameter :duties, "履行岗位职责情况", required: true, scope: :self_evaluation
    parameter :self_evaluation_totality, "自我总体评价", required: true, scope: :self_evaluation

    before do
      @middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)

      @activity = create(:activity)
      create(:self_evaluation, middle_manager: @middle_manager,
                               activity: @activity)
    end

    let(:job) { "基层党建工作、学生教育与管基层党建工作" }
    let(:duties) { '项目1,80;项目2,70;项目3,60;项目4,90' }
    let(:self_evaluation_totality) { "new 优秀" }


    example "中层干部 修改 自评表 成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

end	