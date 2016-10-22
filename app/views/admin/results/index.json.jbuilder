json.current_page @results.current_page
json.total_pages @results.total_pages

json.results @results, partial: '/result', as: :result

