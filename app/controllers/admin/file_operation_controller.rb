# class Admin::FileOperationController < ApplicationController
#   # include ActionView::Layouts
#   # include ActionController::MimeResponds

#   # acts_as_token_authentication_handler_for Admin

#   # post 'admin/load_user_list'
#   def load_user_list
#   	@error = LoadUserList.load(params[:file].tempfile, File.dirname(__FILE__) + '/../../../')
#   	# @error = {error: _error}
#   	# respond_with @error, template: 'error'
#   end


#   def output_result_index
#   	@activity = Activity.find(params[:activity_id])

#   end





# def output_result_index
#   @activity = Activity.find(params[:activity_id])
#   respond_to do |format|
#       format.xls {
#           send_data( xls_content_for_index(@activity.results),
#               :type => "text/excel;charset=utf-8; header=present",
#               :filename => "#{params[:filename}.xls" )
#       }
#   end
# end

# private

# def xls_content_for_index(results)
#     xls_report = StringIO.new
#     book = Spreadsheet::Workbook.new
#     sheet1 = book.create_worksheet :name => "报名统计"

#     blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
#     sheet1.row(0).default_format = blue

#     sheet1.row(0).concat %w{序号 干部姓名 领导评分 中层干部评分 员工评分 总分 等级}
#     count_row = 1
#     results.each do |result|
#       sheet1[count_row, 0] = count_row
#       sheet1[count_row, 1] = result.name
#       sheet1[count_row, 2] = result.average_score_for_leader
#       sheet1[count_row, 3] = result.average_score_for_middle_manager
#       sheet1[count_row, 4] = result.average_score_for_staff
#       sheet1[count_row, 5] = result.average_score_for_all
#       sheet1[count_row, 6] = result.final_result
#       count_row += 1

#       _leader_score_array += [result.average_score_for_leader]
#       _middle_manager_score_array += [result.average_score_for_middle_manager]
#       _staff_score_array += [result.average_score_for_staff]
#       _average_score_for_all_array += [result.average_score_for_all]
#     end
#     _level_array = ['优-数量''优-比例''良-数量''良-比例''中-数量''中-比例''差-数量''差-比例']
#     1.upto(8) do |i|
#     	# sheet1[i, 0] = i
#       sheet1[results.count + i, 1] = result.name
#       sheet1[results.count + i, 2] = Result.change_socre_array_to_level_data(_leader_score_array).values[i]
#       sheet1[results.count + i, 3] = Result.change_socre_array_to_level_data(_middle_manager_score_array)
#       sheet1[results.count + i, 4] = Result.change_socre_array_to_level_data(_staff_score_array)
#       sheet1[results.count + i, 5] = Result.change_socre_array_to_level_data(_average_score_for_all_array)
#       # sheet1[results.count + i, 6] = result.final_result
#     end

#     book.write xls_report
#     xls_report.string
# end

# end