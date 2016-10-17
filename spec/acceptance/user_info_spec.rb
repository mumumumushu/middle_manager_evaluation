require 'acceptance_helper'

resource	'用户个人信息 查看' do
	header "Accept", "application/json"

	get '/user_info' do
		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-User-Token", middle_manager_attrs[:authentication_token]
    header "X-User-JobNum", middle_manager_attrs[:job_num]

    before do
      @user = create(:middle_manager)
      create(:user_info, user: @user)
    end

    example "用户个人信息 查看 成功" do
      do_request
      puts response_body
      expect(status).to eq(200)
    end

	end	
end	