# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


attendance = Attendance.create([
{ employee_id: 14, status: "Present", check_in_time: "2023-05-01 12:06:00", check_out_time: "2023-05-01 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-02 12:06:00", check_out_time: "2023-05-02 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-03 12:06:00", check_out_time: "2023-05-03 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Absent", check_in_time: "2023-05-04 12:06:00", check_out_time: "2023-05-04 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-05 12:06:00", check_out_time: "2023-05-05 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-08 12:06:00", check_out_time: "2023-05-08 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-09 12:06:00", check_out_time: "2023-05-09 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Absent", check_in_time: "2023-05-10 12:06:00", check_out_time: "2023-05-10 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-11 12:06:00", check_out_time: "2023-05-11 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Absent", check_in_time: "2023-05-12 12:06:00", check_out_time: "2023-05-12 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-15 12:06:00", check_out_time: "2023-05-15 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-16 12:06:00", check_out_time: "2023-05-16 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Absent", check_in_time: "2023-05-17 12:06:00", check_out_time: "2023-05-17 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-18 12:06:00", check_out_time: "2023-05-18 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Leave", check_in_time: "2023-05-19 12:06:00", check_out_time: "2023-05-19 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-22 12:06:00", check_out_time: "2023-05-22 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Absent", check_in_time: "2023-05-23 12:06:00", check_out_time: "2023-05-23 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-24 12:06:00", check_out_time: "2023-05-24 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Leave", check_in_time: "2023-05-25 12:06:00", check_out_time: "2023-05-25 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-26 12:06:00", check_out_time: "2023-05-26 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-29 12:06:00", check_out_time: "2023-05-29 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Absent", check_in_time: "2023-05-30 12:06:00", check_out_time: "2023-05-30 18:06:00", hours_worked: 0.6e1},
{ employee_id: 14, status: "Present", check_in_time: "2023-05-31 12:06:00", check_out_time: "2023-05-31 18:06:00", hours_worked: 0.6e1}
])


# 20.times do |i|
#   puts "Creating Department #{i+1}"
#   Department.create(department_name: "backend  #{i+1}")
# end