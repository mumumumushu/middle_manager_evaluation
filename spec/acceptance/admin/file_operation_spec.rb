require 'acceptance_helper'

resource	'管理员 文件操作' do
	header "Accept", "application/json"
  describe "管理员" do

    admin_attrs = FactoryGirl.attributes_for(:admin)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    post 'admin/load_user_list' do
    	parameter :file, "名单 仅(.xlsx)文件； 现默认传入为中层干部", required: true

    	example "管理员上传 用户信息（现默认导入为中层干部, 未设置错误信息提示）" do

  		end
  	end

  end
end

