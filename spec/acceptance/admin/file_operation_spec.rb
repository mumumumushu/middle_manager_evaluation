require 'acceptance_helper'

resource	'管理员 文件操作' do
	header "Accept", "application/json"
  describe "管理员" do

    admin_attrs = FactoryGirl.attributes_for(:admin)

    header "X-Admin-Token", admin_attrs[:authentication_token]
    header "X-Admin-Email", admin_attrs[:email]

    post 'admin/upload_user_list' do
    	parameter :file, "名单 仅(.xlsx)文件", required: true

    	example "管理员上传 用户信息 已设置错误信息提示" do
        puts "哈哈哈"
  		end
  	end

    get 'admin/output_result_index' do
      parameter :activity_year, "统计总表的 考核年度", required: true

      example "管理员 下载统计总表xls文件" do
        puts "哈哈哈"
      end
    end

    get 'admin/output_result_show' do
      parameter :result_id, "统计结果的 :id", required: true

      example "管理员 下载某人考核成绩统计详情表xls文件" do
        puts "哈哈哈"
      end
    end

    get 'admin/load_user_list_template' do

      example "管理员 下载 用户信息模板xlsx文件" do
        puts "哈哈哈"
      end
    end

  end
end

