# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dave = Employee.create!(name: 'Dave')
thomas = Employee.create!(name: 'Thomas')
ameh = Employee.create!(name: 'Ameh')
julius = Employee.create!(name: 'Julius')

dave.time_sheets.create!(billable_rate: 300, company: 'Fidelity', date: '2019-08-01', start_time: '09:00', end_time: '17:00')
dave.time_sheets.create!(billable_rate: 200, company: 'GLO', date: '2019-08-05', start_time: '09:00', end_time: '17:00')
dave.time_sheets.create!(billable_rate: 300, company: 'MTN', date: '2019-08-10', start_time: '09:00', end_time: '17:00')
thomas.time_sheets.create!(billable_rate: 400, company: 'Julius Berger', date: '2019-08-01', start_time: '09:00', end_time: '17:00')
thomas.time_sheets.create!(billable_rate: 600, company: 'Fidelity', date: '2019-08-10', start_time: '09:00', end_time: '17:00')
thomas.time_sheets.create!(billable_rate: 300, company: 'Zain', date: '2019-08-21', start_time: '09:00', end_time: '17:00')
thomas.time_sheets.create!(billable_rate: 100, company: 'MTN', date: '2019-08-30', start_time: '09:00', end_time: '17:00')
ameh.time_sheets.create!(billable_rate: 500, company: 'Julius Berger', date: '2019-08-01', start_time: '09:00', end_time: '17:00')
ameh.time_sheets.create!(billable_rate: 300, company: 'Fidelity', date: '2019-08-03', start_time: '09:00', end_time: '17:00')
ameh.time_sheets.create!(billable_rate: 300, company: 'Zain', date: '2019-08-11', start_time: '09:00', end_time: '17:00')
ameh.time_sheets.create!(billable_rate: 200, company: 'MTN', date: '2019-08-21', start_time: '09:00', end_time: '17:00')
julius.time_sheets.create!(billable_rate: 300, company: 'MTN', date: '2019-08-01', start_time: '09:00', end_time: '17:00')
julius.time_sheets.create!(billable_rate: 400, company: 'GLO', date: '2019-08-11', start_time: '09:00', end_time: '17:00')
