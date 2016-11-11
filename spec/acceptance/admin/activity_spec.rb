require 'acceptance_helper'

resource	'管理员 查看修改 考核活动' do
	header "Accept", "application/json"
  describe "管理员" do

    admin_attrs = FactoryGirl.attributes_for(:admin)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    before do
      create(:admin)
      @middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)
      @leader = create(:leader)
      
      @activities = create_list(:activity, 5)
    end

    get '/admin/activities' do

      parameter :page, "当前页", require: false
      parameter :per_page, "每页的数量", require: false

      let(:page) {2}
      let(:per_page) {2}

      example "管理员 考核活动列表 查看成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end	

    get '/admin/activities/:id' do

     	let(:id) {@activities.first.id}

      example "管理员 考核活动详情 查看成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    post '/admin/activities' do

      activity_attrs = FactoryGirl.attributes_for(:activity)

      parameter :first_phase_begin, "第一阶段【 中层干部填写自评表 】开始时间", required: true, scope: :activity
      parameter :second_phase_begin, "第二阶段【 领导，职工，中层干部填写打分表 】开始时间", required: true, scope: :activity
      parameter :third_phase_begin, "第三阶段【 中层干部查看考核结果统计表 】开始时间", required: true, scope: :activity
      parameter :third_phase_end, "第三阶段【 中层干部查看考核结果统计表 】结束时间", required: true, scope: :activity

      let(:first_phase_begin) { activity_attrs[:first_phase_begin] }
      let(:second_phase_begin) { activity_attrs[:second_phase_begin] }
      let(:third_phase_begin) { activity_attrs[:third_phase_begin] }
      let(:third_phase_end) { activity_attrs[:third_phase_end] }

      example "管理员 创建 考核活动 成功" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

    put '/admin/activities/:id' do

      activity_attrs = FactoryGirl.attributes_for(:activity)

      parameter :first_phase_begin, "第一阶段【 中层干部填写自评表 】开始时间", required: true, scope: :activity
      parameter :second_phase_begin, "第二阶段【 领导，职工，中层干部填写打分表 】开始时间", required: true, scope: :activity
      parameter :third_phase_begin, "第三阶段【 中层干部查看考核结果统计表 】开始时间", required: true, scope: :activity
      parameter :third_phase_end, "第三阶段【 中层干部查看考核结果统计表 】结束时间", required: true, scope: :activity

      let(:first_phase_begin) { "6666-10-1 00:00:00" }
      let(:second_phase_begin) { "6666-11-1 00:00:00" }
      let(:third_phase_begin) { "6666-12-1 00:00:00" }
      let(:third_phase_end) { "6666-12-30 00:00:00" }
      let(:id) {@activities.first.id}

      example "管理员 修改 考核活动 成功" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

  end
end