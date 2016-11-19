class Admin::FileOperationController < ApplicationController
  include ActionView::Layouts
  include ActionController::MimeResponds

  # acts_as_token_authentication_handler_for Admin

  # post 'admin/upload_user_list'
  def upload_user_list
  	@error = LoadUserList.load(params[:file].tempfile, File.dirname(__FILE__) + '/../../../')
  	# @error = {error: _error}
  	# respond_with @error, template: 'error'
  end

  #post 'admin/output_result_index'
  def output_result_index

    @activity = Activity.find(params[:activity_id])
    @results = Result.where(self_evaluation_id: @activity.self_evaluations.collect(&:id))
    _filename = params[:filename] || "#{@activity.activity_created_year}年中层干部考核成绩总表"
    respond_to do |format|
        format.xls {
            send_data xls_content_for_index(@results),#.force_encoding('binary'),
                :type => "text/excel;charset=utf-8; header=present",
                :filename => "#{_filename}.xls" 
        }
    end
  end

  #post 'admin/output_result_show'
  def output_result_show

    @result = Result.find(params[:result_id])
    _filename = params[:filename] || "#{@result.name}考核成绩详细表"
    respond_to do |format|
        format.xls {
            send_data xls_content_for_show(@result),#.force_encoding('binary'),
                :type => "text/excel;charset=utf-8; header=present",
                :filename => "#{_filename}.xls" 
        }
    end
  end

  #post 'admin/load_user_list_template'
  def load_user_list_template
    send_file File.dirname(__FILE__) + '/../../../用户信息上传模板.xlsx',
        :filename => "用户信息上传模板.xls"   
  end

private

  def xls_content_for_index results
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => "总表"

    blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
    sheet1.row(0).default_format = blue

    sheet1.row(0).concat %w{序号 干部姓名 领导评分 中层干部评分 员工评分 总分 等级}

    _leader_score_array = []
    _middle_manager_score_array = []
    _staff_score_array = []
    _average_score_for_all_array = []

    count_row = 1
    results.each do |result|
      sheet1[count_row, 0] = count_row
      sheet1[count_row, 1] = result.name
      sheet1[count_row, 2] = result.average_score_for_leader
      sheet1[count_row, 3] = result.average_score_for_middle_manager
      sheet1[count_row, 4] = result.average_score_for_staff
      sheet1[count_row, 5] = result.average_score_for_all
      sheet1[count_row, 6] = result.final_result
      count_row += 1

      _leader_score_array += [result.average_score_for_leader]
      _middle_manager_score_array += [result.average_score_for_middle_manager]
      _staff_score_array += [result.average_score_for_staff]
      _average_score_for_all_array += [result.average_score_for_all]
    end
    _level_array = ['优-数量','优-比例','良-数量','良-比例','中-数量','中-比例','差-数量','差-比例']
    1.upto(8) do |i|
    	# sheet1[i, 0] = i
      sheet1[results.count + i, 1] = _level_array[i - 1]
      sheet1[results.count + i, 2] = Result.change_socre_array_to_level_data(_leader_score_array).values[i - 1]
      sheet1[results.count + i, 3] = Result.change_socre_array_to_level_data(_middle_manager_score_array).values[i - 1]
      sheet1[results.count + i, 4] = Result.change_socre_array_to_level_data(_staff_score_array).values[i - 1]
      sheet1[results.count + i, 5] = Result.change_socre_array_to_level_data(_average_score_for_all_array).values[i - 1]
      # sheet1[results.count + i, 6] = result.final_result
    end
    # book.write "/Users/mushu/rails/middle_manager_evaluation/aa.xls"
    book.write xls_report
    xls_report.string
  end

  def xls_content_for_show result
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => "#{result.name}考核成绩详细表"

    blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10
    sheet1.row(0).default_format = blue

    _evaluations = result.self_evaluation.evaluations

    _all_score_array = []
    _evaluations.each do |evaluation|
      _all_score_array += [evaluation.score_array_filled + [evaluation.average_score]]
    end
    _item = ["思想道德 1", "思想道德 2", "思想道德 3", "岗位履职情况 1", "岗位履职情况 2", "岗位履职情况 3", "岗位履职情况 4", "岗位履职情况 5", "岗位履职情况 6", "岗位履职情况 7", "岗位履职情况 8", "岗位履职情况 9", "岗位履职情况 10", "岗位履职情况 11", "岗位履职情况 12", "廉洁自律情况 1", "廉洁自律情况 2", "总体评价", "总评计算"]

    _row_0 = ["评价项目"] + _evaluations.collect(&:evaluating_user_type) + ['优-数量','优-比例','良-数量','良-比例','中-数量','中-比例','差-数量','差-比例']
    sheet1.row(0).concat _row_0

    count_row = 1
    1.upto(_all_score_array[0].count) do |count_row| #行 评价项目
      sheet1[count_row, 0] = _item[count_row - 1]

      0.upto(_all_score_array.count - 1) do |count_column| #列 评价人 evaluation
        sheet1[count_row, count_column + 1] = _all_score_array[count_column][count_row]
      end

    end

    # book.write "/Users/mushu/rails/middle_manager_evaluation/aa.xls"
    book.write xls_report
    xls_report.string
  end
end