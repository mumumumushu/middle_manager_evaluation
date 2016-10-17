require 'acceptance_helper'

resource	'领导 打分表 查看修改' do
	header "Accept", "application/json"

	get '/leaders/evaluations' do
		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)
    leader_attrs = FactoryGirl.attributes_for(:leader)

		header "X-Leader-Token", leader_attrs[:authentication_token]
    header "X-Leader-JobNum", leader_attrs[:job_num]

    before do
    	@leader = create(:leader)

   		@middle_manager = create(:middle_manager)
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @leader)            
    end

    parameter :page, "当前页", require: false
    parameter :per_page, "每页的数量", require: false

    let(:page) {2}
    let(:per_page) {4}

    example "领导 打分表列表 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
	end	

  get '/leaders/evaluations/:id' do
    middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)
    leader_attrs = FactoryGirl.attributes_for(:leader)

    header "X-Leader-Token", leader_attrs[:authentication_token]
    header "X-Leader-JobNum", leader_attrs[:job_num]

    before do
   
      @leader = create(:leader)

   		@middle_manager = create(:middle_manager)
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @leader)        
    end

    let(:id) {@evaluations.first.id}

    example "领导 打分表详情 查看成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end
  end 

  put '/leaders/evaluations/:id' do
    middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)
    leader_attrs = FactoryGirl.attributes_for(:leader)

    header "X-Leader-Token", leader_attrs[:authentication_token]
    header "X-Leader-JobNum", leader_attrs[:job_num]

    parameter :thought_morals, "思想道德情况", require: false, scope: :evaluation
    parameter :duties, "履行岗位职责情况", require: false, scope: :evaluation
    parameter :upright_incorruptiable, "廉洁自律情况", require: false, scope: :evaluation
    parameter :evaluation_totality, "总体评价", require: false, scope: :evaluation

    before do
      @leader = create(:leader)

   		@middle_manager = create(:middle_manager)
      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
                                  activity: @activity)

      @evaluations = create_list(:evaluation, 10,
      												      self_evaluation: @self_evaluation,
                                    user: @leader)  

    end

    let(:thought_morals) { "new thought_morals" }
    let(:duties) { "new upright_incorruptiable" }
    let(:upright_incorruptiable) { "new duties" }
    let(:evaluation_totality) { 100 }

    let(:id) {@evaluations.first.id}


    example "领导 打分表 修改成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end


end	