# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

bets = [
	{user1: "Pitts", user2: "Sleeve", prop: "Big East Tourney Teams (5), Sleeve Under, Pitts Over", category: "NCAAB", wager: 20.00, date: "12/23/14", winner: "Pitts", paid: FALSE},
	{user1: "Owen", user2: "Sleeve", prop: "Lions (Shorty) v. Dolphins (Owen)", category: "NFL", wager: 5.00, date: "12/23/2014", winner: "Sleeve", paid: FALSE},
	{user1: "Sleeve", user2: "Owen", prop: "Pitts (Owen) v. Baxter (Shorty) FFB", category: "NFL", wager: 5.00, date: "12/23/2014", winner: "Sleeve", paid: FALSE},
	{user1: "Owen", user2: "Sleeve", prop: "Cowboys (Owen) v. Colts (Sleeve)", category: "NFL", wager: 5.00, date: "12/23/2014", winner: "Owen", paid: FALSE},
	{user1: "Sleeve", user2: "Pitts", prop: "Warriors (Pitts) v. Clippers (-2) (Shorty)", category: "NBA", wager: 5.00, date: "12/23/2014", winner: "", paid: FALSE},
	{user1: "Pitts", user2: "Owen", prop: "Pitt (-3.5)(Owen) v. Cinci (Pitts)", category: "NFL", wager: 5.00, date: "12/28/2014", winner: "Owen", paid: FALSE},
	{user1: "Sleeve", user2: "Owen", prop: "Jimmy G Completeion % over (Sleeve) under (Owen) 62.5%", category: "NFL", wager: 5.00, date: "12/28/2014", winner: "Owen", paid: FALSE},
	{user1: "Owen", user2: "Sleeve", prop: "Celtics make (Sleeve) or miss (Owen) playoffs", category: "NBA", wager: 20.00, date: "12/29/2014", winner: "Sleeve", paid: FALSE},
	{user1: "Pitts", user2: "Owen", prop: "Broncos will make (Pitts) or miss (Owen) superbowl", category: "NFL", wager: 10.00, date: "12/30/2014", winner: "Owen", paid: FALSE},
	{user1: "Pitts", user2: "Sleeve", prop: "Arizona (Pitts) v. Carolina (-6) (Sleeve)", category: "NFL", wager: 5.00, date: "1/3/2015", winner: "Sleeve", paid: FALSE},
	{user1: "Owen", user2: "Sleeve", prop: "Flacco throws pick v. NE", category: "NFL", wager: 5.00, date: "1/9/2015", winner: "Owen", paid: FALSE},
	{user1: "Sleeve", user2: "Owen", prop: "Matt Lauring watches (Owen) or doesn't watch (Sleeve) AFCCG at Owens", category: "NFL", wager: 5.00, date: "1/13/2015", winner: "Sleeve", paid: FALSE},
	{user1: "Sleeve", user2: "Owen", prop: "Packers (Sleeve) vs. Seahawks (-7.5) (Owen)", category: "NFL", wager: 10.00, date: "1/16/2015", winner: "Sleeve", paid: FALSE},
	{user1: "Owen", user2: "Pitts", prop: "Seahawks(-1)(Pitts) v. Patriots (Owen)", category: "NFL", wager: 15.00, date: "1/27/2015", winner: "Owen", paid: FALSE},
	{user1: "Sleeve", user2: "Owen", prop: "Seahawks 2015 regular season wins over (Owen) or under (Sleeve) 9", category: "NFL", wager: 20.00, date: "4/4/2015", winner: "", paid: FALSE},
	{user1: "Sleeve", user2: "Owen", prop: "Red Sox adavance past wild card game (Owen) or miss playoffs (Sleeve)", category: "MLB", wager: 20.00, date: "4/5/2015", winner: "Sleeve", paid: FALSE},
	{user1: "Lacey", user2: "Sleeve", prop: "Cavs will (Lacey) or won't (Sleeve) lost game in east playoffs", category: "NBA", wager: 30.00, date: "4/24/2015", winner: "Lacey", paid: FALSE},
	{user1: "Owen", user2: "Sleeve", prop: "McCoy (Owen) v. Tebow (Sleeve) in touchdowns", category: "NFL", wager: 17.00, date: "4/24/2015", winner: "", paid: FALSE},
	{user1: "Sleeve", user2: "Pitts", prop: "Brady plays week 1", category: "NFL", wager: 12.00, date: "5/14/2015", winner: "", paid: FALSE},
	{user1: "Pitts", user2: "Sleeve", prop: "Jimmy Rollins makes (Pitts) or does not make (Sleeve) HOF", category: "MLB", wager: 200.00, date: "7/26/2015", winner: "", paid: FALSE},
	{user1: "Pitts", user2: "Sleeve", prop: "Cole Hamels makes (Pitts) or does not make (Sleeve) HOF", category: "MLB", wager: 200.00, date: "7/26/2015", winner: "", paid: FALSE},
	{user1: "Owen", user2: "Pitts", prop: "Gronk (-3) (Owen) over Ertz (Pitts) TDs", category: "NFL", wager: 10.00, date: "8/9/2015", winner: "", paid: FALSE},
	{user1: "Owen", user2: "Pitts", prop: "Gronk (-15) (Owen) over Ertz (Pitts) Catches", category: "NFL", wager: 10.00, date: "8/9/2015", winner: "", paid: FALSE},
	{user1: "Owen", user2: "Pitts", prop: "Gronk (-200) (Owen) over Ertz (Pitts) Yards", category: "NFL", wager: 10.00, date: "8/9/2015", winner: "", paid: FALSE}
]

bets.each do |bet|
	Bet.create!(bet)
end

users = [
	{un: "Pitts", pw: "Pitts", email: "jonathanpitts17@gmail.com", mobile: 4843542060},
	{un: "Owen", pw: "Owen", email: "ojmurph@gmail.com", mobile: 5089654582},
	{un: "Sleeve", pw: "Sleeve", email: "brian.shortsleeve33@gmail.com", mobile: 5084144547},
	{un: "Lacey", pw: "Lacey", email: "jlacey33@gmail.com", mobile: 9782732652}
]

users.each do |user|
	User.create!(user)
end