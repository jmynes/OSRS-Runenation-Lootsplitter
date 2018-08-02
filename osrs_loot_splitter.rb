# ------------------------------
# Runenation Tank's Loot Split Calculator!
# Author RSN: MSPaint
# ------------------------------


# ------------------------------
# What's the problem?
# ------------------------------

# The tank is given a 10% incentive for their work. How does that get calculated?

# Add commas to our output, this makes it much easier to read!
# Unfortunately, this was the best I could find on Stack Overflow for Ruby...
# Other solutions required Rails, and I intend to port this to JS probably.
def add_commas(number)
  number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{","}").reverse
end


# ------------------------------
# What are our parameters?
# ------------------------------

# How many players, how much gold in the pot? Assume only one tank exists.
players = 4
non_tank_players = players - 1

total_pot = 16137636


# ------------------------------
# How is the bonus calculated?
# ------------------------------

# The baseline split, without accounting for bonuses of any kind (used in Scenario C, or bonus-less scenarios)
base_split = total_pot / players
# The baseline split, for non-tank players in Scenarios A and B
base_split_for_scenario_A_and_B = (total_pot * 0.9) / players

# Scenario A's tank bonus is 10% of the total pot
scenario_A_tank_bonus = total_pot / 10.0

# Scenario B's tank bonus is ALSO 10% of the total pot
scenario_B_tank_bonus = scenario_A_tank_bonus

# Scenario C's tank bonus is 10% of an even baseline split
scenario_C_tank_bonus = base_split / 10.0


# ------------------------------
# What's the tank's payout?
# ------------------------------

# Scenario A's tank payout is 10% of the total pot, plus an even baseline split
scenario_A_tank_RECEIPT = scenario_A_tank_bonus + base_split

# Scenario A's tank payout is 10% of the total pot, plus a split of the remainder (baseline minus bonus)
scenario_B_tank_RECEIPT = scenario_B_tank_bonus + base_split_for_scenario_A_and_B

# Scenario C's tank payout is 110% of the even baseline split
scenario_C_tank_RECEIPT = base_split * 1.1


# ------------------------------
# What's left for division?
# ------------------------------

# Scenario A's remaining pot
scenario_A_total_after_tank = total_pot - scenario_A_tank_RECEIPT

# Scenario B's remaining pot
scenario_B_total_after_tank = total_pot - scenario_B_tank_RECEIPT

# Scenario C's remaining pot
scenario_C_total_after_tank = total_pot - scenario_C_tank_RECEIPT


# ------------------------------
# How much are non-tanks paid?
# ------------------------------

# Scenario A's non-tanks are paid
payout_for_dps_a = scenario_A_total_after_tank / (non_tank_players)

# Scenario B's non-tanks are paid
payout_for_dps_b = scenario_B_total_after_tank / (non_tank_players)

# Scenario C's non-tanks are paid
payout_for_dps_c = scenario_C_total_after_tank / (non_tank_players)

puts "----------------------------------"
puts "THE PROBLEM"
puts "----------------------------------"
puts "Tanks need incentives! But how do we calculate that?\n\n"
puts "(PLEASE NOTE: this rounds a couple of gp.)"
puts "Some precision is lost, but it's only a couple coins.\n\n"

puts "----------------------------------"
puts "THE THREE OPTIONS ARE AS FOLLOWS"
puts "----------------------------------"
puts "SCENARIO A: Tank is owed 10% of the total pot, + even split of the TOTAL pot\n\n"
puts "SCENARIO B: Tank is owed 10% of the total pot, + even split of the REMAINING pot\n\n"
puts "SCENARIO C: Tank is owed an even split, + 10% of that split\n\n"

puts "----------------------------------"
puts "IF THE WORLD WERE EASY"
puts "----------------------------------"

puts "The total pot is: #{add_commas(total_pot)} divided among _#{players}_ players\n\n"
puts "If split directly between #{players} players: #{add_commas(base_split)} gp each\n\n"

puts "----------------------------------"
puts "BUT THIS IS NOT A PERFECT WORLD"
puts "----------------------------------"
#if tank bonus is 10% of total pot (in the scenario where TOTAL_POT is considered)
puts "SCENARIO A, Tank's bonus is: #{add_commas(scenario_A_tank_bonus.round)} gp\n\n"

#if tank bonus is 10% of total pot (in the scenario where REMAINING_POT is considered)
puts "SCENARIO B, Tank's bonus is: #{add_commas(scenario_B_tank_bonus.round)} gp\n\n"

#if tank bonus is 10% higher share
puts "SCENARIO C, Tank's bonus is: #{add_commas(scenario_C_tank_bonus.round)} gp\n\n"

puts "----------------------------------"
puts "END PAYOUTS FOR TANK"
puts "----------------------------------"
#if 10% total bonus, with division upon REMAINING_TOTAL pot, tank receives
puts "SCENARIO A, tank is paid out a total of: #{add_commas(scenario_A_tank_RECEIPT.round)} gp\n\n"

#if 10% total bonus, with division upon ORIGINAL_TOTAL pot, tank receives
puts "SCENARIO B, tank is paid out a total of: #{add_commas(scenario_B_tank_RECEIPT.round)} gp\n\n"

#if 10% of the individual split, tank receives
puts "SCENARIO C, tank is paid out a total of: #{add_commas(scenario_C_tank_RECEIPT.round)} gp\n\n"

puts "----------------------------------"
puts "SPLIT THE REMAINING POOL"
puts "----------------------------------"

puts "SCENARIO A, Remaining pot to be divided evenly: #{add_commas(scenario_A_total_after_tank.round)} gp\n\n"
puts "SCENARIO B, Remaining pot to be divided evenly: #{add_commas(scenario_B_total_after_tank.round)} gp\n\n"
puts "SCENARIO C, Remaining pot to be divided evenly: #{add_commas(scenario_C_total_after_tank.round)} gp\n\n"

puts "----------------------------------"
puts "END PAYOUTS FOR NON-TANK"
puts "----------------------------------"

#ten percent of the total goes to tank, and the tank then splits based on the REMAINING_TOTAL
puts "SCENARIO A, even payout for non-tanks: #{add_commas(payout_for_dps_a.round)} gp each\n\n"

#ten percent of the total goes to tank, and the tank then splits based on the ORIGINAL_TOTAL
puts "SCENARIO B, even payout for non-tanks: #{add_commas(payout_for_dps_b.round)} gp each\n\n"

#ten percent of the split as a bonus to tank"
puts "SCENARIO C, even payout for non-tanks: #{add_commas(payout_for_dps_c.round)} gp each\n\n"
