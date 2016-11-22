class Admin::FileOperationController < ActionController::Base
  include ActionView::Layouts
  include ActionController::MimeResponds
  # include ActionController::Helpers
  include ActionController::Flash
  # acts_as_token_authentication_handler_for Admin

  respond_to :json
  # post 'admin/upload_user_list'
  def upload_user_list
    #得到文件 输出密码文件password.txt
  	@error = UploadUserList.upload(params[:file].tempfile, File.dirname(__FILE__) + '/../../../')
  	@error = @error ? "上传失败，请检查信息表格式。 {error: #{@error}}" : "上传成功"
    respond_with @error, template: 'error'
  end

  #get 'admin/output_result_index'
  def output_result_index
    @activity = Activity.where(activity_created_year: params[:activity_year]).first
    @results = Result.where(self_evaluation_id: @activity.self_evaluations.collect(&:id))
    send_file xls_content_for_index(@results, create_file_name),
              filename: "#{@activity.activity_created_year}年中层干部考核统计结果总表"
  end

  #get 'admin/output_result_show'
  def output_result_show
    @result = Result.find(params[:result_id])
    send_file xls_content_for_show(@result, create_file_name),
            filename: "#{@result.name}考核成绩详细表"
  end

  #get 'admin/load_user_list_template'
  def load_user_list_template
    send_file File.dirname(__FILE__) + '/../../../用户信息上传模板.xlsx',
        :filename => "用户信息上传模板.xlsx"   
  end

private
  def create_file_name #only .xls
    _filename = ""
    chars = ('a'..'z').to_a + ('0'..'9').to_a
    1.upto(6) { |i| _filename << chars[rand(chars.size-1)] }
    if File.exist?(File.join("pubilc/file/","#{_filename}.xls"))
      create_file_name
    end
    "/home/edu/middle_manager_evaluation/pubilc/file/" +  _filename + '.xls'
  end

  def xls_content_for_index results,filename
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

    _path =  "#{filename}"
    book.write _path
    _path
  end

  def xls_content_for_show result,filename
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
    _path =  "#{filename}"
    book.write _path
    _path
  end
end