require 'acceptance_helper'

resource	'中层干部自评表查看修改' do
	header "Accept", "application/json"

	get '/middle_managers/self_evaluation' do
		middle_manager_attrs = FactoryGirl.attributes_for(:middle_manager)

		header "X-MiddleManager-Token", middle_manager_attrs[:authentication_token]
    header "X-MiddleManager-Job_num", middle_manager_attrs[:job_num]
    header "X-MiddleManager-Email", middle_manager_attrs[:email]

    before do
      @middle_manager = create(:middle_manager)
      @activity = create(:activity)
      create(:self_evaluation, middle_manager: @middle_manager,
      												 activity: @activity)
    end

    example "中层干部自评表查看成功" do
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


  # put '/middle_managers/self_evaluation' do
  #   user_attrs = FactoryGirl.attributes_for(:user)
  #   image_attrs = FactoryGirl.attributes_for(:image, photo_type: "avatar")

  #   header "X-User-Token", user_attrs[:authentication_token]
  #   header "X-User-Phone", user_attrs[:phone]

  #   parameter :nickname, "称谓", require: false, scope: :user_info
  #   parameter :mail, "邮箱", require: false, scope: :user_info
  #   parameter :avatar_attributes, "头像", require: false, scope: :user_info

  #   before do
  #     @user = create(:user)
  #   end

  #   let(:nickname) { "new nickname" }
  #   let(:mail) { "new mail" }
  #   let(:avatar_attributes) { image_attrs }


  #   example "中层干部 修改自评表成功" do
  #     do_request
  #     puts response_body
  #     expect(status).to eq(201)
  #   end
  # end

end	