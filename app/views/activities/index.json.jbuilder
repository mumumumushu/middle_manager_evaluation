json.current_page @activities.current_page
json.total_pages @activities.total_pages

json.activities @activities, partial: 'activities/activity', as: :activity