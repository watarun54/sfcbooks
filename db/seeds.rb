# rails db:seed
admin = User.new(name: 'admin', email: 'admin@test.com', password: 'password')
satou = User.new(name: 'satou', email: 'satou@test.com', password: 'password')
suzuki = User.new(name: 'suzuki', email: 'suzuki@test.com', password: 'password')
tanaka = User.new(name: 'tanaka', email: 'tanaka@test.com', password: 'password')
test1 = User.new(name: 'test1',email: 'test1@test.com', password: 'password')
test2 = User.new(name: 'test2',email: 'test2@test.com', password: 'password')


[admin, satou, suzuki, tanaka, test1, test2].each do |user|
  user.skip_confirmation!
  user.save!

  user.items.create(title: "Book1 of #{user.name}", status: 0, price: 1000, lecture: "心のオシャレ学", teacher: "田中太郎", memo: "表紙に若干のイタミあり。")
  user.items.create(title: "Book2 of #{user.name}", status: 1, price: 1500, lecture: "論理学", teacher: "小泉進次郎", memo: "全体的に良好な状態です。")
  user.items.create(title: "Book3 of #{user.name}", status: 2, price: 1800, lecture: "統計学", teacher: "福沢諭吉", memo: "値下げ交渉可能。")
end
