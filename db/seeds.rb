# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(name:"Emmanuel Croccel",cip:"croe1801",
                   email:"manu@outlook.fr",password:"foobar",
                   password_confirmation:"foobar")

user2 = User.create!(name:"Example Test",cip:"test1801",
                    email:"test@foobar.fr",password:"foobar",
                    password_confirmation:"foobar")



admin = Role.create!(role:"administrateur")
superv = Role.create!(role:"superviseur")
dev = Role.create!(role:"developpeur")

projectus = Project.create!(name:"Projectus")
pegasus = Project.create!(name:"Pegasus")
drone = Project.create!(name:"Drone Project")

user.roles_users.create!(role_id: admin.id)
user.roles_users.create!(role_id: superv.id)
user.roles_users.create!(role_id: dev.id)

user.assignements.create!(role_id: superv.id, project_id: projectus.id,active:true)
user.assignements.create!(role_id: admin.id, project_id: projectus.id,active:false)
user2.assignements.create!(role_id: admin.id, project_id: pegasus.id,active:true)
user2.assignements.create!(role_id: admin.id, project_id: projectus.id,active:false)
