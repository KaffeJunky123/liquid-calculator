def print_amounts(ml_total=100, aroma_percent=0.05, nicotin_per_ml=3,
                  shot_concentration=18, target_vg=0.75)
  amount_shot = ml_total / shot_concentration.to_f * nicotin_per_ml
  amount_aroma = ml_total * aroma_percent
  amount_base = ml_total - amount_shot - amount_aroma
  base_vg = (ml_total * target_vg) - (amount_shot+amount_aroma) / 2.0
  base_pg = amount_base - base_vg
  printf("Total amount: #{ml_total}ml\nBase Amount: %.2fml(total) %.2fml(VG) %.2fml(PG)\nAroma Amount: %.2fml\n"+
         "Amount Shot: %.2fml\n", base_vg+base_pg, base_vg, base_pg, amount_aroma, amount_shot)
end

VALID = {'ml' => lambda{ |ml| Integer(ml,10)&.to_s==ml }, 'mg' => lambda { |mg| Float(mg)&.to_s == mg or Integer(mg,10)&.to_s == mg },
	 'percent' => lambda { |pc| Float(pc)&.between?(0,1) }}
CONVERT = {'ml' => lambda { |ml| Integer(ml, 10) }, 'mg' => lambda { |mg| Float(mg) },
           'percent' => lambda { |pc| Float(pc) }}

def read_unit(name, unit)
  puts "Enter #{name} in #{unit}: "
  begin
    input = gets&.chomp
    valid_input = VALID[unit].call(input)
    puts "invalid input" unless valid_input
  end until valid_input
  CONVERT[unit].call(input)
end

def read_amounts
  ml_total = read_unit('total', 'ml')
  aroma_percent = read_unit('aroma', 'percent')
  nicotin_per_ml = read_unit('target nicotine content', 'mg')
  shot_concentration = read_unit('shot nicotine content', 'mg')
  target_vg = read_unit('target VG', 'percent')
  print_amounts(ml_total, aroma_percent, nicotin_per_ml, shot_concentration, target_vg)
end

loop do
  read_amounts
  puts 'Press q to quit.'
  break if $stdin.getc == 'q'
end
