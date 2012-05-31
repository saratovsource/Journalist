namespace :labels do
  desc "Add label to database"
  task :add, [:name, :css, :color] => [:environment] do |t, args|
    l = Label.create(args.with_defaults(:color => "blue"))
  end
end
