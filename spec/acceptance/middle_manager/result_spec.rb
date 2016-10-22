require 'acceptance_helper'

resource	'中层干部 测评结果 查看' do
	header "Accept", "application/json"

	get '/middle_managers/result' do

		user_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-User-Token", user_attrs[:authentication_token]
    header "X-User-JobNum", user_attrs[:job_num]

    before do
      @middle_manager = create(:middle_manager)
      create(:user_info, user: @middle_manager)

      @activity = create(:activity)
      @self_evaluation = create(:self_evaluation, 
                                  middle_manager: @middle_manager,
      												    activity: @activity)
      @leader = create(:leader)
      create_list(:evaluation, 2,
                     self_evaluation: @self_evaluation,
                     user: @leader) 
      create(:result, self_evaluation: @self_evaluation)


    end

    example "中层干部 测评结果 查看" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end


    # describe "用户没有访问权限" do
    #   staff_attrs = FactoryGirl.attributes_for(:wrong_type)

    #   header "X-User-Token", staff_attrs[:authentication_token]
    #   header "X-User-JobNum", staff_attrs[:job_num]
     
    #   example "用户类型错误" do    
    #     do_request
    #     puts response_body
    #     expect(status).to eq(401)
    #   end 
    # end

  end
end

