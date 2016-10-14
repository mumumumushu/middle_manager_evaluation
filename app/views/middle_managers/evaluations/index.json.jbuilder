json.current_page @evaluations.current_page
json.total_pages @evaluations.total_pages

json.evaluations @evaluations, partial: 'evaluations/evaluation', as: :evaluation