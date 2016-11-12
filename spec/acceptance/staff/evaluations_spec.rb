require 'acceptance_helper'

resource	'职工 打分表 查看修改' do
	header "Accept", "application/json"

	get '/staffs/evaluations' do
		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)
    staff_attrs = FactoryGirl.attributes_for(:staff)

		header "X-User-Token", staff_attrs[:authentication_token]
    header "X-User-JobNum", staff_attrs[:job_num]

    before do
    	@staff = create(:staff)

   		@middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @staff)            
    end

    parameter :page, "当前页", require: false
    parameter :per_page, "每页的数量", require: false

    let(:page) {2}
    let(:per_page) {4}

    example "职工 打分表列表 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end

    describe "用户没有访问权限" do
      staff_attrs = FactoryGirl.attributes_for(:wrong_type)

      header "X-User-Token", staff_attrs[:authentication_token]
      header "X-User-JobNum", staff_attrs[:job_num]
     
      example "用户类型错误" do    
        do_request
        puts response_body
        expect(status).to eq(401)
      end 
    end

	end	

  get '/staffs/evaluations/:id' do
    middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)
    staff_attrs = FactoryGirl.attributes_for(:staff)

    header "X-User-Token", staff_attrs[:authentication_token]
    header "X-User-JobNum", staff_attrs[:job_num]

    before do
   
      @staff = create(:staff)

   		@middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @staff)        
    end

    let(:id) {@evaluations.first.id}

    example "职工 打分表详情 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end 

  put '/staffs/evaluations/:id' do
    middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)
    staff_attrs = FactoryGirl.attributes_for(:staff)

    header "X-User-Token", staff_attrs[:authentication_token]
    header "X-User-JobNum", staff_attrs[:job_num]

    parameter :thought_morals, "思想道德情况. 项目与分数 英文逗号隔开，项目之间 英文分号隔开， 例：'项目1,80;项目2,70;项目3,60;项目4,90'", required: true, scope: :evaluation
    parameter :duties, "履行岗位职责情况", required: true, scope: :evaluation
    parameter :upright_incorruptiable, "廉洁自律情况", required: true, scope: :evaluation
    parameter :evaluation_totality, "总体评价", required: true, scope: :evaluation

    before do
      @staff = create(:staff)

   		@middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @staff)  

    end

    let(:thought_morals) { '{"new":90}' }
    let(:duties) { '{"new":90}'}
    let(:upright_incorruptiable) { '{"new":90}' }
    let(:evaluation_totality) { 99 }

    let(:id) {@evaluations.first.id}


    example "职工 打分表 修改成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end


end	