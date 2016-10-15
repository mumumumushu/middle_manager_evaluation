json.current_page @evaluations.current_page
json.total_pages @evaluations.total_pages

json.middle_manager_evaluations @evaluations, partial: '/evaluation', as: :evaluation